#include "../hpp/header.hpp"

/******************************************************************************************
** Function Name : getEngineRPM
** Description	 : get engine RPM
*******************************************************************************************/
bool getEngineRPM(int *s) {
	sendPid(ENGINE_SPEED);
	unsigned long timeout_ = millis();

	while (millis() - timeout_ < 1000) {
		unsigned char len = 0;
		unsigned char buf[8];
		int rpm;

		// check if get data
		if (CAN_MSGAVAIL == CAN.checkReceive()) {
			CAN.readMsgBuf(&len, buf);
			// 0x40 + 1(mode)
			if (buf[1] == 0x41) {
				Serial.println(buf[3]);
				Serial.println(buf[4]);
				rpm = buf[3] * 16 * 16;
				rpm += buf[4];
				*s = rpm / 4;
				return 1;
			}
		}
	}
	return printTimeout("Engine RPM");
}

/******************************************************************************************
** Function Name : getCoolantTemperature
** Description	 : get coolant temperature
*******************************************************************************************/
bool getCoolantTemperature(int *s) {
	sendPid(ENGINE_COOLANT_TEMPERATURE);
	unsigned long timeout_ = millis();

	while (millis() - timeout_ < 1000) {
		unsigned char len = 0;
		unsigned char buf[8];
		int temp;

		if (CAN_MSGAVAIL == CAN.checkReceive()) {
			CAN.readMsgBuf(&len, buf);
			if (buf[1] == 0x41) {
				Serial.println(buf[3]);
				temp = buf[3] - 40;
				*s = temp;
				return 1;
			}
		}
	}
	return printTimeout("Coolant Temperature");
}

/******************************************************************************************
** Function Name : getEngineLoad
** Description	 : get engine load(return percentage)
*******************************************************************************************/
bool getEngineLoad(int *s) {
	sendPid(CALCULATED_ENGINE_LOAD);
	unsigned long timeout_ = millis();

	while (millis() - timeout_ < 1000) {
		unsigned char len = 0;
		unsigned char buf[8];
		int load;

		if (CAN_MSGAVAIL == CAN.checkReceive()) {
			CAN.readMsgBuf(&len, buf);
			if (buf[1] == 0x41) {
				Serial.println(buf[3]);
				load = (buf[3] / 255.0) * 100.0;
				*s = load;
				return 1;
			}
		}
	}
	return printTimeout("Engine Load");
}

/******************************************************************************************
** Function Name : getFuelLevel
** Description	 : get fuel level(return percentage)
*******************************************************************************************/
bool getFuelLevel(int *s) {
	sendPid(FUEL_TANK_LEVEL_INPUT);
	unsigned long timeout_ = millis();

	while (millis() - timeout_ < 1000) {
		unsigned char len = 0;
		unsigned char buf[8];
		int fuel;

		if (CAN_MSGAVAIL == CAN.checkReceive()) {
			CAN.readMsgBuf(&len, buf);
			if (buf[1] == 0x41) {
				Serial.println(buf[3]);
				fuel = (buf[3] / 255.0) * 100.0;
				*s = fuel;
				return 1;
			}
		}
	}
	return printTimeout("Fuel level");
}

/******************************************************************************************
** Function Name : getSpeed
** Description	 : get vehicle speed
*******************************************************************************************/
bool getSpeed(int *s) {
	sendPid(VEHICLE_SPEED);
	unsigned long timeout_ = millis();

	while (millis() - timeout_ < 1000) {
		unsigned char len = 0;
		unsigned char buf[8];

		if (CAN_MSGAVAIL == CAN.checkReceive()) {
			CAN.readMsgBuf(&len, buf);
			if (buf[1] == 0x41) {
				Serial.println(buf[3]);
				*s = buf[3];
				return 1;
			}
		}
	}
	return printTimeout("Vehicle Speed");
}

/******************************************************************************************
** Function Name : getBattery
** Description	 : get battery
*******************************************************************************************/
bool getBattery(int *s) {
	sendPid(164);
	unsigned long timeout_ = millis();
	int battery;

	while (millis() - timeout_ < 1000) {
		unsigned char len = 0;
		unsigned char buf[8];

		if (CAN_MSGAVAIL == CAN.checkReceive()) {
			CAN.readMsgBuf(&len, buf);
			if (buf[1] == 0x41) {
				Serial.println(buf[3]);
				Serial.println(buf[4]);
				battery = (256 * buf[3] + buf[4]) / 1000.0;
				*s = battery;
				return 1;
			}
		}
	}
	return printTimeout("Battery");
}
