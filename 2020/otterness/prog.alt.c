#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>

uint16_t ReadBigEndian16(uint8_t *c) {
  return *(c + 1) | (uint16_t) (*c) << 8;
}

void WriteBigEndian16(uint8_t *c, uint16_t v) {
  c[1] = v;
  c[0] = v >> 8;
}

uint32_t ReadBigEndian32(uint8_t *c) {
  return (uint32_t) ReadBigEndian16(c) << 16 | ReadBigEndian16(c + 2);
}

void WriteBigEndian32(uint8_t *c, uint32_t v) {
  WriteBigEndian16(c + 2, v);
  WriteBigEndian16(c, v >> 16);
}

// Fills in the *value. Returns the length in bytes.
int ReadVarInt(uint8_t *content, uint32_t *value) {
  int i;
  uint8_t b;
  *value = 0;
  for (i = 0; i < 4; i++) {
    b = content[i];
    *value |= b & 0x7f;
    if (!(b & 0x80)) return i + 1;
    *value = *value << 7;
  }
  fprintf(stderr, "Bad variable int.\n");
  exit(1);
}

uint8_t HighestBit(uint32_t n) {
  uint8_t r = 1;
  if (!n) return 0;
  while (n >>= 1) r++;
  return r;
}

uint8_t VarIntBytes(uint32_t n) {
  uint8_t bits = HighestBit(n);
  return bits / 7 + !!(bits % 7);
}

int WriteVarInt(uint32_t n, uint8_t *c) {
  uint8_t bytes_needed = VarIntBytes(n);
  *c = 0;
  if (!n) return bytes_needed;
  if (bytes_needed > 4) {
    fprintf(stderr, "Int too big for MIDI.\n");
    exit(1);
  }
  c += bytes_needed - 1;
  while (n != 0) {
    *c = n & 0x7f;
    n = n >> 7;
    c--;
  }
  return bytes_needed;
}

// Advances past the next MIDI message, returning a pointer after it, and
// updating running status if necessary.
uint8_t* AdvancePastMessage(uint8_t *c, uint8_t *running_status) {
  uint32_t tmp;
  uint8_t b;
  switch (*c) {
  case 0xf0:
  case 0xf7:
    // Skip past system exclusive messages
    *running_status = 0;
    c++;
    c += ReadVarInt(c, &tmp);
    return c + tmp;
  case 0xff:
    // Skip past meta events
    *running_status = 0;
    c++;
    c++;
    c += ReadVarInt(c, &tmp);
    return c + tmp;
  }
  // We're assuming this is a channel voice message now.
  if (*c & 0x80) {
    // Advance past the new status byte.
    b = *c;
    c++;
    *running_status = b;
  } else {
    b = *running_status;
  }
  // Just test the different channel voice message types.
  switch (b >> 4) {
    case 8:
    case 9:
    case 10:
    case 11:
    case 14:
      return c + 2;
    case 12:
    case 13:
      return c + 1;
  }
  fprintf(stderr, "Bad message status byte: %x\n", b);
  exit(1);
  return c;
}

// Assumes we're pointing at the start of a MTrk. Returns a pointer to the
// start of the next track.
uint8_t* GetTrackTicks(uint8_t *c, uint32_t *ticks) {
  uint32_t length, tmp;
  uint8_t *end;
  uint8_t running_status = 0;
  *ticks = 0;
  if (c[3] != 'k') {
    fprintf(stderr, "Not at a track start.\n");
    exit(1);
  }
  length = ReadBigEndian32(c + 4);
  c += 8;
  end = c + length;
  while (c < end) {
    c += ReadVarInt(c, &tmp);
    *ticks += tmp;
    c = AdvancePastMessage(c, &running_status);
  }
  return c;
}

// Requires a pointer to the start of the first track, and the total number of
// tracks.
uint32_t GetHighestTrackTicks(uint8_t *c, int track_count) {
  uint32_t tmp, max = 0;
  int i;
  for (i = 0; i < track_count; i++) {
    c = GetTrackTicks(c, &tmp);
    fprintf(stderr, "Track %d: %u ticks\n", i, (unsigned) tmp);
    if (tmp > max) max = tmp;
  }
  return max;
}

void DumpHex(uint8_t *data, int size) {
  int i;
  for (i = 0; i < size; i++) {
    fprintf(stderr, "%p + %d: 0x%02x\n", data, i, data[i]);
  }
}

