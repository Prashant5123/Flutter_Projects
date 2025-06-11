import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/network/api_client.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';
import '../models/register_request.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiClient _apiClient;
  final SharedPreferences _prefs;

  AuthRepositoryImpl(this._apiClient, this._prefs);

  @override
  Future<LoginResponse> login(String email, String password) async {
    try {
      final request = LoginRequest(username: email, password: password);
      return await _apiClient.login(request);
    } catch (e) {
      print('🔑 Login API error: $e');
      rethrow;
    }
  }

  @override
  Future<String> register(String email, String phoneNumber, String password) async {
    try {
      final request = RegisterRequest(
        email: email,
        phoneNumber: phoneNumber,
        password: password,
      );
      return await _apiClient.register(request);
    } catch (e) {
      print('🔑 Register API error: $e');
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _apiClient.logout();
    } catch (e) {
      print('🔑 Logout API error: $e');
      rethrow;
    }
  }

  @override
  Future<void> validateToken() async {
    try {
      await _apiClient.validateToken();
      return;
    } catch (e) {
      print('🔑 Token validation error: $e');
      rethrow;
    }
  }
}
