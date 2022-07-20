import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tyba_app/models/user_hive.dart';

class FirestoreService {
  static final FirestoreService _instance =
      FirestoreService._privateConstructor();
  factory FirestoreService() => _instance;
  FirestoreService._privateConstructor();
  final db = FirebaseFirestore.instance;

  Future saveUser(User user) async {
    // Create a new user with a first and last name
    final userMap = <String, dynamic>{
      "name": user.name,
      "email": user.email,
      "uid": user.id,
    };

// Add a new document with a generated ID
    try {
      final result = await db.collection("users").add(userMap);
      print(result);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<User?> getUser({required String id}) async {
    try {
      final docRef = db.collection("users").where('uid', isEqualTo: id);
      final doc = await docRef.get();
      final data = doc.docs.first.data();
      print(data);
      return User(name: data['name'], email: data['email'], id: data['uid']);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
