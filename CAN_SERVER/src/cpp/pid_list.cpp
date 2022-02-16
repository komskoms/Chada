#include "header.hpp"

void inputPidList(std::vector<Pair> &pid_list, std::string name,
					unsigned int pid, bool *func(SoftwareSerial &_HC06)) {
	Pair pair(name, pid, func);
	pid_list.push_back(pair);
}

void findPid(std::vector<Pair> &pid_list, std::string name, SoftwareSerial &_HC06) {
	for (unsigned int i = 0; i < pid_list.size(); ++i) {
		std::string get_name = pid_list[i].getName();

		if (get_name.compare(name) == 0) {
			return pid_list[i].startFunc(_HC06);
		}
	}
	Serial.println("wrong command!");
}
