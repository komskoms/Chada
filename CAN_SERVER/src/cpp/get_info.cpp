#include "header.hpp"

/******************************************************************************************
** Function Name : getEngineRPM
** Description	 : get engine RPM
*******************************************************************************************/
bool getEngineRPM(SoftwareSerial &_HC06) {
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
				// Serial.println(buf[3]);
				// Serial.println(buf[4]);
				rpm = buf[3] * 16 * 16;
				rpm += buf[4];
				Serial.print("Engine RPM : ");
				Serial.println(rpm / 4);
				_HC06.print(rpm / 4);
				return 1;
			}
		}
	}
	return printTimeout((char *)"Engine RPM", _HC06);
}

/******************************************************************************************
** Function Name : getCoolantTemperature
** Description	 : get coolant temperature
*******************************************************************************************/
bool getCoolantTemperature(SoftwareSerial &_HC06) {
	sendPid(ENGINE_COOLANT_TEMPERATURE);
	unsigned long timeout_ = millis();

	while (millis() - timeout_ < 1000) {
		unsigned char len = 0;
		unsigned char buf[8];
		int temp;

		if (CAN_MSGAVAIL == CAN.checkReceive()) {
			CAN.readMsgBuf(&len, buf);
			if (buf[1] == 0x41) {
				// Serial.println(buf[3]);
				temp = buf[3] - 40;
				Serial.print("Coolant Temperature : ");
				Serial.println(temp);
				_HC06.print(temp);
				return 1;
			}
		}
	}
	return printTimeout((char *)"Coolant Temperature", _HC06);
}

/******************************************************************************************
** Function Name : getEngineLoad
** Description	 : get engine load(return percentage)
*******************************************************************************************/
bool getEngineLoad(SoftwareSerial &_HC06) {
	sendPid(CALCULATED_ENGINE_LOAD);
	unsigned long timeout_ = millis();

	while (millis() - timeout_ < 1000) {
		unsigned char len = 0;
		unsigned char buf[8];
		int load;

		if (CAN_MSGAVAIL == CAN.checkReceive()) {
			CAN.readMsgBuf(&len, buf);
			if (buf[1] == 0x41) {
				// Serial.println(buf[3]);
				load = (buf[3] / 255.0) * 100.0;
				Serial.print("Engine Load : ");
				Serial.println(load);
				_HC06.print(load);
				return 1;
			}
		}
	}
	return printTimeout((char *)"Engine Load", _HC06);
}

/******************************************************************************************
** Function Name : getFuelLevel
** Description	 : get fuel level(return percentage)
*******************************************************************************************/
bool getFuelLevel(SoftwareSerial &_HC06) {
	sendPid(FUEL_TANK_LEVEL_INPUT);
	unsigned long timeout_ = millis();

	while (millis() - timeout_ < 1000) {
		unsigned char len = 0;
		unsigned char buf[8];
		int fuel;

		if (CAN_MSGAVAIL == CAN.checkReceive()) {
			CAN.readMsgBuf(&len, buf);
			if (buf[1] == 0x41) {
				// Serial.println(buf[3]);
				fuel = (buf[3] / 255.0) * 100.0;
				Serial.print("Fuel Level : ");
				Serial.println(fuel);
				_HC06.print(fuel);
				return 1;
			}
		}
	}
	return printTimeout((char *)"Fuel level", _HC06);
}

/******************************************************************************************
** Function Name : getSpeed
** Description	 : get vehicle speed
*******************************************************************************************/
bool getSpeed(SoftwareSerial &_HC06) {
	sendPid(VEHICLE_SPEED);
	unsigned long timeout_ = millis();

	while (millis() - timeout_ < 1000) {
		unsigned char len = 0;
		unsigned char buf[8];

		if (CAN_MSGAVAIL == CAN.checkReceive()) {
			CAN.readMsgBuf(&len, buf);
			if (buf[1] == 0x41) {
				// Serial.println(buf[3]);
				Serial.print("Vehicle Speed : ");
				Serial.println(buf[3]);
				_HC06.print(buf[3]);
				return 1;
			}
		}
	}
	return printTimeout((char *)"Vehicle Speed", _HC06);
}

/******************************************************************************************
** Function Name : getBattery
** Description	 : get battery
*******************************************************************************************/
bool getBattery(SoftwareSerial &_HC06) {
	sendPid(164);
	unsigned long timeout_ = millis();
	int battery;

	while (millis() - timeout_ < 1000) {
		unsigned char len = 0;
		unsigned char buf[8];

		if (CAN_MSGAVAIL == CAN.checkReceive()) {
			CAN.readMsgBuf(&len, buf);
			if (buf[1] == 0x41) {
				// Serial.println(buf[3]);
				// Serial.println(buf[4]);
				battery = (256 * buf[3] + buf[4]) / 1000.0;
				Serial.print("Battery : ");
				Serial.println(battery);
				_HC06.print(battery);
				return 1;
			}
		}
	}
	return printTimeout((char *)"Battery", _HC06);
}
