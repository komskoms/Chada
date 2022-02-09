#include "header.hpp"

/******************************************************************************************
** Function Name : SerialInit
** Description	 : serial monitor init
*******************************************************************************************/
void SerialInit() {
	Serial.begin(SERIAL_SPEED);
	while (!Serial)
		delay(1000);
	Serial.println("Serial Init ok!");
	Serial.println("--------------------------------");
}

/******************************************************************************************
** Function Name : CANInit
** Description	 : CAN init : buad rate = 500k
*******************************************************************************************/
void CANInit() {
	while (CAN_OK != CAN.begin(CAN_500KBPS)) {
		Serial.println("ERROR : CAN Init failed.");
		Serial.println("Retry...");
		Serial.println("--------------------------------");
		delay(1000);
	}
	Serial.println("CAN Init ok!");
	Serial.println("--------------------------------");
}

/******************************************************************************************
** Function Name : setMaskFilt
** Description	 : set mask and filt to get data from broadcast address(0x7FC)
*******************************************************************************************/
void setMaskFilt() {
	CAN.init_Mask(0, 0, 0x7FC);
	CAN.init_Mask(1, 0, 0x7FC);

	CAN.init_Filt(0, 0, 0x7E8);
	CAN.init_Filt(1, 0, 0x7E8);
	CAN.init_Filt(2, 0, 0x7E8);
	CAN.init_Filt(3, 0, 0x7E8);
	CAN.init_Filt(4, 0, 0x7E8); 
	CAN.init_Filt(5, 0, 0x7E8);
}
