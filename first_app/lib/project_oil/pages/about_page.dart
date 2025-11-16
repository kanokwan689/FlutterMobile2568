import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('เกี่ยวกับแอป')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.deepPurple,
                child: Icon(Icons.local_gas_station, size: 50, color: Colors.white),
              ),
              const SizedBox(height: 20),
              const Text(
                "Thai Oil Dashboard",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                "แอปพลิเคชันแสดงราคาน้ำมันล่าสุดในประเทศไทย",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
              ),
              const Divider(height: 40),
              _buildInfoRow(Icons.person, "ผู้จัดทำ", "Yves"),
              const SizedBox(height: 12),
              _buildInfoRow(Icons.code, "API GET", "api.chnwt.dev"),
              const SizedBox(height: 12),
              _buildInfoRow(Icons.send, "API POST", "jsonplaceholder.typicode.com"),
              const Spacer(),
              Text("Version 1.0.0", style: TextStyle(color: Colors.grey.shade500)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(children: [
          Icon(icon, color: Colors.grey.shade700),
          const SizedBox(width: 12),
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        ]),
        Text(value, style: TextStyle(fontSize: 16, color: Colors.grey.shade800))
      ],
    );
  }
}
