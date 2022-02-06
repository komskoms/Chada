#include "hpp/header.hpp"

#define CAN_ID_PID          0x7DF

// void set_mask_filt() {
// 	// broadcast : 0x7FC
// 	CAN.init_Mask(0, 0, 0x7FC);
// 	CAN.init_Mask(1, 0, 0x7FC);

// 	// 
// 	CAN.init_Filt(0, 0, 0x7E8);
// 	CAN.init_Filt(1, 0, 0x7E8);
// 	CAN.init_Filt(2, 0, 0x7E8);
// 	CAN.init_Filt(3, 0, 0x7E8);
// 	CAN.init_Filt(4, 0, 0x7E8); 
// 	CAN.init_Filt(5, 0, 0x7E8);
// }

// void sendPid(unsigned char __pid) {
//     unsigned char tmp[8] = {0x02, 0x01, __pid, 0, 0, 0, 0, 0};
//     CAN.sendMsgBuf(CAN_ID_PID, 0, 8, tmp);
// }

// bool getSpeed(int *s)
// {
//     sendPid(PID_VEHICLE_SPEED);
//     unsigned long __timeout = millis();

//     while(millis()-__timeout < 1000)      // 1s time out
//     {
//         unsigned char len = 0;
//         unsigned char buf[8];

//         if (CAN_MSGAVAIL == CAN.checkReceive()) {                // check if get data
//             CAN.readMsgBuf(&len, buf);    // read data,  len: data length, buf: data buf

// 			Serial.println(buf[0]);
// 			Serial.println(buf[1]);
// 			Serial.println(buf[2]);
// 			Serial.println(buf[3]);
// 			Serial.println(buf[4]);
// 			Serial.println(buf[5]);
// 			Serial.println(buf[6]);
// 			Serial.println(buf[7]);
//             if(buf[1] == 0x41)
//             {
//                 *s = buf[3];
//                 return 1;
//             }
//         }
//     }

//     return 0;
// }

// /********************************************************
// ** Function Name :		SerialInit
// ** Description :		serial monitor init
// *********************************************************/
// void SerialInit() {
// 	Serial.begin(SERIAL_SPEED);
// 	while (!Serial)
// 		delay(1000);
// 	Serial.println("Serial Init ok!");
// 	Serial.println("--------------------------------");
// }

// /********************************************************
// ** Function Name :		CANInit
// ** Description :		CAN init : buad rate = 500k
// *********************************************************/
// void CANInit() {
// 	while (CAN_OK != CAN.begin(CAN_500KBPS)) {
// 		Serial.println("ERROR : CAN Init failed.");
// 		Serial.println("Retry...");
// 		Serial.println("--------------------------------");
// 		delay(1000);
// 	}
// 	Serial.println("CAN Init ok!");
// 	Serial.println("--------------------------------");
// }

// void setup() {
// 	SerialInit();
// 	obd.PowerOn();
// 	CANInit();
// 	set_mask_filt();
// }

// void loop() {
// 	int __speed = 0;
// 	int ret = getSpeed(&__speed);

// 	if(ret)
// 	{
// 	    Serial.print("Vehicle Speed: ");
// 	    Serial.print(__speed);
// 	    Serial.println(" kmh");
// 	}
// 	delay(500);
// }















/******************************************************************************************
** Function Name : setup
** Description	 : call me when the program starts
*******************************************************************************************/
void setup() {
	SerialInit();
	obd.PowerOn();
	CANInit();
	setMaskFilt();
}

/******************************************************************************************
** Function Name : loop
** Description	 : call continuously until the program is over
*******************************************************************************************/
void loop() {
	// test
	int speed = 0;
	int ret;
	
	ret = getEngineRPM(&speed);
	if(ret) {
		Serial.print("Engine RPM : ");
		Serial.println(speed);
	}

	ret = getCoolantTemperature(&speed);
	if(ret) {
		Serial.print("Coolant Temperature : ");
		Serial.println(speed);
	}

	ret = getEngineLoad(&speed);
	if(ret) {
		Serial.print("Engine Load : ");
		Serial.println(speed);
	}

	ret = getFuelLevel(&speed);
	if(ret) {
		Serial.print("Fuel Level : ");
		Serial.println(speed);
	}

	ret = getSpeed(&speed);
	if(ret) {
		Serial.print("Speed : ");
		Serial.println(speed);
	}

	ret = getBattery(&speed);
	if(ret) {
		Serial.print("Battery : ");
		Serial.println(speed);
	}
	Serial.println("------------------------------------");
	delay(5000);
}
