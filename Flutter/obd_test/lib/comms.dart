import 'dart:async';
import 'dart:math';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'OBD_PID.dart';

class _message {
  String whom;
  String text;

  _message(this.whom, this.text);
  _message.fromList(List<String> str) {
    whom = str[0];
    text = str[1];
  }
}

class carInfo {
  static BluetoothDevice _server = null;
  static BluetoothConnection _connection;
  static bool _connected = false;
  static bool _scanning = false;
  static bool _disconnecting = false;

  static List<_message> messages = List<_message>.empty(growable: true);
  static String _messageBuffer = '';

  static List<bool> _scanPID =
      List.generate(OBDPid.LAST_INDEX.index, (index) => false);
  static List<int> _values =
      List.generate(OBDPid.LAST_INDEX.index, (index) => 0);

  static int battery_charge = 0;

  carInfo();

/******************************************************************************************
** Function Name : randomize
** Description	 : (테스트용)변수를 임의 값으로 변경
*******************************************************************************************/
  void randomize() {
    var rand = Random();

    _values[OBDPid.ENGINE_SPEED.index] = rand.nextInt(8000);
    _values[OBDPid.CALCULATED_ENGINE_LOAD.index] = rand.nextInt(100);
    _values[OBDPid.ENGINE_COOLANT_TEMPERATURE.index] = rand.nextInt(200);
    _values[OBDPid.FUEL_TANK_LEVEL_INPUT.index] = rand.nextInt(100);
    _values[OBDPid.VEHICLE_SPEED.index] = rand.nextInt(200);
    _values[OBDPid.THROTTLE_POSITION.index] = rand.nextInt(100);
    battery_charge = 42;
  }

/******************************************************************************************
** Function Name : switchTest
** Description	 : (테스트용)OBD와 통신하여 갱신할 PID를 지정함
*******************************************************************************************/
  void switchTest() {
    _scanPID[OBDPid.ENGINE_SPEED.index] = true;
    _scanPID[OBDPid.CALCULATED_ENGINE_LOAD.index] = true;
    _scanPID[OBDPid.ENGINE_COOLANT_TEMPERATURE.index] = true;
    _scanPID[OBDPid.FUEL_TANK_LEVEL_INPUT.index] = true;
    _scanPID[OBDPid.VEHICLE_SPEED.index] = true;
    _scanPID[OBDPid.THROTTLE_POSITION.index] = true;
  }

/******************************************************************************************
** Function Name : scanAll
** Description	 : 설정 화면에서 OBD를 연결했을 때, 지정된 PID 에 대한 요청을 보냄
*******************************************************************************************/
  void scanAll() async {
    int i = 0;

    while (i < OBDPid.LAST_INDEX.index) {
      await scanItem(i++, _scanMethod);
      Future.delayed(Duration(milliseconds: 100));
    }
  }

/******************************************************************************************
** Function Name : scanItem
** Description	 : scanAll의 하위 함수
                    -> 각 PID에 대한 요청을 처리
*******************************************************************************************/
  void scanItem(int pidIndex, Function scanMethod) {
    if (_scanPID[pidIndex] == false) {
      _values[pidIndex] = -1;
    } else {
      scanMethod(pidIndex);
    }
  }

/******************************************************************************************
** Function Name : _scanMethod
** Description	 : PID 요청을 처리하는 방식 정의
                    -> OBD가 연결됐는지 확인 후, 규칙에 따라 _sendMessage 호출
*******************************************************************************************/
  int _scanMethod(int pidIndex) {
    if (_server == null) {
      print("Tried scan without being connected to OBD");
      return -2;
    } else {
      battery_charge = 90;
      _sendMessage(PidName[pidIndex]);
      return 42;
    }
  }

/******************************************************************************************
** Function Name : startComm
** Description	 : 설정에서 OBD를 연결하면 작동하는 함수
                    -> 블루투스 연결 작업 일체를 처리
*******************************************************************************************/
  void startComm(BuildContext context, BluetoothDevice server) {
    _server = server;

    BluetoothConnection.toAddress(server.address).then((__connection) {
      print('Connected to the device');
      _connection = __connection;
      _disconnecting = false;

      _connection.input.listen(_onDataReceived).onDone(() {
        // Example: Detect which side closed the connection
        // There should be `isDisconnecting` flag to show are we are (locally)
        // in middle of disconnecting process, should be set before calling
        // `dispose`, `finish` or `close`, which all causes to disconnect.
        // If we except the disconnection, `onDone` should be fired as result.
        // If we didn't except this (no flag set), it means closing by remote.
        if (_disconnecting) {
          print('Disconnecting locally!');
        } else {
          print('Disconnected remotely!');
        }
      });
    }).catchError((error) {
      print('Cannot connect, exception occured');
      print(error);
    });
  }

/******************************************************************************************
** Function Name : dispose
** Description	 : 블루투스 연결 해제 기능
*******************************************************************************************/
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and disconnect
    if (_connection != null) {
      print("closing connection");
      _disconnecting = true;
      _connection?.dispose();
      _connection = null;
      _server = null;
    }
  }

