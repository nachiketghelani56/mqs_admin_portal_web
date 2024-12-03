import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  FirebaseAuthService._();
  static final i = FirebaseAuthService._();
  final FirebaseAuth _instance = FirebaseAuth.instance;
  User? get user => _instance.currentUser;
  Future<User?> signUpWithEmailPassword(
      {required String email, required String password}) async {
    final credential = await _instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential.user;
  }

  Future<User?> signInWithEmailPassword(
      {required String email, required String password}) async {
    final credential = await _instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential.user;
  }

  Future signOut() async {
    await _instance.signOut();
  }
}
