import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    home: BatteryLevelScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class BatteryLevelScreen extends StatefulWidget {
  @override
  _BatteryLevelScreenState createState() => _BatteryLevelScreenState();
}

class _BatteryLevelScreenState extends State<BatteryLevelScreen> {
  static const MethodChannel _platform =
      MethodChannel('com.example.batterylevel/battery');

  String _batteryLevel = 'Unknown battery level.';

  Future<void> _getBatteryLevel() async {
    String newLevel;
    try {
      final result = await _platform.invokeMethod('getBatteryLevel');
      final int battery = result as int;
      newLevel = 'Battery level at $battery%.';
    } on PlatformException catch (e) {
      newLevel = "Failed to get battery level: ${e.message}";
    }
    setState(() {
      _batteryLevel = newLevel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Battery Level')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_batteryLevel),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _getBatteryLevel,
              child: Text('Get Battery Level'),
            ),
          ],
        ),
      ),
    );
  }
}
