#include "hpp/header.hpp"
#include "ArduinoSTL.h"

/******************************************************************************************
** Function Name : setup
** Description	 : call me when the program starts
*******************************************************************************************/
void setup() {
	std::cout << "hi" << std::endl;
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
