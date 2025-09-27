import 'package:http/http.dart' as http;
import 'dart:convert';
void main() {
 void fetchUser() async {
 try {
 var response = await http
 .get(Uri.parse('https://jsonplaceholder.typicode.com/users/1'));
 if (response.statusCode == 200) {
 var data = jsonDecode(response.body);
 print('Name: ${data["name"]}');
 } else {
 print('Failed to fetch data');
 }
 } catch (e) {
 print('Error: $e');
 }
 }
 fetchUser();
}