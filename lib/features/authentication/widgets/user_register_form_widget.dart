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
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserRegisterForm extends StatefulWidget {
  @override
  State<UserRegisterForm> createState() => _UserRegisterFormState();
}

class _UserRegisterFormState extends State<UserRegisterForm> {
  TextEditingController emailController = TextEditingController();

  TextEditingController firstnameController = TextEditingController();

  TextEditingController lastnameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController cpasswordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    firstnameController.dispose();
    lastnameController.dispose();
    passwordController.dispose();
    cpasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthServiceProvider>(builder: (context, provider, _) {
      return SingleChildScrollView(
        child: Column(
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
                    text: AppLocalizations.of(context)!.signupHeader,
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
                    hintText: AppLocalizations.of(context)!.firstname,
                    icon: Icons.person,
                    controller: firstnameController,
                    validator: Ovalidator.validateName,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  OtextFormField(
                    hintText: AppLocalizations.of(context)!.lastname,
                    icon: Icons.person,
                    controller: lastnameController,
                    validator: Ovalidator.validateName,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
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
                  OtextFormField(
                    hintText: AppLocalizations.of(context)!.confirmpassword,
                    icon: Icons.lock,
                    obscureText: true,
                    controller: cpasswordController,
                    validator: (value) => Ovalidator.validateConfirmPassword(
                        passwordController.text, value),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Obutton(
                    text: AppLocalizations.of(context)!.signupHeader,
                    color: OAppColors.secondry2,
                    onPressed: () async {
                      // Handle button press
                      if (_formKey.currentState!.validate()) {
                        // Calling the API
                        Map parms = {
                          "firstName": firstnameController.text.trim(),
                          "lastName": lastnameController.text.trim(),
                          "email": emailController.text.trim(),
                          "password": passwordController.text.trim(),
                        };
                        Oshowlog("Sign Up Form Parms", parms.toString());
                        await provider
                            .registerUser(parms, context)
                            .then((value) {
                          if (value) {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              OAppRoutes.homepage,
                              (Route<dynamic> route) => false,
                            );
                          } else {
                            Navigator.pushReplacementNamed(
                                context, OAppRoutes.register);
                          }
                        });
                      } else {
                        OshowInfoDialog(context, "Form is not Valid", "Error",
                            errorIcon: Icons.close);
                      }
                    },
                    textColor: Colors.white,
                    borderRadius: 12.0,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
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
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, OAppRoutes.login);
                    },
                    child: Oheader(
                      text: AppLocalizations.of(context)!.loginHeader,
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
        ),
      );
    });
  }
}
