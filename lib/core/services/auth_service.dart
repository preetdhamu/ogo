import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ogo/shared/widgets/custom_error_dailog.dart';
import 'package:ogo/shared/widgets/custom_log.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Signing in with the email
  Future<User?> signInWithEmail(BuildContext context ,String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } catch (e) {
      Oshowlog("Error Signing in ", "$e");
      OshowInfoDialog(
          context , e.toString() , "Login Error:");
      return null;
    }
  }

  /// Register User with the email
  Future<User?> registerWithEmail(BuildContext context , String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } catch (e) {
      Oshowlog("Error Registering :", '$e');
      OshowInfoDialog(context, e.toString(),
          "Registration Error:",
          errorIcon: Icons.close);

      return null;
    }
  }

  /// Signing In with the Google
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return null;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential result = await _auth.signInWithCredential(credential);
      return result.user;
    } catch (e) {
      Oshowlog("Google Sign- In Error :", "$e");
      return null;
    }
  }

  /// Sign Out
  Future<bool> signOut() async {
    Oshowlog1("Sign Out Successfully ");
    try {
      await _auth.signOut();
      return true;
    } on Exception catch (e) {
      Oshowlog("Sign- Out Error :", "$e");
      return false;
    }
  }
}
