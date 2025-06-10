import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../shared_storage_services/storage_services.dart';

class AuthService {
  final _storageService = StorageService();

  /// Login and return full user data
  Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('https://dummyjson.com/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
        'expiresInMins': 30,
      }),
    );

    if (response.statusCode == 200) {
      final userData = jsonDecode(response.body);

      // ✅ Save the token AND user data (optionally)
      await _storageService.saveToken(userData['token']);
      await _storageService.saveUserData(jsonEncode(userData)); // You can remove this if not persisting

      return userData;
    } else {
      final error = jsonDecode(response.body)['message'];
      throw Exception(error ?? 'Login failed');
    }
  }

  /// Simulate checking login status using token (e.g., token validation or stored user data)
  Future<Map<String, dynamic>> getSavedUserData() async {
    final token = await _storageService.getToken();

    if (token != null && token.isNotEmpty) {
      // You could also call `/auth/me` if supported, but here we simulate with storage
      // Simulated saved data retrieval
      final storedUserData = await _storageService.getUserData(); // (Optional)
      if (storedUserData != null) {
        return jsonDecode(storedUserData);
      } else {
        // return dummy user if no data saved, only token present
        return {'token': token}; // minimal data
      }
    } else {
      throw Exception('No valid token found');
    }
  }
}
