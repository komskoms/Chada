#ifndef HEADER_HPP
#define HEADER_HPP

#include <Arduino.h>
#include <SPI.h>
#include <SoftwareSerial.h>
#include "hpp/mcp_can.hpp"
#include "hpp/OBDPower.hpp"
#include "hpp/OBD_pid.hpp"

#define SERIAL_SPEED		9600
#define BLUETOOTH_SPEED     9600
#define SPI_CS_PIN			9
#define CAN_ID_PID			0x7DF
#define HC06_RX             10
#define HC06_TX             11

static SoftwareSerial HC06(HC06_RX, HC06_TX);
static MCP_CAN CAN(SPI_CS_PIN);
static OBDPower obd(A3);

/*
** init.cpp
*/
void SerialInit();
void BluetoothInit();
void CANInit();
void setMaskFilt();

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
