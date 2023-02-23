import 'package:bitel_ventas/main/utils/native_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DemoNativePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DemoNativeStatePage();
  }
}

class DemoNativeStatePage extends State<DemoNativePage> {
  String _batteryLevel = 'Unknown battery level.';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onListenerMethod();
  }
  void onListenerMethod(){
      NativeUtil.platform.setMethodCallHandler((call) async{
        if(call.method == "reportBa"){
          int level = call.arguments;
          setState(() {
            this._batteryLevel = "$level pin";
          });
        }
      });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: _getBatteryLevel,
              child: const Text('Get Battery Level'),
            ),
            Text(_batteryLevel),
          ],
        ),
      ),
    );
  }


  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final argument = {"name": "DuongNH"};
      final String result =
          await NativeUtil.platform.invokeMethod('getBatteryLevel', argument);
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }
}
