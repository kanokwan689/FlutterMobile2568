import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class BmiCalculatorScreen extends StatefulWidget {
  const BmiCalculatorScreen({super.key});

  @override
  State<BmiCalculatorScreen> createState() => _BmiCalculatorScreenState();
}

class _BmiCalculatorScreenState extends State<BmiCalculatorScreen> {
  
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  String _resultMessage = 'กรุณากรอกน้ำหนักและส่วนสูง';

  void _calculateBmi() {

    final double? weight = double.tryParse(_weightController.text);
    final double? height = double.tryParse(_heightController.text);

    if (weight == null || height == null || weight <= 0 || height <= 0) {
  
      setState(() {
        _resultMessage = 'กรุณาใส่ตัวเลขน้ำหนักและส่วนสูงให้ถูกต้อง';
      });
      return;
    }

    final double bmi = weight / (height * height);
    String interpretation;

    if (bmi < 18.5) {
      interpretation = ' (น้ำหนักน้อยกว่าเกณฑ์)';
    } else if (bmi < 24.9) {
      interpretation = ' (น้ำหนักปกติ)';
    } else if (bmi < 29.9) {
      interpretation = ' (น้ำหนักเกินเกณฑ์)';
    } else {
      interpretation = ' (โรคอ้วน)';
    }

    setState(() {
      _resultMessage =
          'ค่า BMI ของคุณคือ: ${bmi.toStringAsFixed(2)}\n$interpretation';
    });
  }

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('คำนวณ BMI'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _weightController,
              decoration: const InputDecoration(
                labelText: 'น้ำหนัก (kg)',
                border: OutlineInputBorder(),
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 20),

            TextField(
              controller: _heightController,
              decoration: const InputDecoration(
                labelText: 'ส่วนสูง (m เช่น 1.75)',
                border: OutlineInputBorder(),
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: _calculateBmi, 
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: const Text('คำนวณ BMI'),
            ),
            const SizedBox(height: 30),

            Text(
              _resultMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}