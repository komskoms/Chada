#include "header.hpp"

/*********************************************************************************************************
** Function name:           inputPidList
** Descriptions:            input values in pid list
*********************************************************************************************************/
void inputPidList(std::vector<Pair> &pid_list, std::string name,
					unsigned int pid, bool *func(SoftwareSerial &_HC06)) {
	ASSERT(name.compare(""));
	ASSERT(pid != 0);
	ASSERT(func != 0);
	Pair pair(name, pid, func);
	pid_list.push_back(pair);
}

/*********************************************************************************************************
** Function name:           findPid
** Descriptions:            find pid at pid list
*********************************************************************************************************/
void findPid(std::vector<Pair> &pid_list, std::string name, SoftwareSerial &_HC06) {
	for (unsigned int i = 0; i < pid_list.size(); ++i) {
		std::string get_name = pid_list[i].getName();

		if (get_name.compare(name) == 0) {
			return pid_list[i].startFunc(_HC06);
		}
	}
	Serial.println("wrong command!");
}
