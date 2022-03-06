#include "header.hpp"

SoftwareSerial HC06(HC06_RX, HC06_TX);
std::vector<Pair> pid_list;
MCP_CAN CAN = MCP_CAN(SPI_CS_PIN);
OBDPower obd = OBDPower(A3);

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
		// std::string str = request.c_str();
		Serial.println(request);
		// findPid(pid_list, request.c_str(), HC06);
	}
	else
		// delay(1000);
		;
}
