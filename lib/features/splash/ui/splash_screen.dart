import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:ogo/core/constants/assets.dart';
import 'package:ogo/core/constants/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ogo/shared/widgets/custom_button.dart';
import 'package:ogo/shared/widgets/custom_header.dart';
import 'package:ogo/shared/widgets/custom_icon_button.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
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
            height: MediaQuery.of(context).size.height * 0.55,
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ////////////////////
                const SizedBox(
                  height: 15,
                ),
                Oheader(
                  text: AppLocalizations.of(context)!.splashHeader,
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
                Obutton(
                  text: AppLocalizations.of(context)!.loginHeader,
                  onPressed: () {
                    // Handle button press
                  },
                  textColor: Colors.white,
                  borderRadius: 12.0,
                ),
                const SizedBox(
                  height: 15,
                ),
                Obutton(
                  text: AppLocalizations.of(context)!.loginviaapple,
                  img: OImage.appleLogo,
                  onPressed: () {
                    // Handle button press
                  },
                  textColor: Colors.white,
                  borderRadius: 12.0,
                ),
                const SizedBox(
                  height: 15,
                ),
                Obutton(
                  img: OImage.googleLogo,
                  text: AppLocalizations.of(context)!.loginviagoogle,
                  onPressed: () {
                    // Handle button press
                  },
                  textColor: Colors.white,
                  borderRadius: 12.0,
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
          ),
        ],
      ),
    );
  }
}
