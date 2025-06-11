import '../../data/models/login_response.dart';

abstract class AuthRepository {
  Future<LoginResponse> login(String email, String password);
  Future<String> register(String email, String phoneNumber, String password);
  Future<void> logout();
  Future<void> validateToken();
}
