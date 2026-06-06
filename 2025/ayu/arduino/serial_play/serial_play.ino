#include "prog.h"

#define BUZZER_PIN A5
#define BUTTON_PIN _button_pins
static const int _button_pins[4] = {A0, 7, 8, A1};

int buttons()
{
  int result = -1;
#ifdef BUTTON_PIN
  static bool down[4] = { 0 };
  for (int i = 0; i < 4; i++) {
    bool cur_down = !digitalRead(BUTTON_PIN[i]);
    if (!down[i] && cur_down) result = "ACBD"[i];
    down[i] = cur_down;
  }
  if (result != -1) delay(10);
#endif
  return result;
}

int a(int c)
{
  if (c) {
    if (c == '\n') Serial.write('\r');
    Serial.write(c);
    return c;
  } else {
    int b;
    while (!Serial.available() && (b = buttons()) == -1) { }
    return b != -1 ? o >= 4 ? '\n' : b : (c = Serial.read()) == '\r' ? '\n' : c;
  }
}
void b(int p)
{
#ifdef BUZZER_PIN
  int16_t l = ((p + '-') & -256), S, E = 144 - (p -= l) - l;
  if (E) {
    tone(BUZZER_PIN, 440), delay(22);
    if (l) {
      if (p)
        tone(BUZZER_PIN, abs(p) * 36.67), delay(l * 0.2);
      else
        for (int i = 0; i < l * 0.2; i++)
          tone(BUZZER_PIN, 420 - i * 20), delay(1);
    }
    noTone(BUZZER_PIN);
  }
#endif
}
unsigned d()
{
  return millis() + analogRead(A0) + analogRead(A1) + analogRead(A2) + analogRead(A3);
}

void setup()
{
#ifdef BUZZER_PIN
  pinMode(BUZZER_PIN, OUTPUT);
#endif

#ifdef BUTTON_PIN
  for (int i = 0; i < 4; i++)
    pinMode(BUTTON_PIN[i], INPUT_PULLUP);
#endif

  Serial.begin(115200);
}

void loop()
{
  L();
}
