import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../di/injection.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/data/models/user_model.dart';

// Simple auth state provider
final authProvider = StateNotifierProvider<AuthNotifier, UserModel?>((ref) {
  final authRepository = getIt<AuthRepository>();
  final prefs = getIt<SharedPreferences>();
  return AuthNotifier(authRepository, prefs);
});

// Loading state provider
final authLoadingProvider = StateProvider<bool>((ref) => false);

class AuthNotifier extends StateNotifier<UserModel?> {
  final AuthRepository _authRepository;
  final SharedPreferences _prefs;
  
  AuthNotifier(this._authRepository, this._prefs) : super(null) {
    print('🔑 AuthNotifier initialized');
    _checkInitialAuthState();
  }

  // Check initial auth state
  Future<void> _checkInitialAuthState() async {
    try {
      final token = _prefs.getString('auth_token');
      print('🔑 Checking initial auth state, token exists: ${token != null}');
      
      if (token != null && token.isNotEmpty) {
        // For now, just create a simple user model
        state = const UserModel(
          id: '1',
          email: 'user@example.com',
          phoneNumber: '1234567890',
        );
        print('🔑 User authenticated from stored token');
      } else {
        state = null;
        print('🔑 No valid token found, user not authenticated');
      }
    } catch (e) {
      print('🔑 Error checking initial auth state: $e');
      state = null;
    }
  }

  // Login user
  Future<void> login(String email, String password) async {
    try {
      print('🔑 Attempting login for: $email');
      final response = await _authRepository.login(email, password);
      
      // Store token
      await _prefs.setString('auth_token', response.token);
      print('🔑 Token stored successfully: ${response.token.substring(0, min(20, response.token.length))}...');
      
      // Update state
      state = UserModel(
        id: '1',
        email: email,
        phoneNumber: '',
      );
      
      print('🔑 Login successful, user state updated');
    } catch (e) {
      print('🔑 Login error: $e');
      rethrow;
    }
  }

  // Register user
  Future<void> register(String email, String phoneNumber, String password) async {
    try {
      print('🔑 Attempting registration for: $email');
      await _authRepository.register(email, phoneNumber, password);
      print('🔑 Registration successful');
    } catch (e) {
      print('🔑 Registration error: $e');
      rethrow;
    }
  }

  // Logout user
  Future<void> logout() async {
    try {
      await _authRepository.logout();
    } catch (e) {
      print('🔑 Logout API error (continuing anyway): $e');
    } finally {
      await _prefs.remove('auth_token');
      state = null;
      print('🔑 User logged out successfully');
    }
  }

  // Check if user is logged in
  bool get isLoggedIn => state != null;
}

// Helper function
int min(int a, int b) => a < b ? a : b;
