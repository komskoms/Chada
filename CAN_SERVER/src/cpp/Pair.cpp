#include "../hpp/Pair.hpp"

Pair::Pair() {
	this->name = "";
	this->pid = 0;
}

Pair::~Pair() {
}

Pair::Pair(std::string _name, int _pid) : name(_name), pid(_pid) {
}
