import 'package:flutter/material.dart';

import 'package:ogo/core/constants/assets.dart';
import 'package:ogo/core/constants/colors.dart';

import 'package:ogo/features/authentication/widgets/user_login_form_widget.dart';
import 'package:ogo/routes/app_routes.dart';

import 'package:ogo/shared/widgets/custom_icon_button.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.45,
                  width: MediaQuery.of(context).size.width,
                  // decoration: BoxDecoration(
                  //   boxShadow: [
                  //     BoxShadow(
                  //       color: OAppColors.primary,
                  //       blurRadius: 10,
                  //     )
                  //   ],
                  // ),
                  child: Opacity(
                    opacity: 0.9,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 0.0),
                      child: Image.asset(
                        OImage.splashImage,
                        fit: BoxFit.fitHeight,
                        scale: 2.0,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 60,
                  right: 18,
                  child: OiconButtons(
                      child: const Icon(
                        Icons.close,
                        size: 20,
                        color: Colors.white, // White icon color for contrast
                      ),
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, OAppRoutes.splash);
                      }),
                ),
                Positioned(
                  top: 60,
                  left: 18,
                  child: OiconButtons(
                      child: const Icon(
                        Icons.arrow_back_ios_new_sharp,
                        size: 16,
                        color: Colors.white, // White icon color for contrast
                      ),
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, OAppRoutes.register);
                      }),
                ),
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.55,
              decoration: const BoxDecoration(
                color: OAppColors.primary,
                boxShadow: [
                  BoxShadow(
                      color: OAppColors.primary,
                      blurRadius: 55,
                      spreadRadius: 10,
                      // offset: Offset(0, -17),
                      blurStyle: BlurStyle.outer)
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: UserLoginForm(),
            ),
          ],
        ),
      ),
    );
  }
}
