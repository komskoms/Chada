
#include <SoftwareSerial.h>

SoftwareSerial bluetooth(D4, D5);


int      ledPin = D6;
int      userInput;
String   userString;
int      val;

void setup()
{
  pinMode(ledPin, OUTPUT);
  Serial.begin(9600);
  bluetooth.begin(9600);
}

void loop()
{
  // send data only when you receive data:
  if (Serial.available() > 0) {
    // read the incoming byte:
    userString = Serial.readStringUntil('\n');

    // say what you got:
    Serial.print("console received: ");
    Serial.println(userString);

    bluetooth.print("console received: ");
    bluetooth.println(userString);
  }
  if (bluetooth.available() > 0){
    userString = bluetooth.readStringUntil('\n');

    Serial.print("bt received: ");
    Serial.println(userString);    

    bluetooth.print("bt received: ");
    bluetooth.println(userString);
    }
    
    val = userString.toInt();
    //analogWrite(D6, val);
    digitalWrite(D6, val);
}
