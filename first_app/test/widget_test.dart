// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:first_app/main.dart';

void main() {
  testWidgets('DashboardPage shows AppBar title', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // รอให้ UI แสดงผลจนเสร็จ (รวมถึง FutureBuilder)
    await tester.pumpAndSettle();

    // ตรวจสอบว่ามีข้อความ "ราคาน้ำมันล่าสุด" แสดงอยู่บนหน้าจอ 1 ที่
    expect(find.text('ราคาน้ำมันล่าสุด'), findsOneWidget);
  });
}
