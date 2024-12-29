import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _firebaseClient = FirebaseAuth.instance;

  ///register

  Future login({required String email, required String password}) async {
    try {
      final UserCredential userCredential = await _firebaseClient
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      return Future.error(e.code);
    }
  }

  ///register
  Future register({required String email, required String password}) async {
    try {
      UserCredential userCredential = await _firebaseClient
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } catch (e) {
      return Future.error('Error: $e');
    }
  }

  ///logout
  Future<void> logout() async {
    try {
      await _firebaseClient.signOut();
    } catch (e) {
      return Future.error('Error: $e');
    }
  }
}
