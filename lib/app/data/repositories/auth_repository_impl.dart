import '../models/user_model.dart';
import '../services/auth_service.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService _authService = AuthService();

  // Secure storage methods
  @override
  Future<void> saveUserData(String password,Map<String, dynamic> user, String token) =>
      _authService.saveUserData(password, user, token);

  @override
  Future<UserModel?> getUserData() => _authService.getUserData();

  @override
  Future<String?> getToken() => _authService.getToken();

  @override
  Future<bool> isLoggedIn() => _authService.isLoggedIn();

  @override
  Future<void> logout() => _authService.logout();
}
