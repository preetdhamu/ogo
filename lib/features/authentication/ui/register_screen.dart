import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:ogo/core/constants/assets.dart';
import 'package:ogo/core/constants/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ogo/shared/widgets/custom_button.dart';
import 'package:ogo/shared/widgets/custom_header.dart';
import 'package:ogo/shared/widgets/custom_icon_button.dart';

import '../../../shared/widgets/custom_text_form_field.dart';

class RegisterScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cpasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
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
                      onTap: () {}),
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
                      onTap: () {}),
                ),
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.65,
              decoration: const BoxDecoration(
                color: OAppColors.primary,
                boxShadow: [
                  BoxShadow(
                    color: OAppColors.darkBlue,
                    blurRadius: 15,
                    spreadRadius: 5,
                    offset: Offset(0, -7),
                  )
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ////////////////////
                      const SizedBox(
                        height: 15,
                      ),
                      Oheader(
                        text: AppLocalizations.of(context)!.signupHeader,
                        lines: 2,
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        glow: true,
                        textAlign: TextAlign.center,
                        color: OAppColors.white,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      /////Creating Custom TextField
                      OtextFormField(
                        hintText: AppLocalizations.of(context)!.firstname,
                        icon: Icons.person,
                        controller: firstnameController,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      OtextFormField(
                        hintText: AppLocalizations.of(context)!.lastname,
                        icon: Icons.person,
                        controller: lastnameController,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      OtextFormField(
                        hintText: AppLocalizations.of(context)!.email,
                        icon: Icons.email,
                        controller: emailController,
                      ),
                      const SizedBox(
                        height: 15,
                      ),

                      OtextFormField(
                        hintText: AppLocalizations.of(context)!.password,
                        icon: Icons.lock,
                        obscureText: true,
                        controller: passwordController,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      OtextFormField(
                        hintText: AppLocalizations.of(context)!.confirmpassword,
                        icon: Icons.lock,
                        obscureText: true,
                        controller: cpasswordController,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Obutton(
                        text: AppLocalizations.of(context)!.signupHeader,
                        color: OAppColors.secondry2,
                        onPressed: () {
                          // Handle button press
                        },
                        textColor: Colors.white,
                        borderRadius: 12.0,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Oheader(
                          text: AppLocalizations.of(context)!.aha,
                          lines: 2,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          textAlign: TextAlign.center,
                          color: OAppColors.white,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Oheader(
                          text: AppLocalizations.of(context)!.loginHeader,
                          lines: 2,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          textAlign: TextAlign.center,
                          color: OAppColors.secondary,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
