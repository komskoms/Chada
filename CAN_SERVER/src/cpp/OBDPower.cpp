#include "../hpp/OBDPower.hpp"

/*
** set POWER_PIN
*/
OBDPower::OBDPower(uint8_t power_pin):POWER_PIN(power_pin) {
}

/*
** power on
*/
void OBDPower::PowerOn() {
	digitalWrite(POWER_PIN, HIGH);
}

/*
** power off
*/
void OBDPower::PowerOff() {
	digitalWrite(POWER_PIN, LOW);
}