import 'dart:async';
import 'dart:math';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'OBD_PID.dart';

carInfo iswork;

class _message {
  String whom;
  String text;

  _message(this.whom, this.text);
  _message.fromList(List<String> str) {
    whom = str[0];
    text = str[1];
  }
}

/******************************************************************************************
** Class Name  : carInfo
** Description : OBD와 통신하는 모든 자료와 매서드를 보유
*******************************************************************************************/
class carInfo {
  static BluetoothDevice _server = null;
  static BluetoothConnection _connection;

  static bool _connected = false;
  static bool _disconnecting = false;
  static bool _sendQuery = false;
  static bool _promptReceived = false;
  static bool _scanning = false;

  static List<_message> _messagesList = List<_message>.empty(growable: true);
  static List<String> _tempMessageList = List.empty(growable: true);
  static String _messageBuffer = '';
  static String _lastQuery = '';
  static String _recentQuery = '';
  static bool _ELMBusy = false;

  static List<bool> _scanPID = List.generate(PidName.length, (index) => false);
  static List<int> _values = List.generate(PidName.length, (index) => 0);

  static int battery_charge = 0;

  carInfo();

  /**
  ** Function Name : startComm
  ** Description	 : 설정에서 OBD를 연결하면 작동하는 함수
  **                  -> 블루투스 연결 작업 일체를 처리
  */
  void startComm(BuildContext context, BluetoothDevice server) {
    _server = server;

    BluetoothConnection.toAddress(_server.address).then((__connection) async {
      print('Connected to the device');
      _connection = __connection;
      _disconnecting = false;

      _connection.input.listen(_onDataReceived).onDone(() {
        if (_disconnecting) {
          print('Disconnecting locally!');
        } else {
          print('Disconnected remotely!');
        }
      });
      // Initializing ELM327 protocol
      initialContact();
      // Send PID to OBD
      startScan(0);
      // _scanning = true;
    }).catchError((error) {
      print('Cannot connect, exception occured');
      print(error);
    });
    _sendQuery = true;
  }

  /**
  ** Function Name : dispose
  ** Description	 : 블루투스 연결 해제 기능
  */
  void dispose() {
    if (_connection != null) {
      print("closing connection");
      _disconnecting = true;
      _connection?.dispose();
      _connection = null;
      _server = null;
    }
  }

  /**
  ** Function Name : initialSwitch
  ** Description	 : 기본적으로 전송받을 데이터들을 선택
  */
  void initialSwitch() {
    _scanPID[OBDPid.ENGINE_SPEED.index] = true;
    _scanPID[OBDPid.CALCULATED_ENGINE_LOAD.index] = true;
    _scanPID[OBDPid.ENGINE_COOLANT_TEMPERATURE.index] = true;
    _scanPID[OBDPid.FUEL_TANK_LEVEL_INPUT.index] = true;
    _scanPID[OBDPid.VEHICLE_SPEED.index] = true;
    _scanPID[OBDPid.CONTROL_MODULE_VOLTAGE.index] = true;
    _scanPID[OBDPid.RELATIVE_ACCELERATOR_PEDAL_POSITTION.index] = true;
    _scanPID[OBDPid.RUN_TIME_SINCE_ENGINE_START.index] = true;
    _scanPID[OBDPid.FUEL_PRESSURE.index] = true;
    _scanPID[OBDPid.ENGINE_FUEL_RATE.index] = true;
    _scanPID[OBDPid.DISTANCE_TRAVELED_WITH_MIL_ON.index] = true;
    _scanPID[OBDPid.TIME_SINCE_TROUBLE_CODES_CLEARED.index] = true;
    _scanPID[OBDPid.THROTTLE_POSITION.index] = true;
  }

  /**
  ** Function Name : selectUnit
  ** Description	 : PIDname의 반환값에 맞는 적젏한 단위를 반환
  */
  int convertUnit(int PID, int value) {
    switch (PID) {
      case 4:
      case 17:
      case 90:
      case 91:
        return (100 / 255 * value).round();
      case 5:
        return value - 40;
      case 10:
        return value * 3;
      case 12:
      case 92:
        return (value / 4).round();
      case 66:
        return value * 1000;
      case 94:
        return (value / 20).round();
      default:
        return value;
    }
  }

