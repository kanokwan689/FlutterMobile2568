import 'package:flutter/material.dart';

// Enum และ Widget ทั้งหมดย้ายมาอยู่ที่นี่
enum TrafficLightState { red, yellow, green }

class TrafficLightScreen extends StatefulWidget {
  const TrafficLightScreen({super.key});

  @override
  State<TrafficLightScreen> createState() => _TrafficLightScreenState();
}

class _TrafficLightScreenState extends State<TrafficLightScreen> {
  TrafficLightState _currentState = TrafficLightState.red;

  void _changeLight() {
    setState(() {
      switch (_currentState) {
        case TrafficLightState.red:
          _currentState = TrafficLightState.yellow;
          break;
        case TrafficLightState.yellow:
          _currentState = TrafficLightState.green;
          break;
        case TrafficLightState.green:
          _currentState = TrafficLightState.red;
          break;
      }
    });
  }

  Widget _buildLightWidget(Color color, bool isActive) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 500),
        opacity: isActive ? 1.0 : 0.3,
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              if (isActive)
                BoxShadow(
                  color: color.withOpacity(0.7),
                  blurRadius: 15,
                  spreadRadius: 5,
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Traffic Light Animation'),
        backgroundColor: Colors.grey[850],
      ),
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey[800]!, width: 4),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildLightWidget(
                      Colors.red, _currentState == TrafficLightState.red),
                  _buildLightWidget(Colors.yellow,
                      _currentState == TrafficLightState.yellow),
                  _buildLightWidget(
                      Colors.green, _currentState == TrafficLightState.green),
                ],
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _changeLight,
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: const Text('เปลี่ยนไฟ'),
            ),
          ],
        ),
      ),
    );
  }
}
