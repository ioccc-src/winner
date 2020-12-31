Most obfuscated sound:

    Pierre-Philippe Coupard
    Lineo, Inc.
    ATTN : Pierre-Philippe Coupard
    390 South 400 West
    Lindon, UT 84042
    USA


Judges' Comments:

    To build:

    	make coupard

    Try:

	 ./coupard > /dev/audio
     -or-
         ./coupard > /dev/sound/dsp

    You may need to run this a few times to understand exactly what is
    being said.  You might even need to look somewhere on your desktop,
    your arm or the wall for confirmation.


Selected Author's Comments:

    Past years' IOCCC entries do many marvellous things in small packages,
    such as console utilities, games, math, languages or even X
    applications.  But they all have one thing in common (despite being hard
    to read obviously) : when they interact with the user, they only
    *display* things, i.e. they display either text or drawings.

    So, for a change, this program titillates the sense of hearing instead
    of sight : this program is a self-contained speech synthesizer that
    tells the current time through the computer's sound card - in just under
    2 Kb of source code !

    In the 2001 IOCCC rules and guidelines documents, there is no mention of
    what is or isn't acceptable regarding audio I/Os, but it is mentioned
    that hardware-specific and/or non-portable programs are not welcome. So,
    in order to do audio and satisfy those requirements, the format required
    by /dev/audio has been chosen : /dev/audio is a rather ancient
    fixed-format audio interface that is supported by the majority of Unices
    that can do sound, as a lowest-denominator sound I/Os interface.

    Program usage :

      * To listen to what the program says directly, invoke

          ./coupard > /dev/audio

        the program then speaks out something like

          "The time is HH hours MM minutes SS seconds"

       in military time (24 hours). Of course, you need to have permissions
       to write to /dev/audio, have your sound card enabled, the volume up,
       the speakers connected ... :-)

      * If you want to convert the audio output of the program into another
        audio format, you can pipe it to sox for example (sox is the
	Swiss army knife of Unix audio tools) : the command

          ./coupard | sox -c1 -r8000 -tub - -c2 -r44100 -twav test.wav

        converts the output of the program into a 44.1KHz stereo .WAV
        file and saves it into "test.wav".

        The output format of the program is 8KHz, unsigned 8-bit samples.

      NOTE : the program's return code is meaningless

    Audio quality :

      The quality of the sound produced by the program is cross between a
      yogurt-pot-and-string telephone and a bad gramophone, i.e. the S/N
      ratio is very low and the signal's top frequency is very low as well.
      This is because the audio is stored internally at a sampling rate of
      4KHz (the Nyquist frequency is only 2KHz) with only 4-bit samples
      (adding 24db of quantization noise to an already poor signal).

      In short, you might have to listen twice to understand what the
      program is saying. 2048 bytes including the sound generation program
      doesn't leave much room for audio quality ;-)

    Speech generation :

      Only 9 phonemes are used to generate the speech. Beside the limited
      number of words the program has to generate (66 words), the low sound
      quality is actually exploited to take liberties with certain
      consonants (for example, "s" and "f" sound very much the same at 4KHz,
      so they can be merged into one phoneme). Because the psychoacoustic
      context around those phonemes is just sufficient, the words can be
      interpreted correctly most of the time despite the fact that they are
      pronounced quite wrongly.

      Internally, a table is used to generate most of the words, and
      composite words such as "thirty-five" are made up by the C code
      externally.

    Data compression :

      Even at 4KHz / 4 bits, the weight of all the phoneme samples and the
      word-to-phonemes table put together is over 1600 bytes, which is well
      over 2048 bytes when encoded in a C string made of printable
      characters.  Therefore, a compression method was needed that's both
      efficient and with a decompressor that is implementable in the
      shortest amount of code possible. GSM compression is very good, but
      needs large psychoacoustic tables to regenerate the original
      signal. Raw FFT spectral compression is efficient too, but the
      decompression code can't be made small enough.

      The best compression compromise was found using a simple Huffman
      compressor, and encoding the compressed data by blocks of 13 bits in
      pairs of printable ASCII characters : the raw data is compressed to
      8465 bits, and the resulting C string is therefore about 1300
      characters, which leaves just enough room for the decompressor with a
      hard-coded Huffman tree, and the code that plays the phonemes in the
      right order.

    Note on compiler warnings and lint :

      The program should build with gcc's -Wall -Werror and -ansi flags.  If
      the -pedantic flag is used, gcc will complain about the length of the
      data string and the sign of its type, and also the fact that main()
      returns with no value. The confusion with the sign of the char type
      doesn't matter with the data string because it's composed only of
      printable characters under 127.

      When linting the program with lclint, it complains about a huge list
      of things that, if corrected to make lint happy, would probably double
      the size of the source code.

