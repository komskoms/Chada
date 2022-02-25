#ifndef OBDPOWER_H
#define OBDPOWER_H

#include <Arduino.h>

class OBDPower {
private:
	uint8_t POWER_PIN;

public:
	OBDPower(uint8_t power_pin);
	void PowerOn();
	void PowerOff();
};

#endif