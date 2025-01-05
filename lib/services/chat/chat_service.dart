import 'package:chat_app/models/message.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatService extends ChangeNotifier {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final AuthService _authService = AuthService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  /// get all users
  Stream<List<Map<String, dynamic>>> getUsers() {
    return _firebaseFirestore.collection('Users').snapshots().map((snapshot) {
      return snapshot.docs
          .where((doc) => doc.data()['email'] != _authService.currentUserEmail)
          .map((doc) {
        final data = doc.data();
        return data;
      }).toList();
    });
  }

  /// get all users except blocked users
  Stream<List<Map<String, dynamic>>> getAllUsersExceptBlocked() {
    String currentUserEmail = _firebaseAuth.currentUser!.email!;
    return _firebaseFirestore
        .collection('Users')
        .doc(currentUserEmail)
        .collection('BlockedUsers')
        .snapshots()
        .asyncMap((QuerySnapshot snapshot) async {
      final blockedEmails = snapshot.docs.map((doc) => doc.id).toList();

      final userSnapshot = await _firebaseFirestore.collection('Users').get();

      return userSnapshot.docs
          .where((doc) =>
              doc.data()['email'] != currentUserEmail &&
              !blockedEmails.contains(doc.id))
          .map((doc) => doc.data())
          .toList();
    });
  }

  ///Send message
  Future<void> sendMessage(
      {required String recieverId, required String text}) async {
    ///recieve all data that will be stored in firestore
    final String senderEmail = _authService.currentUserEmail;
    final String senderId = _firebaseAuth.currentUser!.uid;
    final Timestamp timestamp = Timestamp.now();

    ///create a instance of message that will be helped to store data
    final Message message = Message(
      senderEmail: senderEmail,
      senderID: senderId,
      recieverId: recieverId,
      message: text,
      timestamp: timestamp,
    );

    List<String> ids = [senderId, recieverId];
    ids.sort();
    String roomId = ids.join('_');

    await _firebaseFirestore
        .collection('chat_rooms')
        .doc(roomId)
        .collection('messages')
        .add(message.toMap());
  }

  ///get all messages
  Stream<QuerySnapshot> getMessages({required String recieverId}) {
    final String senderId = _firebaseAuth.currentUser!.uid;
    List<String> ids = [senderId, recieverId];
    ids.sort();
    String roomId = ids.join('_');
    return _firebaseFirestore
        .collection('chat_rooms')
        .doc(roomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  /// Delete all chat
  Future<void> deleteAllChat({required String recieverId}) async {
    //j5fXOUscnQeo4QfxNwArLJYfCda2_kxOIHHIkD9OcjplOhRYz4Qb6zOl2
    final String senderId = _firebaseAuth.currentUser!.uid;
    List<String> ids = [senderId, recieverId];
    ids.sort();
    String roomId = ids.join('_');

    try {
      var docs = await _firebaseFirestore
          .collection('chat_rooms')
          .doc(roomId)
          .collection('messages')
          .get();
      for (var doc in docs.docs) {
        doc.reference.delete();
      }
    } catch (e) {
      print(e);
    }
  }

  /// Report message for that user
  Future<void> reportMessage(
      {required String message, required String userEmail}) async {
    final currentUser = _firebaseAuth.currentUser;
    final report = {
      'reportedBy': currentUser!.email,
      'message': message,
      'sendedBy': userEmail,
      'timestamp': FieldValue.serverTimestamp(),
    };
    await _firebaseFirestore.collection('Reports').add(report);
  }

  ///Block user
  Future<void> blockUser({required String userEmail}) async {
    final currentUser = _firebaseAuth.currentUser;
    await _firebaseFirestore
        .collection('Users')
        .doc(currentUser!.email)
        .collection('BlockedUsers')
        .doc(userEmail)
        .set({});
    notifyListeners();
  }

  /// Unblock user
  Future<void> unBlockUser({required String userId}) async {
    final currentUser = _firebaseAuth.currentUser;
    await _firebaseFirestore
        .collection('Users')
        .doc(currentUser!.email)
        .collection('BlockedUsers')
        .doc(userId)
        .delete();
    notifyListeners();
  }

  ///get stream of blocked users
  Stream<List<Map<String, dynamic>>> getBlockedUserStream(
      {required String userId}) {
    return _firebaseFirestore
        .collection('Users')
        .doc(userId)
        .collection('BlockedUsers')
        .snapshots()
        .asyncMap((QuerySnapshot snapshot) async {
      List blockedUserEmails =
          snapshot.docs.map((DocumentSnapshot doc) => doc.id).toList();

      final userDocs = await Future.wait(blockedUserEmails
          .map((id) => _firebaseFirestore.collection('Users').doc(id).get()));

      return userDocs
          .map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>)
          .toList();
    });
  }
}
