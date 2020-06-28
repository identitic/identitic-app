import 'package:identitic/src/services/auth/api_auth_service.dart';
import 'package:identitic/src/services/auth/auth_service.dart';

enum AuthServiceType {
  api,
  mock,
}

class AuthServiceAdapter implements AuthService {
  AuthService _authService = ApiAuthService();
  @override
  Future<String> signInWithEmailAndPassword(String email, String password) =>
      _authService.signInWithEmailAndPassword(email, password);

  @override
  Future<void> signOut() => _authService.signOut();
}
