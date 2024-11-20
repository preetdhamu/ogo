import 'package:flutter/material.dart';

import 'package:ogo/core/constants/assets.dart';
import 'package:ogo/core/constants/colors.dart';

import 'package:ogo/features/authentication/providers/auth_service_provider.dart';
import 'package:ogo/features/authentication/widgets/user_register_form_widget.dart';
import 'package:ogo/routes/app_routes.dart';

import 'package:ogo/shared/widgets/custom_icon_button.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthServiceProvider>(builder: (context, provider, _) {
      return Scaffold(
        body: provider.load
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
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
                                color: Colors
                                    .white, // White icon color for contrast
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
                                color: Colors
                                    .white, // White icon color for contrast
                              ),
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context, OAppRoutes.login);
                              }),
                        ),
                      ],
                    ),
                    Container(
                      // height: MediaQuery.of(context).size.height * 0.65,
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
                      child: UserRegisterForm(),
                    ),
                  ],
                ),
              ),
      );
    });
  }
}
