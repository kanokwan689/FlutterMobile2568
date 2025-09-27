import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AirQualityPage extends StatefulWidget {
  const AirQualityPage({super.key});

  @override
  State<AirQualityPage> createState() => _AirQualityPageState();
}

class _AirQualityPageState extends State<AirQualityPage> {
  Map<String, dynamic>? airData;
  String? errorMsg;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      loading = true;
      errorMsg = null;
    });

    const token = "YOUR_API_TOKEN";
    final url = Uri.parse("https://api.waqi.info/feed/here/?token=e4d2c34740562a515c6dd95223f4f077d258255b");

    try {
      final response = await http.get(url);
      final data = json.decode(response.body);

      if (response.statusCode == 200 && data["status"] == "ok") {
        setState(() {
          airData = {
            "aqi": data["data"]["aqi"],
            "temp": data["data"]["iaqi"]["t"]?["v"], // อาจไม่มี
            "city": data["data"]["city"]?["name"] ?? "",
          };
          loading = false;
        });
      } else {
        setState(() {
          errorMsg = data["data"]?["message"] ?? "Failed to load data";
          loading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMsg = "Network Error: $e";
        loading = false;
      });
    }
  }

  Map<String, dynamic> getAqiLevel(int aqi) {
    if (aqi <= 50) {
      return {"label": "Good", "color": Colors.green, "icon": Icons.sentiment_very_satisfied};
    }
    if (aqi <= 100) {
      return {"label": "Moderate", "color": Colors.yellow[700], "icon": Icons.sentiment_satisfied};
    }
    if (aqi <= 150) {
      return {"label": "Unhealthy for Sensitive", "color": Colors.orange, "icon": Icons.sentiment_neutral};
    }
    if (aqi <= 200) {
      return {"label": "Unhealthy", "color": Colors.red, "icon": Icons.sentiment_dissatisfied};
    }
    if (aqi <= 300) {
      return {"label": "Very Unhealthy", "color": Colors.purple, "icon": Icons.mood_bad};
    }
    return {"label": "Hazardous", "color": Colors.brown, "icon": Icons.warning};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff4fbfd),
      appBar: AppBar(
        title: const Text("Air Quality Now", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: RefreshIndicator(
        onRefresh: fetchData,
        color: Colors.blue,
        child: loading
            ? const Center(child: CircularProgressIndicator())
            : errorMsg != null
                ? Center(child: Text(errorMsg!, style: const TextStyle(fontSize: 18, color: Colors.red)))
                : airData == null
                    ? const Center(child: Text("No data"))
                    : ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: [
                          const SizedBox(height: 40),
                          Center(
                            child: _buildAQICard(airData!),
                          ),
                          const SizedBox(height: 16),
                          _buildInfoRow(Icons.location_on, 'City', airData!["city"] ?? "-"),
                          _buildInfoRow(Icons.thermostat, 'Temperature', airData!["temp"] != null ? '${airData!["temp"]} °C' : 'N/A'),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 22.0, horizontal: 32.0),
                            child: ElevatedButton.icon(
                              onPressed: fetchData,
                              icon: const Icon(Icons.refresh),
                              label: const Text("Refresh"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.lightBlueAccent,
                                foregroundColor: Colors.white,
                                minimumSize: const Size.fromHeight(48),
                              ),
                            ),
                          ),
                        ],
                      ),
      ),
    );
  }

  Widget _buildAQICard(Map<String, dynamic> airData) {
    final int aqi = airData["aqi"] ?? 0;
    final aqiData = getAqiLevel(aqi);

    return Container(
      width: 210,
      height: 210,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            (aqiData["color"] as Color).withOpacity(0.7),
            (aqiData["color"] as Color).withOpacity(0.45),
            Colors.white,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.10), blurRadius: 32, offset: const Offset(0, 4))
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(aqiData["icon"], size: 48, color: aqiData["color"]),
            const SizedBox(height: 12),
            Text(
              "$aqi",
              style: TextStyle(
                fontSize: 64,
                fontWeight: FontWeight.bold,
                color: aqiData["color"],
              ),
            ),
            Text(
              aqiData["label"],
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: aqiData["color"]),
            ),
            const SizedBox(height: 2),
            const Text("AQI", style: TextStyle(fontSize: 14, color: Colors.black54)),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 38.0, vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueGrey, size: 28),
          const SizedBox(width: 14),
          Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
          const SizedBox(width: 18),
          Expanded(
            child: Text(value, textAlign: TextAlign.right,
                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w400, color: Colors.black87)),
          )
        ],
      ),
    );
  }
}