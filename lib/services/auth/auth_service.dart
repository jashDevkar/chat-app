import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  ///get firestore instance
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  get currentUserEmail {
    return _firebaseAuth.currentUser!.email!;
  }

  ///login user with email and password
  Future<UserCredential> login(
      {required String email, required String password}) async {
    try {
      final UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      ///return user data after login
      return userCredential;
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

      ///store data in firestore if they register
      final uid = userCredential.user!.uid;
      final CollectionReference reference =
          _firebaseFirestore.collection('Users');
      await reference.doc(email.toLowerCase()).set({
        'email': email.toLowerCase(),
        'uid': uid,
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }
}
