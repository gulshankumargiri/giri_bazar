import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  final response = await http.post(
    Uri.parse('https://dummyjson.com/auth/login'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'username': 'emilys',
      'password': 'emilyspass',
      'expiresInMins': 30,
    }),
  );

  print('Status code: ${response.statusCode}');
  print('Response body: ${response.body}');
}
