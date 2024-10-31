import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ogo/core/services/auth_service.dart';
import 'package:ogo/shared/widgets/custom_error_dailog.dart';


class SplashProvider extends ChangeNotifier {
  bool load = false;
  final AuthService authService = AuthService();
  User? currentuser;

  loading() {
    load = !load;
    notifyListeners();
  }

  registerUserByGoogle(context) async {
    loading();
    await authService.signInWithGoogle().then(
      (value) async {
        if (value != null) {
          currentuser = value;

          notifyListeners();
          //// Sending Token to the Data Base
        } else {
          if (context.mounted ){
            OshowInfoDialog(context, "User not able to Login", "Error",
              errorIcon: Icons.close);
          }
          
        }
      },
    ).whenComplete(
      () {
        loading();
      },
    );
  }
}
