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
	HC06.begin(SERIAL_SPEED);
}

/******************************************************************************************
** Function Name : loop
** Description	 : call continuously until the program is over
*******************************************************************************************/
void loop() {
	char *result;
	int send_data = 0;

	if (HC06.available() > 0) {
		int request_num = HC06.readStringUntil('\n').toInt();
		request_info(request_num);
	}
	else
		delay(1000);
}
