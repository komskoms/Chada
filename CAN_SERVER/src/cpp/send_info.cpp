#include "../hpp/header.hpp"

/******************************************************************************************
** Function Name : send_info
** Description	 : send car information to App(Bluetooth) and Serial monitor
*******************************************************************************************/
void send_info(int s) {
	// HC06.begin(SERIAL_SPEED);
	int ret;
	int car_data;

	for (unsigned int i = 0; i < sizeof(getDataFp) / sizeof(getDataFp[0]); i++) {
		car_data = s;
		ret = getDataFp[i](&car_data);
		
		if (ret) {
			HC06.print(car_data_name[i]);
			HC06.print(" : ");
			HC06.println(car_data);
			Serial.print(car_data_name[i]);
			Serial.print(" : ");
			Serial.println(car_data);
		}
	}
	HC06.println("------------------------------------");
	Serial.println("------------------------------------");
}