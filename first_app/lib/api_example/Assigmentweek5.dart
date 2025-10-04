import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Assigmentweek5 extends StatefulWidget {
  const Assigmentweek5({super.key});

  @override
  State<Assigmentweek5> createState() => _Assigmentweek5State();
}

class _Assigmentweek5State extends State<Assigmentweek5> {
  List<Product> products = [];

  Future<void> fetchData() async {
    try {
      var response = await http.get(

        Uri.parse('http://localhost:8001/products'),
      );
      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        setState(() {
          products = jsonList.map((e) => Product.fromJson(e)).toList();
        });
      } else {
        throw Exception("Failed to load products");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> createProduct() async {
    try {
      var response = await http.post(
        Uri.parse("http://localhost:8001/products"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": "iPhone 5s",
          "description": "Apple smartphone",
          "price": 21999.00,
        }),
      );
      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Create success!'),
            backgroundColor: Colors.green,
          ),
        );
        fetchData();
      } else {
        throw Exception("Failed to load products");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateProduct({required dynamic idUpdate}) async {
    try {
      var response = await http.put(
        Uri.parse("http://localhost:8001/products/$idUpdate"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": "iPhone 17",
          "description": "Apple smartphone",
          "price": 40900.00,
        }),
      );
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Update success!'),
          backgroundColor: Colors.blue,
        ));
        fetchData();
      } else {
        throw Exception("Failed to load products");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteProduct({required dynamic idDelete}) async {
    try {
      var response = await http.delete(
        Uri.parse("http://localhost:8001/products/$idDelete"),
      );
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Delete success!'),
          backgroundColor: Colors.red,
        ));
        fetchData();
      } else {
        throw Exception("Failed to delete products");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData(); // โหลดข้อมูลตอนเปิดหน้าจอ
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 5, 79, 87),
          title: const Text('Product', style: TextStyle(color: Colors.white))),
      body: ListView.separated(
        itemCount: products.length,
        separatorBuilder: (context, index) => const Divider(
          height: 1,
          color: Colors.grey,
        ),
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            leading: Text('${index + 1}'),
            title: Text(
              product.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(product.description),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${product.price.toStringAsFixed(1)} ฿',
                  style: const TextStyle(color: Colors.green),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text("ยืนยันการลบ"),
                        content: Text(
                            "คุณต้องการลบสินค้า '${product.name}' หรือไม่?"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("ยกเลิก"),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              deleteProduct(idDelete: product.id);
                            },
                            child: const Text("ลบ"),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
            onTap: () {
              // TODO: เปิดฟอร์มแก้ไขสินค้าหากต้องการ
              // เช่น updateProduct(idUpdate: product.id);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createProduct,
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Model สำหรับสินค้า
class Product {
  final String id;
  final String name;
  final String description;
  final double price;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'].toString(),
      name: json['name'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
    );
  }
}