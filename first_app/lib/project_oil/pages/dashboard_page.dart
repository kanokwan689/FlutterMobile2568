import 'package:flutter/material.dart';
import '../models/oil_model.dart';
import '../services/api_service.dart';
import 'animated_list_item.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late Future<List<OilPrice>> oilData;

  @override
  void initState() {
    super.initState();
    oilData = ApiService.fetchLatest();
  }

  // Helper function เพื่อสร้างสีและไอคอนสำหรับแต่ละบริษัท
  Map<String, dynamic> _getCompanyBranding(String company) {
    String lowerCaseCompany = company.toLowerCase();
    if (lowerCaseCompany.contains('ptt')) {
      return {'color': Colors.blue.shade700, 'icon': Icons.local_gas_station};
    } else if (lowerCaseCompany.contains('bcp') || lowerCaseCompany.contains('bangchak')) {
      return {'color': Colors.green.shade600, 'icon': Icons.eco};
    } else if (lowerCaseCompany.contains('shell')) {
      return {'color': Colors.red.shade700, 'icon': Icons.shield};
    } else if (lowerCaseCompany.contains('esso')) {
      return {'color': Colors.blue.shade900, 'icon': Icons.local_gas_station};
    } else if (lowerCaseCompany.contains('caltex')) {
      return {'color': Colors.red.shade900, 'icon': Icons.star};
    } else if (lowerCaseCompany.contains('pt')) {
      return {'color': Colors.green.shade800, 'icon': Icons.local_gas_station};
    } else if (lowerCaseCompany.contains('susco')) {
      return {'color': Colors.deepOrange.shade700, 'icon': Icons.local_gas_station};
    } else {
      return {'color': Colors.grey.shade600, 'icon': Icons.gas_meter};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ราคาน้ำมันล่าสุด')),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() => oilData = ApiService.fetchLatest());
        },
        child: FutureBuilder<List<OilPrice>>(
          future: oilData,
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
                    // แสดงรายละเอียด Error เพื่อช่วยในการ Debug
                    Text("${snapshot.error.toString().replaceAll("Exception: ", "")}", style: TextStyle(color: Colors.grey[600])),
                    SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () => setState(() => oilData = ApiService.fetchLatest()),
                      icon: Icon(Icons.refresh),
                      label: Text("ลองใหม่"),
                    ),
                  ],
                ),
              );
            }
            final data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final oil = data[index];
                final branding = _getCompanyBranding(oil.company);
                final companyColor = branding['color'] as Color;
                final companyIcon = branding['icon'] as IconData;

                return AnimatedListItem(
                  index: index,
                  child: Card(
                    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: companyColor.withOpacity(0.15),
                            child: Icon(companyIcon, color: companyColor),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(oil.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                SizedBox(height: 2),
                                Text(oil.company.toUpperCase(), style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                              ],
                            ),
                          ),
                          SizedBox(width: 16),
                          Text("${oil.price.toStringAsFixed(2)}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
