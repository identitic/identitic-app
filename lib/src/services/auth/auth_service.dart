abstract class AuthService {
  Future<String> signInWithEmailAndPassword(String email, String password);
  Future<void> signOut();
}
