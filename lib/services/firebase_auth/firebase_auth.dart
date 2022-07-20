import 'dart:developer';
import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:tyba_app/services/firebase_auth/firebase_authentication_errors.dart';

class FirebaseAuthentication {
  static final FirebaseAuthentication _instance =
      FirebaseAuthentication._privateConstructor();
  factory FirebaseAuthentication() => _instance;
  FirebaseAuthentication._privateConstructor();

  Future<User?> signUpUser({
    required String emailAddress,
    required String password,
  }) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw FirebaseAuthenticationError.weakPassword;
      } else if (e.code == 'email-already-in-use') {
        throw FirebaseAuthenticationError.emailAlreadyExists;
      }

      log(e.toString());
      throw FirebaseAuthenticationError.unknown;
    } catch (e) {
      log(e.toString());
      throw FirebaseAuthenticationError.unknown;
    }
  }

  Future<User?> signInUser({
    required String emailAddress,
    required String password,
  }) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      return userCredential.user;
    } catch (e) {
      log('Error in signInUser');
      rethrow;
    }
  }

  Future logOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
