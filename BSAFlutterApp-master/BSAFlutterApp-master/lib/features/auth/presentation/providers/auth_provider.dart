import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/di/injection.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../data/models/user_model.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return getIt<AuthRepository>();
});

final authStateProvider = StreamProvider<UserModel?>((ref) {
  // This would typically listen to Firebase Auth state changes
  // For now, we'll check stored token
  return Stream.fromFuture(_getCurrentUser());
});

Future<UserModel?> _getCurrentUser() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('auth_token');
  
  if (token != null) {
    // In a real app, you'd validate the token and get user info
    return const UserModel(
      id: '1',
      email: 'user@example.com',
      phoneNumber: '1234567890',
    );
  }
  
  return null;
}

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AsyncValue<UserModel?>>((ref) {
  return AuthNotifier(ref.read(authRepositoryProvider));
});

class AuthNotifier extends StateNotifier<AsyncValue<UserModel?>> {
  final AuthRepository _authRepository;

  AuthNotifier(this._authRepository) : super(const AsyncValue.loading()) {
    _checkAuthState();
  }

  Future<void> _checkAuthState() async {
    try {
      final user = await _getCurrentUser();
      state = AsyncValue.data(user);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    
    try {
      final response = await _authRepository.login(email, password);
      
      // Store token
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', response.token);
      
      // Create user model (in real app, get from token or API)
      final user = UserModel(
        id: '1',
        email: email,
        phoneNumber: '',
      );
      
      state = AsyncValue.data(user);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> register(String email, String phoneNumber, String password) async {
    state = const AsyncValue.loading();
    
    try {
      await _authRepository.register(email, phoneNumber, password);
      state = const AsyncValue.data(null); // Registration successful, but not logged in
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> logout() async {
    try {
      await _authRepository.logout();
      
      // Clear stored token
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('auth_token');
      
      state = const AsyncValue.data(null);
    } catch (e) {
      // Even if logout fails on server, clear local state
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('auth_token');
      state = const AsyncValue.data(null);
    }
  }
}
