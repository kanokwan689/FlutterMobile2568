import 'package:flutter/material.dart';
import '../models/oil_model.dart';
import '../services/api_service.dart';

class CheapestPage extends StatefulWidget {
  @override
  _CheapestPageState createState() => _CheapestPageState();
}

class _CheapestPageState extends State<CheapestPage> {
  late Future<OilPrice> cheapestOil;

  Future<OilPrice> _getCheapest() async {
    final data = await ApiService.fetchLatest();
    // กรองข้อมูลที่มีราคามากกว่า 0 ออกมา เพื่อป้องกันข้อมูลที่ไม่ถูกต้อง
    final validPrices = data.where((oil) => oil.price > 0).toList();

    // ตรวจสอบว่ามีข้อมูลที่ถูกต้องหรือไม่ ก่อนที่จะเรียงลำดับ
    if (validPrices.isEmpty) {
      throw Exception("ไม่พบข้อมูลราคาน้ำมันที่ถูกต้อง");
    }
    validPrices.sort((a, b) => a.price.compareTo(b.price));
    return validPrices.first;
  }

  @override
  void initState() {
    super.initState();
    cheapestOil = _getCheapest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('น้ำมันราคาถูกสุดวันนี้')),
      body: FutureBuilder<OilPrice>(
        future: cheapestOil,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("ไม่สามารถโหลดข้อมูลได้", style: TextStyle(fontSize: 16)),
                  SizedBox(height: 8),
                  Text("${snapshot.error.toString().replaceAll("Exception: ", "")}", style: TextStyle(color: Colors.grey[600])),
                  SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () => setState(() => cheapestOil = _getCheapest()),
                    icon: Icon(Icons.refresh),
                    label: Text("ลองใหม่"),
                  ),
                ],
              ),
            );
          }
          final oil = snapshot.data!;
          return Center(
            child: Container(
              margin: const EdgeInsets.all(24.0),
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [Colors.deepPurple.shade400, Colors.purple.shade600],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple.withOpacity(0.3),
                    blurRadius: 15,
                    offset: Offset(0, 5),
                  )
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.emoji_events, color: Colors.amber, size: 50),
                  SizedBox(height: 16),
                  Text(
                    oil.name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "${oil.price.toStringAsFixed(2)} บาท",
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: 4),
                  Text("ที่ปั๊ม ${oil.company.toUpperCase()}", style: TextStyle(fontSize: 16, color: Colors.white70)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
