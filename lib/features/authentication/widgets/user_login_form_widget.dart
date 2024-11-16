import 'package:flutter/material.dart';
import 'package:ogo/core/constants/colors.dart';
import 'package:ogo/core/utils/validator.dart';
import 'package:ogo/features/authentication/providers/auth_service_provider.dart';
import 'package:ogo/routes/app_routes.dart';
import 'package:ogo/shared/widgets/custom_button.dart';
import 'package:ogo/shared/widgets/custom_error_dailog.dart';
import 'package:ogo/shared/widgets/custom_header.dart';
import 'package:ogo/shared/widgets/custom_log.dart';
import 'package:ogo/shared/widgets/custom_text_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class UserLoginForm extends StatefulWidget {
  @override
  State<UserLoginForm> createState() => _UserLoginFormState();
}

class _UserLoginFormState extends State<UserLoginForm> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthServiceProvider>(builder: (context, provider, _) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ////////////////////
                const SizedBox(
                  height: 15,
                ),
                Oheader(
                  text: AppLocalizations.of(context)!.loginHeader,
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
                /////Creating Custom TextField
                OtextFormField(
                  hintText: AppLocalizations.of(context)!.email,
                  icon: Icons.email,
                  controller: emailController,
                  validator: Ovalidator.validateEmail,
                ),
                const SizedBox(
                  height: 15,
                ),
                OtextFormField(
                  hintText: AppLocalizations.of(context)!.password,
                  icon: Icons.lock,
                  obscureText: true,
                  controller: passwordController,
                  validator: Ovalidator.validatePassword,
                ),
                const SizedBox(
                  height: 15,
                ),
                Obutton(
                  text: AppLocalizations.of(context)!.loginHeader,
                  color: OAppColors.secondry2,
                  onPressed: () async {
                    // Handle button press
                    if (_formKey.currentState!.validate()) {
                      // Calling the API
                      Map parms = {
                        "email": emailController.text.trim(),
                        "password": passwordController.text.trim(),
                      };

                      Oshowlog("Login Up Form Parms :", parms.toString());
                      await provider.loginUser(parms, context).then(
                        (value) {
                          if (value) {
                            Navigator.pushReplacementNamed(
                                context, AppRoutes.homepage);
                          } else {
                            Navigator.pushReplacementNamed(
                                context, AppRoutes.splash);
                          }
                        },
                      );
                    } else {
                      OshowInfoDialog(context, "Form is Not Valid", "Error",
                          errorIcon: Icons.close);
                    }
                  },
                  textColor: Colors.white,
                  borderRadius: 12.0,
                ),
                const SizedBox(
                  height: 15,
                ),
                Oheader(
                  text: AppLocalizations.of(context)!.forgotPassword,
                  fontSize: 16,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Oheader(
                  text: AppLocalizations.of(context)!.dhaa,
                  lines: 2,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  textAlign: TextAlign.center,
                  color: OAppColors.white,
                ),
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, AppRoutes.register);
                  },
                  child: Oheader(
                    text: AppLocalizations.of(context)!.signupHeader,
                    lines: 2,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.center,
                    color: OAppColors.secondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
