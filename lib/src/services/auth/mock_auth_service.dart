import 'package:identitic/src/services/auth/auth_service.dart';

class MockAuthService implements AuthService {
  @override
  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    await Future.delayed(Duration(seconds: 1));
    return '70K3N';
  }

  @override
  Future<void> signOut() async {}
}