/******************************************************************************************
** Function Name : printMessage
** Description	 : (테스트용)printReceived의 하위 함수
                    -> OBD에서 받아와 리스트에 저장된 메시지 출력
*******************************************************************************************/
  void printMessage(_message msg) {
    print(msg.whom + ': ' + msg.text);
  }

/******************************************************************************************
** Function Name : printReceived
** Description	 : (테스트용)OBD에서 받아와 리스트에 저장된 메시지 출력, 출력한만큼 리스트에서 삭제
*******************************************************************************************/
  void printReceived() {
    int size = messages.length;

    messages.sublist(0, size).forEach((element) {
      printMessage(element);
    });
    messages.removeRange(0, size);
  }

/******************************************************************************************
** Function Name : setValueByMessage
** Description	 : OBD에서 받아온 메시지에 따라 앱에 표시할 값을 수정
*******************************************************************************************/
  _message setValueByMessage(_message msg) {
    int val;

    if (msg.text == "Timeout") {
      val = 0x7fffffff;
    } else {
      val = int.parse(msg.text);
    }
    if (msg.whom == "BATTERY_MAYBE") {
      battery_charge = val;
    } else if (PidName.indexOf(msg.whom) == -1) {
      print("CommError: respond PID is not available");
    } else {
      _values[PidName.indexOf(msg.whom)] = val;
    }
    return msg;
  }

/******************************************************************************************
** Function Name : _onDataReceived
** Description	 : OBD에서 블루투스 시리얼 스트림으로 들어온 입력이 있을 때 작동할 함수
                    -> /n/r 단위로 끊어서 처리
*******************************************************************************************/
  void _onDataReceived(Uint8List data) {
    String _rawMessage = '';
    // Allocate buffer for parsed data
    int backspacesCounter = 0;
    data.forEach((byte) {
      if (byte == 8 || byte == 127) {
        backspacesCounter++;
      }
    });
    Uint8List buffer = Uint8List(data.length - backspacesCounter);
    int bufferIndex = buffer.length;

    // Apply backspace control character
    backspacesCounter = 0;
    for (int i = data.length - 1; i >= 0; i--) {
      if (data[i] == 8 || data[i] == 127) {
        backspacesCounter++;
      } else {
        if (backspacesCounter > 0) {
          backspacesCounter--;
        } else {
          buffer[--bufferIndex] = data[i];
        }
      }
    }

    // Create message if there is new line character
    String dataString = String.fromCharCodes(buffer);
    int index = buffer.indexOf(13);
    if (~index != 0) {
      _rawMessage = backspacesCounter > 0
          ? _messageBuffer.substring(
              0, _messageBuffer.length - backspacesCounter)
          : _messageBuffer + dataString.substring(0, index);
      messages.add(
          setValueByMessage(_message.fromList(_rawMessage.trim().split(":"))));
      _messageBuffer = dataString.substring(index);
    } else {
      _messageBuffer = (backspacesCounter > 0
          ? _messageBuffer.substring(
              0, _messageBuffer.length - backspacesCounter)
          : _messageBuffer + dataString);
    }
  }

/******************************************************************************************
** Function Name : _sendMessage
** Description	 : 블루투스 시리얼 스트림을 통해 OBD로 text 전송
*******************************************************************************************/
  void _sendMessage(String text) async {
    text = text.trim();
    // textEditingController.clear();

    if (text.length > 0) {
      try {
        _connection.output.add(Uint8List.fromList(utf8.encode(text + "\r\n")));
        await _connection.output.allSent;
      } catch (e) {
        // Ignore error, but notify state
        print("error: $text");
      }
    }
  }

  get ENG_RPM => _values[OBDPid.ENGINE_SPEED.index];
  get ENG_LOAD => _values[OBDPid.CALCULATED_ENGINE_LOAD.index];
  get COOL_TMP => _values[OBDPid.ENGINE_COOLANT_TEMPERATURE.index];
  get FUEL_LVL => _values[OBDPid.FUEL_TANK_LEVEL_INPUT.index];
  get CUR_SPD => _values[OBDPid.VEHICLE_SPEED.index];
  get ACCEL => _values[OBDPid.THROTTLE_POSITION.index];
  get getValue => _values;
  get getScanFlag => _scanPID;
  get BAT_CHG => battery_charge;

  get getServer => _server;
  set setServer(BluetoothDevice server) => _server = server;

  get getConnection => _connection;
  set setConnection(BluetoothConnection connection) => _connection = connection;

  get getConnected => _connected;
  set setConnected(bool connected) => _connected = connected;

  get Messages => messages;
  get getMessageBuffer => _messageBuffer;
  set setMessageBuffer(String msgBuf) => _messageBuffer = msgBuf;
}
