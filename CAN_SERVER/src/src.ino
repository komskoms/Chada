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
	HC06.begin(SERIAL_SPEED);
	int send_data = 0;
	
	if (HC06.available() > 0) {
		String num = HC06.readStringUntil('\n');
		int request_num = num.toInt();
		HC06.println(request_num);
		request_info(request_num);
	}
	
	// if (CANInit) {
	// 	send_info(send_data);
	// 	delay(5000);
	// }
}
