part of 'homeListView.dart';

class drawerForSetting extends StatefulWidget {
  drawerForSetting({Key key}) : super(key: key);
  
  @override
  State<drawerForSetting> createState() => drawerForSettingState();
}

class drawerForSettingState extends State<drawerForSetting> {
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
  carInfo info = carInfo();
  String message = '';

  String _address = "...";
  String _name = "...";

  Timer _discoverableTimeoutTimer;
  int _discoverableTimeoutSecondsLeft = 0;

  BackgroundCollectingTask _collectingTask;

  bool _autoAcceptPairingRequests = false;
  Color btn_color = Color(0xff6161F5);

  @override
  void initState() {
    super.initState();

    // Get current state
    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        _bluetoothState = state;
      });
    });

    Future.doWhile(() async {
      // Wait if adapter not enabled
      if ((await FlutterBluetoothSerial.instance.isEnabled) ?? false) {
        return false;
      }
      await Future.delayed(Duration(milliseconds: 0xDD));
      return true;
    }).then((_) {
      // Update the address field
      FlutterBluetoothSerial.instance.address.then((address) {
        setState(() {
          _address = address;
        });
      });
    });

    FlutterBluetoothSerial.instance.name.then((name) {
      setState(() {
        _name = name;
      });
    });

    // Listen for futher state changes
    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      setState(() {
        _bluetoothState = state;

        // Discoverable mode is disabled when Bluetooth gets disabled
        _discoverableTimeoutTimer = null;
        _discoverableTimeoutSecondsLeft = 0;
      });
    });
  }

  @override
  void dispose() {
    FlutterBluetoothSerial.instance.setPairingRequestHandler(null);
    _collectingTask?.dispose();
    _discoverableTimeoutTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width * 0.9;

    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      child: Container(
        width: width,
        height: height,
        color: btn_color,
        child: ListView(
          children: [
            Padding(padding: EdgeInsets.all(20)),
            SwitchListTile(
              title: const Text('블루투스',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
              value: _bluetoothState.isEnabled,
              onChanged: (bool value) {
                // Do the request and update with the true value then
                future() async {
                  // async lambda seems to not working
                  if (value)
                    await FlutterBluetoothSerial.instance.requestEnable();
                  else
                    await FlutterBluetoothSerial.instance.requestDisable();
                }

                future().then((_) {
                  setState(() {});
                });
              },
            ),
            ListTile(
              title: const Text('블루투스 상태',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
              subtitle: Text((_bluetoothState == BluetoothState.STATE_ON)
                  ? "연결"
                  : (_bluetoothState == BluetoothState.STATE_OFF)
                      ? "끊김"
                      : "모름"),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffffffff),
                ),
                child: const Text(
                  '설정',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  FlutterBluetoothSerial.instance.openSettings();
                },
              ),
            ),
            ListTile(
              title: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffffffff),
                ),
                child: const Text(
                  '진단 장치 선택',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () async {
                  final BluetoothDevice selectedDevice =
                      await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return SelectBondedDevicePage(checkAvailability: false);
                      },
                    ),
                  );
                  if (selectedDevice != null) {
                    setState(() {
                      info.startComm(context, selectedDevice);
                    });
                    print('Connect -> selected OBD ' + info.getServer.address);
                  } else {
                    print('Connect -> no device selected');
                  }
                },
              ),
            ),
            ListTile(
              title: const Text(
                '진단 장치 연결 상태',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                (info.getConnection.toString() == "null") ? "연결 끊김" : "연결 중",
              ),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffffffff),
                ),
                child: const Text(
                  '연결 끊기',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    info.dispose();
                  });
                },
              ),
            ),
            ListTile(
              title: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffffffff),
                ),
                child: const Text(
                  '디버깅 모니터',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () async {
                  final BluetoothDevice selectedDevice =
                      await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return SelectBondedDevicePage(checkAvailability: false);
                      },
                    ),
                  );

                  if (selectedDevice != null) {
                    print('Connect -> selected ' + selectedDevice.address);
                    _startChat(context, selectedDevice);
                  } else {
                    print('Connect -> no device selected');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _startChat(BuildContext context, BluetoothDevice server) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return ChatPage(server: server);
        },
      ),
    );
  }
}
