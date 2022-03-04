#include "header.hpp"

SoftwareSerial HC06(HC06_RX, HC06_TX);
std::vector<Pair> pid_list;

/******************************************************************************************
** Function Name : setup
** Description	 : call me when the program starts
*******************************************************************************************/
void setup() {
	SerialInit();
	obd.PowerOn();
	CANInit();
	setMaskFilt();
	BluetoothInit(HC06);
	initPidList(pid_list);
}

/******************************************************************************************
** Function Name : loop
** Description	 : call continuously until the program is over
*******************************************************************************************/
void loop() {
	if (HC06.available() > 0) {
		String request = HC06.readStringUntil('\n');
		std::string str = request.c_str();
		Serial.print("Message form Bluetooth : ");
		Serial.println(request);
		findPid(pid_list, str, HC06);
	}
	else
		delay(1000);
}
