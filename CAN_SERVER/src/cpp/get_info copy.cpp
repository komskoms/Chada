// #include "header.hpp"

// /******************************************************************************************
// ** Function Name : getEngineRPM
// ** Description	 : get engine RPM
// *******************************************************************************************/
// bool getEngineRPM(SoftwareSerial &_HC06) {
// 	String pidName = "ENGINE_SPEED";
	
// 	sendPid(ENGINE_SPEED);
// 	unsigned long timeout_ = millis();

// 	while (millis() - timeout_ < 1000) {
// 		unsigned char len = 0;
// 		unsigned char buf[8];
// 		int rpm;

// 		// check if get data
// 		if (CAN_MSGAVAIL == CAN.checkReceive()) {
// 			CAN.readMsgBuf(&len, buf);
// 			// 0x40 + 1(mode)
// 			if (buf[1] == 0x41) {
// 				// Serial.println(buf[3]);
// 				// Serial.println(buf[4]);
// 				rpm = buf[3] * 16 * 16;
// 				rpm += buf[4];
// 				Serial.println(pidName + " : " + (rpm / 4));
// 				_HC06.println(pidName + ":" + (rpm / 4));
				
// 				return 1;
// 			}
// 		}
// 	}
// 	return printTimeout((char *)pidName.c_str(), _HC06);
// }

// /******************************************************************************************
// ** Function Name : getCoolantTemperature
// ** Description	 : get coolant temperature
// *******************************************************************************************/
// bool getCoolantTemperature(SoftwareSerial &_HC06) {
// 	String pidName = "ENGINE_COOLANT_TEMPERATURE";

// 	sendPid(ENGINE_COOLANT_TEMPERATURE);
// 	unsigned long timeout_ = millis();

// 	while (millis() - timeout_ < 1000) {
// 		unsigned char len = 0;
// 		unsigned char buf[8];
// 		int temp;

// 		if (CAN_MSGAVAIL == CAN.checkReceive()) {
// 			CAN.readMsgBuf(&len, buf);
// 			if (buf[1] == 0x41) {
// 				// Serial.println(buf[3]);
// 				temp = buf[3] - 40;
// 				Serial.println(pidName + " : " + (temp));
// 				_HC06.println(pidName + ":" + (temp));
// 				return 1;
// 			}
// 		}
// 	}
// 	return printTimeout((char *)pidName.c_str(), _HC06);
// }

// /******************************************************************************************
// ** Function Name : getEngineLoad
// ** Description	 : get engine load(return percentage)
// *******************************************************************************************/
// bool getEngineLoad(SoftwareSerial &_HC06) {
// 	String pidName = "CALCULATED_ENGINE_LOAD";

// 	sendPid(CALCULATED_ENGINE_LOAD);
// 	unsigned long timeout_ = millis();

// 	while (millis() - timeout_ < 1000) {
// 		unsigned char len = 0;
// 		unsigned char buf[8];
// 		int load;

// 		if (CAN_MSGAVAIL == CAN.checkReceive()) {
// 			CAN.readMsgBuf(&len, buf);
// 			if (buf[1] == 0x41) {
// 				// Serial.println(buf[3]);
// 				load = (buf[3] / 255.0) * 100.0;
// 				Serial.println(pidName + " : " + (load));
// 				_HC06.println(pidName + ":" + (load));
// 				return 1;
// 			}
// 		}
// 	}
// 	return printTimeout((char *)pidName.c_str(), _HC06);
// }

// /******************************************************************************************
// ** Function Name : getFuelLevel
// ** Description	 : get fuel level(return percentage)
// *******************************************************************************************/
// bool getFuelLevel(SoftwareSerial &_HC06) {
// 	String pidName = "FUEL_TANK_LEVEL_INPUT";

// 	sendPid(FUEL_TANK_LEVEL_INPUT);
// 	unsigned long timeout_ = millis();

// 	while (millis() - timeout_ < 1000) {
// 		unsigned char len = 0;
// 		unsigned char buf[8];
// 		int fuel;

// 		if (CAN_MSGAVAIL == CAN.checkReceive()) {
// 			CAN.readMsgBuf(&len, buf);
// 			if (buf[1] == 0x41) {
// 				// Serial.println(buf[3]);
// 				fuel = (buf[3] / 255.0) * 100.0;
// 				Serial.println(pidName + " : " + (fuel));
// 				_HC06.println(pidName + ":" + (fuel));
// 				return 1;
// 			}
// 		}
// 	}
// 	return printTimeout((char *)pidName.c_str(), _HC06);
// }

// /******************************************************************************************
// ** Function Name : getSpeed
// ** Description	 : get vehicle speed
// *******************************************************************************************/
// bool getSpeed(SoftwareSerial &_HC06) {
// 	String pidName = "VEHICLE_SPEED";

// 	sendPid(VEHICLE_SPEED);
// 	unsigned long timeout_ = millis();

// 	while (millis() - timeout_ < 1000) {
// 		unsigned char len = 0;
// 		unsigned char buf[8];

// 		if (CAN_MSGAVAIL == CAN.checkReceive()) {
// 			CAN.readMsgBuf(&len, buf);
// 			if (buf[1] == 0x41) {
// 				// Serial.println(buf[3]);
// 				Serial.println(pidName + " : " + (buf[3]));
// 				_HC06.println(pidName + ":" + (buf[3]));
// 				return 1;
// 			}
// 		}
// 	}
// 	return printTimeout((char *)pidName.c_str(), _HC06);
// }

// /******************************************************************************************
// ** Function Name : getBattery
// ** Description	 : get battery
// *******************************************************************************************/
// bool getBattery(SoftwareSerial &_HC06) {
// 	String pidName = "BATTERY_CHARGE";

// 	sendPid(BATTERY_CHARGE);
// 	unsigned long timeout_ = millis();
// 	int battery;

// 	while (millis() - timeout_ < 1000) {
// 		unsigned char len = 0;
// 		unsigned char buf[8];

// 		if (CAN_MSGAVAIL == CAN.checkReceive()) {
// 			CAN.readMsgBuf(&len, buf);
// 			if (buf[1] == 0x41) {
// 				// Serial.println(buf[3]);
// 				// Serial.println(buf[4]);
// 				battery = (256 * buf[3] + buf[4]) / 1000.0;
// 				Serial.println(pidName + " : " + (battery));
// 				_HC06.println(pidName + ":" + (battery));
// 				return 1;
// 			}
// 		}
// 	}
// 	return printTimeout((char *)pidName.c_str(), _HC06);
// }
