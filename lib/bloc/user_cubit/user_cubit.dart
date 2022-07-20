import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:tyba_app/helpers/custom_alerts.dart';
import 'package:tyba_app/main.dart';
import 'package:tyba_app/models/user_hive.dart';
import 'package:tyba_app/resources/hive_db.dart';
import 'package:tyba_app/services/firebase_auth/firebase_auth.dart';
import 'package:tyba_app/services/firebase_auth/firebase_authentication_errors.dart';
import 'package:tyba_app/services/firestore/firestore_service.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserState());
  final firebaseAuthentication = FirebaseAuthentication();
  final firestoreService = FirestoreService();

  Future<bool> signUp({
    required String emailAddress,
    required String password,
    required String name,
  }) async {
    try {
      final user = await firebaseAuthentication.signUpUser(
          emailAddress: emailAddress, password: password);
      if (user != null) {
        final userLogged = User(name: name, email: user.email!, id: user.uid);
        HiveDB().setUser(userLogged);
        firestoreService.saveUser(userLogged);
        emit(state.copyWith(user: userLogged));
      }
      return user != null;
    } catch (e) {
      final context = navigatorKey.currentState!.context;
      if (e is FirebaseAuthenticationError) {
        switch (e) {
          case FirebaseAuthenticationError.weakPassword:
            showMessageAlert(
              context: context,
              title: 'Contraseña',
              message:
                  'La contraseña es demasiado insegura, intenta añadiendo mas caracteres y simbolos.',
            );
            break;
          case FirebaseAuthenticationError.emailAlreadyExists:
            showMessageAlert(
              context: context,
              title: 'Correo Invalido',
              message:
                  'Este correo ya esta en uso, por favor intenta con otro.',
            );
            break;
          case FirebaseAuthenticationError.unknown:
            showMessageAlert(
              context: context,
              title: 'Lo sentimos',
              message: 'Se ha presentado un error\nIntenta de nuevo',
            );
            break;
        }
      } else {
        showMessageAlert(
          context: context,
          title: 'Lo sentimos',
          message: 'Se ha presentado un error\nIntenta de nuevo',
        );
      }
      return false;
    }
  }

  Future<User?> login({
    required String emailAddress,
    required String password,
  }) async {
    try {
      showLoadingAlert(navigatorKey.currentState!.context);

      final userAuth = await firebaseAuthentication.signInUser(
          emailAddress: emailAddress, password: password);
      if (userAuth == null) throw "Error";

      final userFirestore = await firestoreService.getUser(id: userAuth.uid);
      if (userFirestore == null) throw "Error";

      HiveDB().setUser(userFirestore);

      Navigator.pop(navigatorKey.currentState!.context);
      return userFirestore;
    } catch (e) {
      Navigator.pop(navigatorKey.currentState!.context);
      showMessageAlert(
          context: navigatorKey.currentState!.context,
          title: "Verificar",
          message: 'Verifica tus credenciales');
      return null;
    }
  }

  Future logOut() async {
    await firebaseAuthentication.logOut();
    await HiveDB().deleteUser();
    emit(state.copyWith(user: null));
  }
}
