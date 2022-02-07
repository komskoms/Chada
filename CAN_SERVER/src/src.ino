#include "hpp/header.hpp"

/******************************************************************************************
** Function Name : setup
** Description	 : call me when the program starts
*******************************************************************************************/
void setup() {
	SerialInit();
	BluetoothInit();
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
		BLUE_HC06.print("Vehicle Speed: ");
		BLUE_HC06.print(speed);
		BLUE_HC06.println(" kmh");
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
