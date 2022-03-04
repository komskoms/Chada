#include "header.hpp"

/******************************************************************************************
** Function Name : SerialInit
** Description	 : serial monitor init
*******************************************************************************************/
void SerialInit() {
	Serial.begin(SERIAL_SPEED);
	Serial.println("Serial Init ok!");
	Serial.println("--------------------------------");
}

/******************************************************************************************
** Function Name : BluetoothInit
** Description	 : Bluetooth App monitor init
*******************************************************************************************/
void BluetoothInit(SoftwareSerial &_HC06) {
	_HC06.begin(BLUETOOTH_SPEED);
}

/******************************************************************************************
** Function Name : CANInit
** Description	 : CAN init : buad rate = 500k
*******************************************************************************************/
void CANInit() {
	while (CAN_OK != CAN.begin(CAN_500KBPS)) {
		Serial.println("ERROR : CAN Init failed.");
		Serial.println("Retry...");
		Serial.println("--------------------------------");
		delay(1000);
	}
	Serial.println("CAN Init ok!");
	Serial.println("--------------------------------");
}

/******************************************************************************************
** Function Name : setMaskFilt
** Description	 : set mask and filt to get data from broadcast address(0x7FC)
*******************************************************************************************/
void setMaskFilt() {
	CAN.init_Mask(0, 0, 0x7FC);
	CAN.init_Mask(1, 0, 0x7FC);

	CAN.init_Filt(0, 0, 0x7E8);
	CAN.init_Filt(1, 0, 0x7E8);
	CAN.init_Filt(2, 0, 0x7E8);
	CAN.init_Filt(3, 0, 0x7E8);
	CAN.init_Filt(4, 0, 0x7E8); 
	CAN.init_Filt(5, 0, 0x7E8);
	Serial.println("--------------------------------");
}

/******************************************************************************************
** Function Name : initPidList
** Description	 : set pid list
*******************************************************************************************/
void initPidList(std::vector<Pair> &pid_list) {
	std::string str = "ENGINE_SPEED";
	inputPidList(pid_list, str, OBDPid::ENGINE_SPEED, getEngineRPM);

	str = "ENGINE_COOLANT_TEMPERATURE";
	inputPidList(pid_list, str, OBDPid::ENGINE_COOLANT_TEMPERATURE, getCoolantTemperature);

	str = "CALCULATED_ENGINE_LOAD";
	inputPidList(pid_list, str, OBDPid::CALCULATED_ENGINE_LOAD, getEngineLoad);

	str = "FUEL_TANK_LEVEL_INPUT";
	inputPidList(pid_list, str, OBDPid::FUEL_TANK_LEVEL_INPUT, getFuelLevel);

	str = "VEHICLE_SPEED";
	inputPidList(pid_list, str, OBDPid::VEHICLE_SPEED, getSpeed);

	str = "BATTERY";
	inputPidList(pid_list, str, 164, getBattery);

	// check right name
	for (unsigned int i = 0; i < pid_list.size(); ++i)
		std::cout << pid_list[i].getName() <<  std::endl;
	Serial.println("Pid List Init ok!");
	Serial.println("--------------------------------");
}
