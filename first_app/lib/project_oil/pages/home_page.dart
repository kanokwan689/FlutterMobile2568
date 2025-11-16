import 'package:flutter/material.dart';
import 'dashboard_page.dart';
import 'cheapest_page.dart';
import 'about_page.dart';
import 'report_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // 1. เก็บรายการของหน้า (Widget) ที่จะแสดงผลไว้เหมือนเดิม
  final List<Widget> _pages = [
    DashboardPage(),
    CheapestPage(),
    ReportPage(),
    AboutPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 2. ใช้ IndexedStack เพื่อรักษาสถานะ (State) ของแต่ละหน้าไว้
      //    เมื่อสลับแท็บ จะไม่ต้องโหลดข้อมูลใหม่ทุกครั้ง
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        // 3. AppBar ของแต่ละหน้าจะถูกแสดงผลอย่างถูกต้องแล้ว
        type: BottomNavigationBarType.fixed, // 1. กำหนด type เป็น fixed เพื่อให้แสดงชื่อทุกเมนู
        selectedItemColor: Theme.of(context).colorScheme.primary, // 2. สีของเมนูที่ถูกเลือก (ใช้สีหลักของแอป)
        unselectedItemColor: Colors.grey.shade600, // 3. สีของเมนูที่ยังไม่ถูกเลือก
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'ราคาทั้งหมด'),
          BottomNavigationBarItem(icon: Icon(Icons.local_gas_station), label: 'ราคาถูกสุด'),
          BottomNavigationBarItem(icon: Icon(Icons.report_problem), label: 'แจ้งปัญหา'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'เกี่ยวกับ'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}