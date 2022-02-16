#ifndef PAIR_HPP
#define PAIR_HPP

#include "ArduinoSTL.h"

class Pair {
private:
	std::string name;
	int pid;
public:
	Pair();
	~Pair();
	Pair(std::string _name, int _pid);
};

#endif