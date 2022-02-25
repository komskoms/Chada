#include "header.hpp"

/******************************************************************************************
** Function Name : sendPid
** Description	 : request data from the pid
*******************************************************************************************/
void sendPid(unsigned char pid) {
	unsigned char tmp[8] = {0x02, 0x01, pid, 0, 0, 0, 0, 0};
	CAN.sendMsgBuf(CAN_ID_PID, 0, 8, tmp);
}

/******************************************************************************************
** Function Name : printTimeout
** Description	 : print timeout message
*******************************************************************************************/
bool printTimeout(OBDPid pid, SoftwareSerial &_HC06) {
	char buf[11];
	sprintf(buf, "%d", pid);
	String _pid = buf;

	Serial.println(_pid + ":" + "Timeout");
	_HC06.println(_pid + ":" + "Timeout");
	return 0;
}
