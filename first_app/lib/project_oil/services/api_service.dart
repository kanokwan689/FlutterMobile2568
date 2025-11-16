import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/oil_model.dart';

class ApiService {
  static const String apiUrl = "https://api.chnwt.dev/thai-oil-api/latest";

  // ดึงข้อมูลราคาน้ำมันทั้งหมด
  static Future<List<OilPrice>> fetchLatest() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        // 1. แก้ไข: ตรวจสอบ key 'response' และ 'stations'
        if (jsonData['response'] == null || jsonData['response']['stations'] == null) {
          throw Exception("Invalid API response format: Missing 'stations' data.");
        }
        // 2. แก้ไข: เปลี่ยนจาก 'prices' เป็น 'stations'
        final stationsByCompany = jsonData['response']['stations'] as Map<String, dynamic>;
        
        // 3. ปรับปรุงการสร้าง List ให้สอดคล้องกับโครงสร้างข้อมูลจริง
        final List<OilPrice> oils = stationsByCompany.entries.expand((companyEntry) {
          final company = companyEntry.key;
          final oilPrices = companyEntry.value as Map<String, dynamic>;
          return oilPrices.entries.map((oilEntry) {
            // 4. แก้ไข: ดึง 'name' และ 'price' จาก object ที่ซ้อนอยู่ข้างใน
            final oilDetails = oilEntry.value as Map<String, dynamic>;
            final String oilName = oilDetails['name'] ?? oilEntry.key; // ใช้ key เป็นชื่อสำรอง
            final dynamic price = oilDetails['price'];
            return OilPrice.fromJson({'name': oilName, 'company': company, 'price': price});
          });
        }).toList();
        return oils;
      } else {
        throw Exception("Failed to load data: Server responded with code ${response.statusCode}");
      }
    } catch (e) {
      // 3. ดักจับข้อผิดพลาดทั้งหมด (เช่น ไม่มีเน็ต, JSON ผิดรูปแบบ) และส่งต่อ
      // ทำให้ส่วน UI จัดการ Error ได้ในที่เดียว
      throw Exception("An error occurred: ${e.toString()}");
    }
  }
}
