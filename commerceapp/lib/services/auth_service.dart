import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Kullanıcı kayıt
  Future<User?> registerWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      print("Kayıt hatası: $e");
      return null;
    }
  }

  // Kullanıcı giriş
  Future<User?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      print("Giriş hatası: $e");
      return null;
    }
  }

  // Oturumu kapat
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Anlık kullanıcı bilgisi
  User? get currentUser => _auth.currentUser;
}
