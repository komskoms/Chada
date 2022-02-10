#ifndef HEADER_HPP
#define HEADER_HPP

#include <SD.h>
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
#define SPI_CS_PIN			9
#define CAN_ID_PID			0x7DF
#define HC06_RX             10
#define HC06_TX             11

// bluetooth rx, tx
static int rxPin = 10;
static int txPin = 11;
 
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
** send_info.cpp
*/
bool send_info(int s);

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
