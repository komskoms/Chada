#ifndef PAIR_HPP
#define PAIR_HPP

#include "ArduinoSTL.h"
#include <SoftwareSerial.h>

class Pair {
private:
	std::string name;
	unsigned int pid;
	bool* (*func)(SoftwareSerial &_HC06);
public:
	Pair();
	~Pair();
	Pair(std::string _name, unsigned int _pid, bool *_func(SoftwareSerial &_HC06));
	std::string getName();
	unsigned int getPid();
	void startFunc(SoftwareSerial &_HC06);
};

#endif