#ifndef HEADER_HPP
#define HEADER_HPP

#include <Arduino.h>
#include <SPI.h>
#include "mcp_can.hpp"
#include "OBDPower.hpp"
#include "OBD_PID.hpp"
#include <SoftwareSerial.h>

// c++ 관련 헤더
#include "ArduinoSTL.h"

#define SERIAL_SPEED		9600
#define BLUE_SPEED     9600
#define SPI_CS_PIN			9
#define CAN_ID_PID			0x7DF

// bluetooth rx, tx 선
const static int rxPin = 10;
const static int txPin = 11;
 
static SoftwareSerial HC06(rxPin, txPin);
static MCP_CAN CAN(SPI_CS_PIN);
static OBDPower obd(A3);

/*
** init.cpp
*/
void SerialInit();
void CANInit();
void setMaskFilt();
//void BluetoothInit();

/*
** get_info.cpp
*/
bool getEngineRPM(int *s);
bool getCoolantTemperature(int *s);
bool getEngineLoad(int *s);
bool getFuelLevel(int *s);
bool getSpeed(int *s);
bool getBattery(int *s);


/*
** CAN_protocol.cpp
*/
void sendPid(unsigned char pid);
bool printTimeout(char *pid);

#endif
