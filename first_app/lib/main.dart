import 'package:first_app/api_example/api_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Air Quality App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      // *** นี่คือส่วนที่ต้องแก้ไข ***
      // กำหนดให้ AirQualityPage เป็นหน้าแรก (home) ของแอป
      home: const AirQualityPage(),
    );
  }
}