#include "../hpp/header.hpp"

/******************************************************************************************
** Function Name : send_info
** Description	 : send car information to App and Serial monitor
*******************************************************************************************/
bool send_info(int s)
{
	HC06.begin(SERIAL_SPEED);
	int	ret;
	int car_data;

	car_data = s;
	for ()
	ret = getSpeed(&car_data);
	if(ret) {
		HC06.print("Speed : ");
		HC06.println(car_data);
		Serial.print("Speed : ");
		Serial.println(car_data);
	}

	ret = getEngineRPM(&car_data);
	if(ret) {
		HC06.print("Engine RPM : ");
		HC06.println(car_data);
		Serial.print("Engine RPM : ");
		Serial.println(car_data);
	}

	ret = getCoolantTemperature(&car_data);
	if(ret) {
		HC06.print("Coolant Temperature : ");
		HC06.println(car_data);
		Serial.print("Coolant Temperature : ");
		Serial.println(car_data);
	}

	ret = getEngineLoad(&car_data);
	if(ret) {
		HC06.print("Engine Load : ");
		HC06.println(car_data);
		Serial.print("Engine Load : ");
		Serial.println(car_data);
	}

	ret = getFuelLevel(&car_data);
	if(ret) {
		HC06.print("Fuel Level : ");
		HC06.println(car_data);
		Serial.print("Fuel Level : ");
		Serial.println(car_data);
	}

	ret = getBattery(&car_data);
	if(ret) {
		HC06.print("Battery : ");
		HC06.println(car_data);
		Serial.print("Battery : ");
		Serial.println(car_data);
	}
	Serial.println("------------------------------------");
	HC06.println("------------------------------------");
	return 1;
}