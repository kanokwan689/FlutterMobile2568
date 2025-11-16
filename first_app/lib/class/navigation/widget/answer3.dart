import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // 1. Import แพ็กเกจ http
import 'dart:convert'; // 2. Import สำหรับการแปลง JSON

// 3. นี่คือไฟล์สำหรับหน้าจอ API (ข้อ 3)
//    จะไม่มี main() หรือ MaterialApp อยู่ในนี้นะครับ

// 4. ใช้ StatefulWidget เพื่อเก็บสถานะการโหลดและข้อมูลที่ได้
class ApiFetchScreen extends StatefulWidget {
  const ApiFetchScreen({super.key});

  @override
  State<ApiFetchScreen> createState() => _ApiFetchScreenState();
}

class _ApiFetchScreenState extends State<ApiFetchScreen> {
  // 5. สร้างตัวแปร State เพื่อเก็บ "สถานะ" ของหน้าจอ
  String _apiResponse = 'กำลังรอ...'; // เก็บผลลัพธ์ที่ได้จาก API
  bool _isLoading = false; // เก็บสถานะว่ากำลังโหลดอยู่หรือไม่

  // 6. สร้างฟังก์ชันสำหรับดึงข้อมูลจาก API
  Future<void> _fetchMyIP() async {
    // 7. สั่งให้หน้าจอ "อัปเดต" ว่ากำลังโหลด (แสดงวงกลมหมุน)
    setState(() {
      _isLoading = true;
      _apiResponse = 'กำลังโหลดข้อมูล...';
    });

    try {
      // 8. สร้าง URL ที่ต้องการยิง API
      final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');

      // 9. ยิง request ไปที่ API และรอคำตอบ (ใช้ http.get)
      final response = await http.get(url);

      // 10. ตรวจสอบว่า API ตอบกลับมาสำเร็จ (รหัส 200)
      if (response.statusCode == 200) {
        // 11. แปลงข้อความ JSON ที่ได้มา (response.body) ให้เป็น Object ที่ Dart ใช้งานได้
        final data = json.decode(response.body);
        final ip = data['ip']; // 12. ดึงค่า 'ip' ออกมาจาก Object

        // 13. อัปเดตหน้าจอด้วยข้อมูล IP ที่ได้มา
        setState(() {
          _apiResponse = 'IP Address ของคุณคือ:\n$ip';
          _isLoading = false;
        });
      } else {
        // 14. กรณีที่ API ตอบกลับมาไม่สำเร็จ (เช่น 404, 500)
        setState(() {
          _apiResponse = 'เกิดข้อผิดพลาด: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      // 15. กรณีที่เกิด Error ระหว่างเชื่อมต่อ (เช่น ไม่มีเน็ต)
      setState(() {
        _apiResponse = 'เชื่อมต่อล้มเหลว: $e';
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // 16. สั่งให้ดึงข้อมูล API ทันที 1 ครั้ง เมื่อหน้าจอนี้ถูกสร้างขึ้นมา
    _fetchMyIP();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post List'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 17. ส่วนที่แสดงผลลัพธ์
              Text(
                _apiResponse,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),

              // 18. ถ้ากำลังโหลด (_isLoading == true) ให้แสดงวงกลมหมุนๆ
              if (_isLoading)
                const CircularProgressIndicator()
              else
                // 19. ถ้าโหลดเสร็จแล้ว ให้แสดงปุ่ม "โหลดใหม่"
                ElevatedButton(
                  onPressed: _fetchMyIP, // กดปุ่มเพื่อเรียกฟังก์ชันดึงข้อมูลอีกครั้ง
                  child: const Text('ดึงข้อมูลใหม่'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}