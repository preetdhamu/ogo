import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ogo/core/constants/assets.dart';
import 'package:ogo/core/constants/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ogo/features/authentication/providers/auth_service_provider.dart';

import 'package:ogo/routes/app_routes.dart';
import 'package:ogo/shared/widgets/custom_button.dart';
import 'package:ogo/shared/widgets/custom_header.dart';
import 'package:ogo/shared/widgets/custom_icon_button.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthServiceProvider>(builder: (context, provider, _) {
      return Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
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
                        color: OAppColors.primary,
                        blurRadius: 55,
                        spreadRadius: 10,
                        // offset: Offset(0, -17),
                        blurStyle: BlurStyle.outer)
                  ],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  children: [
                    ////////////////////
                    const SizedBox(
                      height: 15,
                    ),
                    Oheader(
                      text: AppLocalizations.of(context)!.splashHeader,
                      lines: 2,
                      fontSize: 22,
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
                        Navigator.pushNamed(context, OAppRoutes.login);
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
                        /// Login with the Apple
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
                      onPressed: () async {
                        await provider.registerUserByGoogle(context);
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
                        Navigator.pushReplacementNamed(
                            context, OAppRoutes.register);
                      },
                      textColor: Colors.white,
                      borderRadius: 12.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
