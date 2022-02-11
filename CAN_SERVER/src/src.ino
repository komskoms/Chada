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
	int send_data = 0;
	int request_num = 0;

	if (CANInit) {
		send_info(send_data);
	}
	if (HC06.available) {
		request_num = HC06.parseInt();
		//문자로 표현된 숫자를 정수형으로 받음. ex) 123 을 48, 49, 50 이 아닌 123 으로 받음.
		request_info(request_num);
	}
	delay(5000);
}
