import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Stream of auth changes
  Stream<User?> get user => _auth.authStateChanges();

  // Sign in
  Future<UserCredential> signIn(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }
  
  // Register (optional for now)
  Future<UserCredential> register(String email, String password) async {
    return await _auth.createUserWithEmailAndPassword(email: email, password: password);
  }
}
