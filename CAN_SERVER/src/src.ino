#include <Arduino.h>
#include <SPI.h>
#include "hpp/mcp_can.h"
#include "hpp/OBDPower.h"

#define SPI_CS_PIN  9

MCP_CAN CAN(SPI_CS_PIN);
OBDPower obd(A3);

// #define PID_ENGIN_PRM       0x0C
// #define PID_COOLANT_TEMP    0x05
#define PID_VEHICLE_SPEED   0x0D
#define CAN_ID_PID          0x7DF

void set_mask_filt()
{
    // set mask, set both the mask to 0x3ff

    CAN.init_Mask(0, 0, 0x7FC);
    CAN.init_Mask(1, 0, 0x7FC);

    // set filter, we can receive id from 0x04 ~ 0x09

    CAN.init_Filt(0, 0, 0x7E8);                 
    CAN.init_Filt(1, 0, 0x7E8);

    CAN.init_Filt(2, 0, 0x7E8);
    CAN.init_Filt(3, 0, 0x7E8);
    CAN.init_Filt(4, 0, 0x7E8); 
    CAN.init_Filt(5, 0, 0x7E8);
}

// void sendPid(unsigned char __pid) {
//     unsigned char tmp[8] = {0x02, 0x01, __pid, 0, 0, 0, 0, 0};
//     CAN.sendMsgBuf(CAN_ID_PID, 0, 8, tmp);
// }

// bool getSpeed(int *s)
// {
//     sendPid(PID_VEHICLE_SPEED);
//     unsigned long __timeout = millis();
// 
//     while(millis()-__timeout < 1000)      // 1s time out
//     {
//         unsigned char len = 0;
//         unsigned char buf[8];
// 
//         if (CAN_MSGAVAIL == CAN.checkReceive()) {                // check if get data
//             CAN.readMsgBuf(&len, buf);    // read data,  len: data length, buf: data buf
// 
//             if(buf[1] == 0x41)
//             {
//                 *s = buf[3];
//                 return 1;
//             }
//         }
//     }
// 
//     return 0;
// }

void setup() {
	/* serial monitor init */
	Serial.begin(115200);
	while (!Serial) {
        Serial.println("Serial failed, retry..");
        delay(1000);
    }
	/* obd module power on */
	obd.PowerOn();

	/* init can bus : baudrate = 500k */
	while (CAN_OK != CAN.begin(CAN_500KBPS)) {
		Serial.println("CAN init fail, retry...");
		delay(1000);
	}
	Serial.println("CAN init ok!");

	// set_mask_filt();
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
