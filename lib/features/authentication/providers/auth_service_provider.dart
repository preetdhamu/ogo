import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ogo/core/services/auth_service.dart';
import 'package:ogo/main.dart';
import 'package:ogo/shared/widgets/custom_error_dailog.dart';
import 'package:ogo/shared/widgets/custom_log.dart';

class AuthServiceProvider extends ChangeNotifier {
  User? currentuser;
  final AuthService authService = AuthService();
  bool load = false;

  loading() {
    load = !load;
    notifyListeners();
  }

  getCurrentUser() {
    return currentuser?.email;
  }

  /// api calling for register the user from Email and Password
  Future<bool> registerUser(Map data) async {
    try {
      loading();
      final user = await authService.registerWithEmail(
          data['email']!, data['password']!);
      if (user != null) {
        await user.updateProfile(
            displayName: "${data['firstName']} ${data['lastName']}");
        await user.reload();
        Oshowlog1("User Created Successfully ");
        return true;
      }
    } catch (e) {
      // Log or handle error
      Oshowlog("Registration Error:", e.toString());

      OshowInfoDialog(navigatorKey.currentState!.context, e.toString(),
          "Registration Error:");
    } finally {
      loading();
    }
    return false;
  }

  /// api calling for register the user from Email and Password
  loginUser(Map data, BuildContext context) async {
    loading();
    await authService.signInWithEmail(data['email'], data['password']).then(
      (value) async {
        if (value != null) {
          currentuser = value;

          notifyListeners();
          //// Sending Token to the Data Base
        } else {
          if (context.mounted) {
            OshowInfoDialog(context, "User not Found", "Error",
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
