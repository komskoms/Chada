#include "header.hpp"

//extern SoftwareSerial HC06;

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
bool printTimeout(char *pid) {
	int		fd;
	char	*name = "storage.txt";
  
  HC06.begin(9600);
  SD.begin(4);

  File myFile;
  myFile = SD.open("storage.txt", FILE_WRITE);

  myFile.print(pid);
	myFile.println(" Pid Timeout");
	Serial.print(pid);
	Serial.println(" Pid Timeout");
	HC06.println(pid);
	HC06.println(" Pid Timeout");
	return 0;
}