uint8_t *beat = NULL;
uint8_t *note_off_note = NULL;
// Writes a beat at the given offset. Requires the beat size.
uint8_t* WriteBeat(uint8_t *c, int i, int bs) {
  uint8_t n = 42, v = 80;
  if ((i % 4) == 0) {
    n = 36;
    v = 120;
  } else if ((i % 4) == 2) {
    n = 40;
    v = 100;
  }
  beat[1] = n;
  beat[2] = v;
  *note_off_note = n;
  memcpy(c, beat, bs);
  return c + bs;
}

void WriteBootsAndCats(uint8_t *c, uint32_t length) {
  uint16_t ticks_per_beat, track_count;
  uint32_t beats_to_generate, tmp, data_size, beat_size;
  uint8_t *cur, *data = NULL;
  track_count = ReadBigEndian16(c + 10);
  ticks_per_beat = ReadBigEndian16(c + 12) >> 1;
  if (ticks_per_beat >> 15) {
    fprintf(stderr, "SMPTE timing isn't supported\n");
    exit(1);
  }
  beats_to_generate = GetHighestTrackTicks(c + 14, track_count) / ticks_per_beat;
  // A "beat" is simply a note-on followed by a note-off event. The tricky part
  // is the delta time may be more than one byte. We'll assume running status.
  // Note on = 00 <note> <velocity>
  // Note off = <delta time> <note> 00
  beat_size = 5 + VarIntBytes(ticks_per_beat);
  beat = malloc(beat_size);
  if (!beat) {
    fprintf(stderr, "Failed allocating beat.\n");
    exit(1);
  }
  // This requires 8 bytes in the track header + 4 bytes for end-of-track +
  // the track data, plus an additional byte to set up running status in the
  // first beat.
  data_size = beats_to_generate * beat_size + 13;
  data = malloc(data_size);
  if (!data) {
    fprintf(stderr, "Failed allocating data.\n");
    exit(1);
  }
  fprintf(stderr, "Data size: %d (0x%x), beat size %d, # beats %d\n",
    (int) data_size, data_size, beat_size, beats_to_generate);
  memcpy(data, "MTrk", 4);
  WriteBigEndian32(data + 4, data_size - 8);
  fprintf(stderr, "Data size: %d\n", (int) data_size);

  // Build the "beat" data
  cur = beat;
  *cur++ = 0;
  // Initial note number and velocity.
  *cur++ = 36;
  *cur++ = 120;
  cur += WriteVarInt(ticks_per_beat, cur);
  // Keep a pointer to where to write the note to turn off
  note_off_note = cur;
  *cur++ = 36;
  // The note-off velocity is 0.
  *cur = 0;

  cur = data + 8;
  // Write the first note-on and off:
  *cur++ = 0;
  *cur++ = 0x99;
  memcpy(cur, beat + 1, beat_size - 1);
  cur += beat_size - 1;
  for (tmp = 1; tmp < beats_to_generate; tmp++) {
    cur = WriteBeat(cur, tmp, beat_size);
  }
  *cur++ = 0;
  *cur++ = 0xff;
  *cur++ = 0x2f;
  *cur = 0;
  // Update the original MIDI header to increment the track count and make sure
  // the format is 1.
  c[9] = 1;
  WriteBigEndian16(c + 10, track_count + 1);
  fwrite(c, length, 1, stdout);
  fwrite(data, data_size, 1, stdout);
}

int main(int argc, char **argv) {
  FILE *f = NULL;
  uint8_t *content = NULL;
  long size = 0;
  int result;
  if (argc != 2) {
    fprintf(stderr, "Usage: %s <filename>\n", argv[0]);
    return 1;
  }
  f = fopen(argv[1], "rb");
  if (!f) {
    fprintf(stderr, "Coudn't open %s\n", argv[1]);
    return 1;
  }
  fseek(f, 0, SEEK_END);
  size = ftell(f);
  fseek(f, 0, SEEK_SET);
  content = malloc(size);
  if (!content) {
    fprintf(stderr, "Couldn't allocate content buffer.\n");
    fclose(f);
    return 1;
  }
  result = fread(content, size, 1, f);
  fclose(f);
  if (result != 1) {
    fprintf(stderr, "Couldn't read %s.\n", argv[1]);
    free(content);
    return 1;
  }
  if ((content[3] != 'd') || (content[7] != 6)) {
    fprintf(stderr, "Bad MIDI file.\n");
    free(content);
    return 1;
  }
  WriteBootsAndCats(content, size);
  free(content);
  return 0;
}
