import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:realmbank_mobile/data/enums/login_type.dart';
import 'package:realmbank_mobile/presentation/common/providers/auth_cubit.dart';
import 'package:realmbank_mobile/presentation/common/providers/user_cubit.dart';

class AuthenticationRepository {
  Future<UserCredential?> signIn({
    required LoginType loginType,
    String? email,
    String? password,
  }) async {
    try {
      if (loginType == LoginType.email) {
        if (email == null || password == null) {
          throw Exception('Email or password is null');
        }
        return _signInWithEmail(email: email, password: password);
      } else if (loginType == LoginType.google) {
        return _signInWithGoogle();
      } else {
        throw UnimplementedError();
      }
    } catch (e) {
      log('signIn error: $e');
      rethrow;
    }
  }

  Future<UserCredential?> signUp({
    required LoginType loginType,
    String? email,
    String? password,
  }) async {
    try {
      if (loginType == LoginType.email) {
        if (email == null || password == null) {
          throw Exception('Email or password is null');
        }
        return _signUpWithEmail(
          email: email,
          password: password,
        );
      } else if (loginType == LoginType.google) {
        return _signInWithGoogle();
      } else {
        throw UnimplementedError();
      }
    } catch (e) {
      log('signIn error: $e');
      rethrow;
    }
  }

  Future<UserCredential> _signInWithEmail({
    required String email,
    required String password,
  }) {
    return FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> _signInWithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential> _signUpWithEmail({
    required String email,
    required String password,
  }) {
    return FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();
    } catch (e) {
      log('AuthRepository.signOut: Error: $e');
      rethrow;
    }
  }

  Stream<User?> get authStateChanges =>
      FirebaseAuth.instance.authStateChanges();
}
