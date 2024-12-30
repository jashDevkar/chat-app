import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  ///get firestore instance
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  get currentUserEmail {
    return _firebaseAuth.currentUser!.email!;
  }

  ///login user with email and password
  Future<UserCredential> login(
      {required String email, required String password}) async {
    try {
      final UserCredential user = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return user;
    }

    ///catch error from firebase
    on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  ///logout
  Future<void> logout() async {
    ///logout current user
    await _firebaseAuth.signOut();
  }

  ///register
  Future<UserCredential> register(
      {required String email, required String password}) async {
    try {
      final UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }
}
