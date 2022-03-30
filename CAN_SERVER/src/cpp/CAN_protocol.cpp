#include "header.hpp"
#include <string>
#include <cstdlib>

/******************************************************************************************
** Function Name : sendPid
** Description	 : request data from the pid
*******************************************************************************************/
void sendPid(unsigned char pid) {
	unsigned char tmp[8] = {0x02, 0x01, pid, 0, 0, 0, 0, 0};
	CAN.sendMsgBuf(CAN_ID_PID, 0, 8, tmp);
}

/******************************************************************************************
** Function Name : sendQuery
** Description	 : request data from the pid
*******************************************************************************************/
void sendQuery(unsigned char query[7]) {
	unsigned char tmp[8] =
		{0x02, query[0], query[1], query[2], query[3], query[4], query[5], query[6]};
	CAN.sendMsgBuf(CAN_ID_PID, 0, 8, tmp);
}


/******************************************************************************************
** Function Name : getEngineRPM
** Description	 : get engine RPM
*******************************************************************************************/
std::string getCANResponse(unsigned char query[7]) {
	unsigned char len = 0;
	unsigned char buf[8];
	unsigned long timeout_;
	std::string result = "";
	char *temp[5];

	sendQuery(query);
	timeout_ = millis();

	while (millis() - timeout_ < 200) {
		// check if get data
		if (CAN_MSGAVAIL == CAN.checkReceive()) {
			CAN.readMsgBuf(&len, buf);
			// 0x40 + 1(mode)
			if (buf[1] == 0x41) {
				for (int i = 0; i < len; i++) {
					sprintf(temp, "%2X ", buf[i]);
					result += temp;
				}
				return result.trim();
			}
		}
	}
	return NULL;
}

/******************************************************************************************
** Function Name : printTimeout
** Description	 : print timeout message
*******************************************************************************************/
bool printTimeout(char *pid, SoftwareSerial &_HC06) {
	String _pid = pid;
// /* for testing */
// 	int randomNumber = rand();
// 	Serial.println(_pid + " : " + randomNumber);
// 	_HC06.println(_pid + ":" + randomNumber);

/* these are the original code */
	Serial.println(_pid + " : " + "Timeout");
	_HC06.println(_pid + ":" + "Timeout");
	return 0;
}
