import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  final String data;
  const SecondPage({super.key, required this.data});
  //const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
        backgroundColor: Colors.blueAccent,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text(
              data, // <-- นำตัวแปร data มาใช้ตรงนี้
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20), 

            ElevatedButton(
              
              onPressed: () {
                Navigator.pop(context);
              },
              
              child: const Text('กลับไปหน้าแรก (Go Back)'),
            )
          ],
        ),
      ),
    );
  }
}