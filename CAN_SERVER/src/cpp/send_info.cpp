#include "../hpp/header.hpp"

/******************************************************************************************
** Function Name : send_info
** Description	 : send car information to App and Serial monitor
*******************************************************************************************/
bool (*fp[6])(int *) = {
	getEngineRPM,
	getCoolantTemperature,
	getEngineLoad,
	getFuelLevel,
	getSpeed,
	getBattery
};

char *data_name[6] = {
	"Engine RPM",
	"Coolant Temperature",
	"Engine Load",
	"Fuel Level",
	"Speed",
	"Battery"
};

bool send_info(int s)
{
	HC06.begin(SERIAL_SPEED);
	int ret;
	int car_data;

	for (int i = 0; i < sizeof(fp) / sizeof(fp[0]); i++) {
		car_data = s;

		ret = fp[i](&car_data);
		if (ret) {
			HC06.print(data_name[i]);
			HC06.print(" : ");
			HC06.println(car_data);
			Serial.print(data_name[i]);
			Serial.print(" : ");
			Serial.println(car_data);
		}
	}
	Serial.println("------------------------------------");
	HC06.println("------------------------------------");
	return 1;
}