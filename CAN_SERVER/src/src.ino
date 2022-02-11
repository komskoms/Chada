#include "hpp/header.hpp"
/*
	int ledPin = 10;
	volatile int state = LOW;
*/
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
	/*
	pinMode(ledPin, INPUT_PULLUP);
	digitalWrite(ledPin, LOW);
	attachInterrupt(digitalPinToInterrupt(ledPin), sendRequestData, CHANGE);
	*/
}

/******************************************************************************************
** Function Name : loop
** Description	 : call continuously until the program is over
*******************************************************************************************/
void loop() {
	HC06.begin(SERIAL_SPEED);
	// 차량 데이터 앱에 송신하는 코드
	// int send_data = 0;
	// send_info(send_data);

	//앱에서 OBD에 데이터를 요청하고, OBD에서 앱에 응답하는 코드
	if (HC06.available() > 0) {
		String hc06_buf = HC06.readStringUntil('\n');
		int request_num = hc06_buf.toInt();
		request_info(request_num);
	}
}
/*
void sendRequestData() {
	state = !state;
	if (HC06.available() > 0) {
		String num = HC06.readStringUntil('\n');
		int request_num = num.toInt();
		HC06.println(request_num);
		request_info(request_num);
	}
 	state = false;
}
*/