#ifndef HEADER_HPP
#define HEADER_HPP

#include <stdio.h>
#include <Arduino.h>
#include <SPI.h>
#include <SoftwareSerial.h>
#include "mcp_can.hpp"
#include "OBDPower.hpp"
#include "OBD_PID.hpp"

// c++ 관련 헤더
#include "ArduinoSTL.h"

#define SERIAL_SPEED		9600
#define BLUETOOTH_SPEED		9600
#define SPI_CS_PIN			9
#define CAN_ID_PID			0x7DF
#define HC06_RX             10
#define HC06_TX             11

// bluetooth rx, tx
const extern int rxPin = 10;
const extern int txPin = 11;

extern SoftwareSerial HC06(rxPin, txPin);
extern MCP_CAN CAN(SPI_CS_PIN);
extern OBDPower obd(A3);

/*
** init.cpp
*/
void SerialInit();
void CANInit();
void setMaskFilt();
void BluetoothInit();

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
** send_info.cpp
*/
void send_info(int s);
static bool (*getDataFp[])(int *) = {
	getEngineRPM,
	getCoolantTemperature,
	getEngineLoad,
	getFuelLevel,
	getSpeed,
	getBattery
};
static const char *car_data_name[] = {
	"Engine RPM",
	"Coolant Temperature",
	"Engine Load",
	"Fuel Level",
	"Speed",
	"Battery"
};

/*
** request_info.cpp
*/
void request_info(int request_num);

/*
** CAN_protocol.cpp
*/
void sendPid(unsigned char pid);
bool printTimeout(char *pid);

#endif
