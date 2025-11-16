class OilPrice {
  final String name;
  final String company;
  final double price;

  OilPrice({required this.name, required this.company, required this.price});

  factory OilPrice.fromJson(Map<String, dynamic> json) {
    return OilPrice(
      name: json['name'] ?? 'Unknown',
      company: json['company'] ?? 'Unknown',
      // เพิ่มการตรวจสอบให้รัดกุมขึ้น
      // ถ้า price เป็น null หรือไม่ใช่ตัวเลข จะให้ค่าเป็น 0.0
      price: (json['price'] is num)
          ? (json['price'] as num).toDouble()
          : double.tryParse(json['price']?.toString() ?? '0.0') ?? 0.0,
    );
  }
}
