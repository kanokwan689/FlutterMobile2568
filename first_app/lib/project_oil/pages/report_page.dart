import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  // Key สำหรับจัดการ Form และใช้ในการ validate ข้อมูล
  final _formKey = GlobalKey<FormState>();
  // Controller สำหรับดึงค่าจากช่องกรอก "หัวข้อ"
  final _titleController = TextEditingController();
  // Controller สำหรับดึงค่าจากช่องกรอก "รายละเอียด"
  final _detailsController = TextEditingController();
  // State สำหรับควบคุมการแสดงผล loading indicator (วงกลมหมุนๆ)
  bool _isLoading = false;

  // ฟังก์ชันที่จะทำงานเมื่อกดปุ่ม "ส่งรายงาน"
  Future<void> _submitReport() async {
    // ตรวจสอบว่าข้อมูลในฟอร์มผ่านเงื่อนไข (validator) ทั้งหมดหรือไม่
    if (_formKey.currentState!.validate()) {
      // อัปเดต UI ให้แสดงสถานะกำลังโหลด
      setState(() => _isLoading = true);

      try {
        // ส่ง HTTP POST request ไปยัง API ทดสอบ
        final response = await http.post(
          Uri.parse('https://jsonplaceholder.typicode.com/posts'),
          // บอก API ว่าเราส่งข้อมูลในรูปแบบ JSON
          headers: {'Content-Type': 'application/json'},
          // แปลงข้อมูลจาก Controller ให้เป็น String ในรูปแบบ JSON
          body: jsonEncode({
            'title': _titleController.text,
            'details': _detailsController.text,
            'user': 'Yves', // ใส่ข้อมูลเพิ่มเติม เช่น ชื่อผู้ใช้
          }),
        );

        // ตรวจสอบว่า API ตอบกลับมาว่าสร้างข้อมูลสำเร็จ (Status Code 201)
        if (response.statusCode == 201) {
          // แสดงข้อความแจ้งเตือนว่าส่งสำเร็จ
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('ส่งรายงานสำเร็จ!'), backgroundColor: Colors.green),
          );
          // ล้างข้อมูลในฟอร์มและ Controller ทั้งหมด
          _formKey.currentState?.reset();
          _titleController.clear();
          _detailsController.clear();
        } else {
          // ถ้าไม่สำเร็จ ให้โยน Exception เพื่อให้ catch ทำงาน
          throw Exception('Failed to submit report. Status code: ${response.statusCode}');
        }
      } catch (e) {
        // ดักจับข้อผิดพลาด (เช่น ไม่มีเน็ต, API error) แล้วแสดงข้อความแจ้งเตือน
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('เกิดข้อผิดพลาด: ${e.toString()}'), backgroundColor: Colors.red),
        );
      } finally {
        // ไม่ว่าจะสำเร็จหรือล้มเหลว ให้หยุดการแสดงสถานะโหลดเสมอ
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('แจ้งปัญหา/รายงานข้อมูล')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // ช่องกรอกหัวข้อปัญหา
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'หัวข้อปัญหา', border: OutlineInputBorder()),
                // ตรวจสอบว่ามีข้อมูลกรอกหรือไม่
                validator: (value) => (value == null || value.isEmpty) ? 'กรุณากรอกหัวข้อ' : null,
                // ให้ validator ทำงานทันทีที่ผู้ใช้พิมพ์
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(height: 16),
              // ช่องกรอกรายละเอียด
              TextFormField(
                controller: _detailsController,
                decoration: const InputDecoration(labelText: 'รายละเอียด', border: OutlineInputBorder()),
                maxLines: 4,
                validator: (value) => (value == null || value.isEmpty) ? 'กรุณากรอกรายละเอียด' : null,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(height: 24),
              // ถ้ากำลังโหลด (_isLoading) ให้แสดงวงกลมหมุนๆ, ถ้าไม่ ให้แสดงปุ่ม
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton.icon(
                      onPressed: _submitReport,
                      icon: const Icon(Icons.send),
                      label: const Text('ส่งรายงาน'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  // ฟังก์ชันนี้จะถูกเรียกเมื่อ Widget ถูกทำลาย
  @override
  void dispose() {
    // คืนค่า memory ที่ Controller ใช้งานอยู่ เพื่อป้องกัน memory leak
    _titleController.dispose();
    _detailsController.dispose();
    super.dispose();
  }
}