  /**
  ** Function Name : selectUnit
  ** Description	 : PIDname의 반환값에 맞는 적젏한 단위를 반환
  */
  String selectUnit(String PIDname) {
    switch (PIDname) {
      case "ENGINE_SPEED":
        return "rpm";
      case "VEHICLE_SPEED":
        return "km/h";
      case "ENGINE_COOLANT_TEMPERATURE":
        return "˚C";
      case "BATTERY_CHARGE":
      case "THROTTLE_POSITION":
      case "CALCULATED_ENGINE_LOAD":
      case "FUEL_TANK_LEVEL_INPUT":
      case "RELATIVE_ACCELERATOR_PEDAL_POSITTION":
      case "HYBRID_BATTERY_PACK_REMAINING_LIFE":
        return "%";
      case "RUN_TIME_SINCE_ENGINE_START":
        return "sec";
      case "FUEL_PRESSURE":
        return "kPa";
      case "ENGINE_FUEL_RATE":
        return "L/h";
      case "CONTROL_MODULE_VOLTAGE":
        return "V";
      case "DISTANCE_TRAVELED_WITH_MIL_ON":
        return "km";
      case "TIME_SINCE_TROUBLE_CODES_CLEARED":
        return "min";
      default:
        return '';
    }
  }

  /**
  ** Function Name : initialContact
  ** Description	 : ELM327과 연결 성공 후, 차량과 통신에 사용할 OBD 프로토콜 셋업 등을 진행
  */
  Future initialContact() async {
    final Completer completer = Completer();

    // 현재 우리가 사용하는 ELM327은 OBD프로토콜 모드가 '자동' 으로 선택되어있음.
    // 프로토콜 자동 모드는, 최초로 차량에 요청을 보낼 때, 자동으로 차량이 사용하는 프로토콜을 감지함.
    await _sendMessage("01");
    print("waiting for setting up...");
    Timer(Duration(milliseconds: 500), () {
      print(_tempMessageList);
    });
    Timer(Duration(seconds: 5), () {
      // this means nothing but delaying for now.
      completer.complete(true);
      Timer(Duration(milliseconds: 500), () {
        print(_tempMessageList.first);
        if (_tempMessageList.first == 'UNABLE TO CONNECT') dispose();
      });
    });
    return completer.future;
  }

  /**
  ** Function Name : startScan
  ** Description	 : OBD연결이 성공하면 기본적으로 자동 수행할 작업
  */
  Future<void> startScan(int pid) async {
    if (_scanPID[pid] == true) {
      // 요청과 응답이 스트림에서 섞이지 않도록 적절한 딜레이를 설정
      await _makeFutureTimer(
          duration: Duration(milliseconds: 200),
          action: () {
            return pidQuery(pid);
          });
    }
    if (_connection == null) return;
    pid++;
    pid = (pid < PidName.length) ? pid : 0; // warning
    startScan(pid); // NO RECURSIVE
  }

  /**
  ** Function Name : pidQuery
  ** Description	 : OBD에 송신할 query를 만들고 스트림에 전송함
  */
  Future pidQuery(int pid) async {
    final Completer completer = Completer();
    String sending = '';

    sending = "01" + _toByteFormat(pid.toRadixString(16));
    await _sendMessage(sending);
    await _makeFutureTimer(
        duration: Duration(microseconds: 500), action: () {});
    print("pidQuery: $_tempMessageList"); // for test
    _tempMessageList;
    _tempMessageList.clear();
    completer.complete(true);
    return completer.future;
  }

  /**
  ** Function Name : makeFutureTimer
  ** Description	 : Timer가 비동기 함수이기에, 동기적으로 사용할 수 있는 함수를 만듦
  */
  Future _makeFutureTimer({Duration duration, Function action}) {
    final Completer completer = Completer();
    Timer(duration, () {
      dynamic returnValue = action();
      completer.complete(returnValue);
    });
    return completer.future;
  }

  /**
  ** Function Name : toByteFormat
  ** Description	 : 1 byte 단위의 16진수 문자열을 무조건 2자리로 만들어줌
  */
  String _toByteFormat(String hex) {
    if (hex.length == 1)
      return '0' + hex;
    else
      return hex;
  }

  /**
  ** Function Name : _sendMessage
  ** Description	 : 블루투스 시리얼 스트림을 통해 OBD로 text 전송
  */
  Future<void> _sendMessage(String text) async {
    text = text.trim();
    if (_connection == null) {
      print("connection is not setted");
      return;
    }
    _recentQuery = text;
    print("_sendMessage: $text");
    if (text.length > 0) {
      try {
        await _connection.output
            .add(Uint8List.fromList(utf8.encode(text + "\r\n")));
        await _connection.output.allSent;
      } catch (e) {
        // Ignore error, but notify state
        print("error: $text: $e");
      }
    }
  }

