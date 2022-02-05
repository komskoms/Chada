#include "hpp/header.hpp"

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
	int speed = 0;
	int ret = getSpeed(&speed);

	if(ret) {
		Serial.print("Vehicle Speed: ");
		Serial.print(speed);
		Serial.println(" kmh");
	}
	// test
	getEngineRPM(&speed);
	getCoolantTemperature(&speed);
	getEngineLoad(&speed);
	getFuelLevel(&speed);
	getSpeed(&speed);
	getBattery(&speed);

	delay(500);
}
