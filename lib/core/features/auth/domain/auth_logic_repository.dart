import 'dart:convert';

import '../data/auth_api_service.dart';
import '../../../shared_storage_services/storage_services.dart';

class AuthRepository {
  final AuthService _authService = AuthService();
  final StorageService _storageService = StorageService();

  /// Login using AuthService and return user data
  Future<Map<String, dynamic>> login(String username, String password) async {
    return await _authService.login(username, password);
  }

  /// Check whether token exists in storage
  Future<bool> isLoggedIn() async {
    final token = await _storageService.getToken();
    return token != null && token.isNotEmpty;
  }

  /// Optional: Get full user data if stored
  Future<Map<String, dynamic>> getUserData() async {
    final data = await _storageService.getUserData();
    if (data != null) {
      return Future.value(jsonDecode(data));
    } else {
      throw Exception('No user data found');
    }
  }

  /// Get stored token (optional)
  Future<String?> getToken() async {
    return await _storageService.getToken();
  }

  /// Logout and clear storage
  Future<void> logOut() async {
    await _storageService.clear();
  }
}
