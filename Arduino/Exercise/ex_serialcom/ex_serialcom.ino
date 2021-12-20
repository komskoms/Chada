int      userInput;
String   userString;
int      val;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:

  // send data only when you receive data:
  if (Serial.available() > 0) {
    // read the incoming byte:
    userString = Serial.readStringUntil('\n');

    // say what you got:
    Serial.print("I received: ");
    Serial.println(userString);
    }

    val = userString.toInt();
    analogWrite(D6, val);
}