  /**
  ** Function Name : _onDataReceived
  ** Description	 : OBD에서 블루투스 시리얼 스트림으로 들어온 입력이 있을 때 작동할 함수
  **                  -> /n/r 단위로 끊어서 처리
  */
  void _onDataReceived(Uint8List data) {
    String dataString = String.fromCharCodes(data);

    var _messages = dataString.split('\r');
    _tempMessageList = _messages;
    _lastQuery = _recentQuery;

    String tmp;
    _message token;
    if (_messages.length > 1) {
      if (_messages[1].isEmpty == true && _messages.length > 2) {
        print("DATA: ${_messages[2]}");
        tmp = _messages[2];
      } else {
        print("DATA: ${_messages[1]}");
        tmp = _messages[1];
      }
    }
    if (tmp.isEmpty == false && tmp != ">") {
      token = _message(_messages[0].substring(2), tmp);
      _messageHandler(token);
    }
    // if (_tempMessageList.last != '>') {
    //   // if ELM hasn't sent the prompt (means on busy)
    //   _ELMBusy = true;
    //   print("ELM is busy...> ${_messages[1]}");
    // } else {
    //   // ELM sent the prompt (means ready)
    //   _ELMBusy = false;
    //   if (_ELMBusy == true) {
    //     if (_tempMessageList.first != _recentQuery) {
    //       print("listener: Last query failed");
    //     } else {
    //       print("result: $_recentQuery ${_tempMessageList.elementAt(1)}");
    //     }
    //   }
    // }
    // _connection.input.
  }

  int _pidToInt(String pid) {
    String tmp = pid.substring(2);
    int num = int.parse(tmp);
    if (num >= 0)
      return num;
    else
      return -1;
  }

  /**
  ** Function Name : _messageHandler
  ** Description	 : OBD에서 받아온 메시지에 따라 앱에 표시할 값을 수정
  */
  _message _messageHandler(_message msg) {
    int val;

    // timeout이면 값을 수정하지 않음
    print("token: ${msg.whom}/ ${msg.text}");
    if (msg.text == "Timeout") {
      return msg;
    } else {
      val = int.parse(_trimMessage(msg.text), radix: 16);
      print("token adf: ${val}");
    }
    int _pid = int.parse(msg.whom, radix: 16);

    if (_pid >= 0) {
      _values[_pid] = convertUnit(_pid, val);
    }
    // if (PidName.indexOf(msg.whom) == -1) {
    //   print("CommError: respond PID is not available");
    // } else {
    //   _values[PidName.indexOf(msg.whom)] = val;
    // }
    return msg;
  }

  /**
  ** Function Name : _trimMessage
  ** Description	 : "1A2B 3C 4D 5E" 형태의 문자열을 "3C4D5E" 형식으로 반환
  */
  String _trimMessage(String msg) {
    return msg.replaceAll(' ', '').substring(4);
  }

  /**
  ** Function Name : printMessage (테스트용)
  ** Description	 : printReceived의 하위 함수
  **                  -> OBD에서 받아와 리스트에 저장된 메시지 출력
  */
  void printMessage(_message msg) {
    print(msg.whom + ': ' + msg.text);
  }

  /**
  ** Function Name : printReceived (테스트용)
  ** Description	 : OBD에서 받아와 리스트에 저장된 메시지 출력, 출력한만큼 리스트에서 삭제
  */
  void printReceived() {
    int size = _messagesList.length;

    _messagesList.sublist(0, size).forEach((element) {
      printMessage(element);
    });
    _messagesList.removeRange(0, size);
  }

  get getValue => _values;
  get getScanFlag => _scanPID;
  get BAT_CHG => battery_charge;
  get getScanning => _scanning;

  get getServer => _server;
  set setServer(BluetoothDevice server) => _server = server;

  get getConnection => _connection;
  set setConnection(BluetoothConnection connection) => _connection = connection;

  get getConnected => _connected;
  set setConnected(bool connected) => _connected = connected;

  get Messages => _messagesList;
  get getMessageBuffer => _messageBuffer;
  set setMessageBuffer(String msgBuf) => _messageBuffer = msgBuf;
}
