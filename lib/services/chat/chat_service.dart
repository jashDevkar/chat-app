import 'package:chat_app/models/message.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final AuthService _authService = AuthService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  

  Stream<List<Map<String, dynamic>>> getUsers() {
    return _firebaseFirestore.collection('Users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return data;
      }).toList();
    });
  }

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
}
