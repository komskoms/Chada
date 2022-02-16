#include "Pair.hpp"

Pair::Pair() {
	this->name = "";
	this->pid = 0;
}

Pair::~Pair() {
}

Pair::Pair(std::string _name, unsigned int _pid, bool *_func(SoftwareSerial &_HC06)) : name(_name + "\r"), pid(_pid) {
	this->func = _func;
}

std::string Pair::getName() {
	return this->name;
}

unsigned int Pair::getPid() {
	return this->pid;
}

void Pair::startFunc(SoftwareSerial &_HC06) {
	func(_HC06);
}