#include <Arduino.h>
#include <SPI.h>
#include <mcp_can.h>

// Set INT to pin 2
# define CAN_INT 2
const uint8_t ledPin = 15; // PWM pin for the backlight

// Set CS to pin 10
MCP_CAN CAN(0);

void setup() {
    Serial.begin(9600);
    while(!Serial) ;

//    for (int fadeValue = 0 ; fadeValue <= 1023; fadeValue += 8)
//    {
//        // Sets the value (range from 0 to 1023):
//        analogWrite(ledPin, fadeValue);
//        // Wait for 30 milliseconds to see the dimming effect
//        delay(30);
//    }

if(CAN.begin(MCP_ANY, CAN_500KBPS, MCP_16MHZ) == CAN_OK)
    {
        Serial.println("MCP2515 Initialized Successfully!");
        delay(1000);
    }
    else
    {
        Serial.println("Error Initializing MCP2515...");
        delay(2000);
        setup();
    }


//    while (CAN_OK != CAN.begin(MCP_ANY, CAN_500KBPS, MCP_16MHZ)) {
//        Serial.println("CAN init fail, retry...");
//        delay(1000);
//    }
    Serial.println("CAN init ok!");
    //set_mask_filt();
}

void loop() {
    // int __speed = 0;
    // int ret = getSpeed(&__speed);

    // if(ret)
    // {
    //     Serial.print("Vehicle Speed: ");
    //     Serial.print(__speed);
    //     Serial.println(" kmh");
    // }
    // delay(500);
}
