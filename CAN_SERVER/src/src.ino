#include "hpp/header.hpp"
//#include <SoftwareSerial.h>

// #define HC06_RX             10
// #define HC06_TX             11

// SoftwareSerial HC06(HC06_RX, HC06_TX);
/******************************************************************************************
** Function Name : setup
** Description	 : call me when the program starts
*******************************************************************************************/
void setup() {
	SerialInit();
	obd.PowerOn();
	CANInit();
	setMaskFilt();
	//BluetoothInit();
	HC06.begin(9600);
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
	// HC06.println("connect");
	Serial.println("connected");
	getEngineRPM(&speed);
	// getCoolantTemperature(&speed);
	// getEngineLoad(&speed);
	// getFuelLevel(&speed);
	// getSpeed(&speed);
	// getBattery(&speed);

	delay(500);
}
