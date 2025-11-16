import 'package:flutter/material.dart';

class CounterFullwidget extends StatefulWidget {
  const CounterFullwidget({super.key});

   @override
  State<CounterFullwidget> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterFullwidget> {
  // --- State ---
  // ตัวแปรที่เก็บค่าตัวเลข
  int _counter = 0;

  // --- Logic ---
  // ฟังก์ชันที่ถูกเรียกเมื่อกดปุ่มบวก
  void _incrementCounter() {
    // บอก Flutter ให้วาดหน้าจอใหม่ด้วยค่า _counter ที่อัปเดตแล้ว
    setState(() {
      _counter++;
    });
  }

  // --- UI ---
  // เมธอดที่สร้างหน้าจอ
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Counter App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter, 
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}