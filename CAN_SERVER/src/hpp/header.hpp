#ifndef HEADER_HPP
#define HEADER_HPP

#include <stdio.h>
#include <Arduino.h>
#include <SPI.h>
#include <SoftwareSerial.h>
#include "ArduinoSTL.h"
#include "mcp_can.hpp"
#include "OBDPower.hpp"
#include "OBD_PID.hpp"
#include "Pair.hpp"

#define SERIAL_SPEED		9600
#define BLUETOOTH_SPEED		9600
#define SPI_CS_PIN			9
#define CAN_ID_PID			0x7DF
#define HC06_RX             10
#define HC06_TX             11

static MCP_CAN CAN(SPI_CS_PIN);
static OBDPower obd(A3);

/*
** init.cpp
*/
void SerialInit();
void CANInit();
void setMaskFilt();
void BluetoothInit(SoftwareSerial &_HC06);
void initPidList(std::vector<Pair> &pid_list);

/*
** get_info.cpp
*/
bool getEngineRPM(SoftwareSerial &_HC06);
bool getCoolantTemperature(SoftwareSerial &_HC06);
bool getEngineLoad(SoftwareSerial &_HC06);
bool getFuelLevel(SoftwareSerial &_HC06);
bool getSpeed(SoftwareSerial &_HC06);
bool getBattery(SoftwareSerial &_HC06);

/*
** CAN_protocol.cpp
*/
void sendPid(unsigned char pid);
bool printTimeout(char *pid, SoftwareSerial &_HC06) ;

/*
** pid_list.cpp
*/
void inputPidList(std::vector<Pair> &pid_list, std::string name, unsigned int pid,
				bool *func(SoftwareSerial &_HC06));
void findPid(std::vector<Pair> &pid_list, std::string name, SoftwareSerial &_HC06);

#endif
