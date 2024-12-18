import 'package:firebase_auth/firebase_auth.dart';
import 'package:mqs_admin_portal_web/config/config.dart';

class FirebaseAuthService {
  FirebaseAuthService._();
  static final i = FirebaseAuthService._();
  final FirebaseAuth _instance = FirebaseAuth.instance;
  User? get user => _instance.currentUser;
  bool get isMarketingUser => user?.email == StringConfig.login.marketingEmail;
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
