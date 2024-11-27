import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ogo/core/services/auth_service.dart';
import 'package:ogo/features/authentication/data/auth_api.dart';
import 'package:ogo/features/homepage/ui/home_page.dart';

import 'package:ogo/routes/app_routes.dart';
import 'package:ogo/shared/widgets/custom_error_dailog.dart';
import 'package:ogo/shared/widgets/custom_log.dart';

class AuthServiceProvider extends ChangeNotifier {
  User? currentuser;
  final AuthService authService = AuthService();
  bool load = false;
  String idToken = '';
  bool showHomePageContent = false;

  loading() {
    load = !load;
    notifyListeners();
  }

  getCurrentUser() {
    Oshowlog1(currentuser.toString());
    return currentuser;
  }

  getIdToken(BuildContext context) async {
    idToken = await FirebaseAuth.instance.currentUser!.getIdToken(true) ?? '';
    await sendTokenToBackEnd(context);
    Oshowlog1(idToken);
    notifyListeners();

    return idToken;
  }

  sendTokenToBackEnd(BuildContext context) async {
    try {
      loading();
      final authorized = await AuthAPI.authorizeWithBackend(idToken);
      Oshowlog("asdasdadaddsds", authorized.toString());
      if (authorized) {
        // Navigate to the home screen on successful authorization
        showHomePageContent = true;
        Oshowlog("Response from authorizeWithBackend",
            AuthAPI.userdetails['message'].toString());
      } else {
        // Show an error message if authorization fails
        await authService.signOut();
        Oshowlog1('Authorization failed');
        showHomePageContent = false;
        // OshowInfoDialog(
        //     context, "Authorization Token Failed ! ", "Login Error:");
        Oshowlog("Login Error : ", "Authorization Token Failed !");

        // Navigator.pushReplacementNamed(context, OAppRoutes.login);
      }
    } catch (e, s) {
      Oshowlog("Token Passing Error", '${e.toString()} ${s.toString()}');
    } finally {
      loading();
      notifyListeners();
    }
  }

  void checkAuthentication(BuildContext context) async {
    try {
      FirebaseAuth.instance.authStateChanges().listen(
        (User? user) async {
          if (user == null) {
            await Navigator.pushReplacementNamed(context, OAppRoutes.splash);
          } else {
            currentuser = user;
            await getIdToken(context);
            notifyListeners();
          }
        },
      );
    } catch (e) {
      Oshowlog("Error", e.toString());
    }
  }

  /// api calling for register the user from Email and Password
  Future<bool> registerUser(Map data, BuildContext context) async {
    try {
      loading();
      final user = await authService.registerWithEmail(
          context, data['email']!, data['password']!);
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
      OshowInfoDialog(context, e.toString(), "Registration Error:");
    } finally {
      loading();
    }
    return false;
  }

  /// api calling for register the user from Email and Password
  Future<bool> loginUser(Map data, BuildContext context) async {
    try {
      loading();
      final user = await authService.signInWithEmail(
          context, data['email'], data['password']);
      if (user != null) {
        Oshowlog1("User Login Successfully ");
        return true;
      }
    } catch (e) {
      Oshowlog("Login Error:", e.toString());
    } finally {
      loading();
    }
    return false;
  }

  registerUserByGoogle(BuildContext context) async {
    try {
      loading();
      final user = await authService.signInWithGoogle();
      if (user != null) {
        Oshowlog1("User Login Successfully By Google");

        await Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return HomePage();
          },
        ));
      }
    } catch (e) {
      Oshowlog("Registration Error from Google Auth :", e.toString());
      OshowInfoDialog(
          context, e.toString(), "Registration Error from Google Auth :");
    } finally {
      loading();
    }
  }

  registerUserByApple(BuildContext context) async {
    try {
      loading();
      final user = await authService.signInWithGoogle();
      if (user != null) {
        Oshowlog1("User Login Successfully By Apple");
        // Navigator.pushNamedAndRemoveUntil(
        //   navigatorKey.currentState!.context,
        //   AppRoutes.homepage,
        //   (Route<dynamic> route) => false,
        // );
        await Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return HomePage();
          },
        ));
      }
    } catch (e) {
      Oshowlog("Registration Error from Google Auth :", e.toString());
      OshowInfoDialog(
          context, e.toString(), "Registration Error from Google Auth :");
    } finally {
      loading();
    }
  }
}
