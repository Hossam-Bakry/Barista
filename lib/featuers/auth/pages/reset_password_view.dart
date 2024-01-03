import 'package:animate_do/animate_do.dart';
import 'package:barista/core/config/page_route_names.dart';
import 'package:barista/core/extensions/extensions.dart';
import 'package:barista/featuers/auth/provider/auth_provider.dart';
import 'package:barista/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/solid_rounded_button.dart';

class ResetPasswordView extends StatelessWidget {
  ResetPasswordView({super.key});

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context);
    var args = ModalRoute.of(context)!.settings.arguments as List;
    var vm = Provider.of<AuthProvider>(context);

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/otp_background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 35,
        ),
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInRight(
                  delay: const Duration(milliseconds: 50),
                  child: Text(
                    "Barista",
                    style: theme.textTheme.bodyLarge,
                  ),
                ),
                FadeInRight(
                  delay: const Duration(milliseconds: 100),
                  child: Text(
                    "Reset \nPssword",
                    style: theme.textTheme.headlineLarge,
                  ),
                ),
                FadeInRight(
                  delay: const Duration(milliseconds: 100),
                  child: Container(
                    height: 4,
                    width: 16,
                    color: theme.primaryColor,
                  ),
                ),
                const SizedBox(height: 10),
                FadeInRight(
                  delay: const Duration(milliseconds: 150),
                  child: Text(
                    "Welcome to your comfort zone \nfor coffee !",
                    textAlign: TextAlign.start,
                    style: theme.textTheme.bodyLarge,
                  ),
                ),
                const SizedBox(height: 60),
                FadeInUp(
                  delay: const Duration(milliseconds: 300),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Password",
                        style: theme.textTheme.bodySmall!.copyWith(
                          color: theme.primaryColor,
                        ),
                      ),
                      SizedBox(
                        width: mediaQuery.size.width * 0.8,
                        child: CustomTextField(
                          controller: passwordController,
                          hint: 'Enter your Password',
                          action: TextInputAction.done,
                          onValidate: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "you must enter your password";
                            }

                            var regex = RegExp(
                                r"(?=^.{8,}$)(?=.*[!@#$%^&*]+)(?![.\\n])(?=.*[A-Z])(?=.*[a-z]).*$");

                            if (!regex.hasMatch(value)) {
                              return "The password must include at least \n* one lowercase letter, \n* one uppercase letter, \n* one digit, \n* one special character,\n* at least 6 characters long.";
                            }

                            return null;
                          },
                          maxLines: 1,
                          isPassword: true,
                        ),
                      ),
                    ],
                  ).setOnlyPadding(context, 0.02, 0.0, 0.0, 0.0),
                ),
                FadeInUp(
                  delay: const Duration(milliseconds: 350),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Confirm Password",
                        style: theme.textTheme.bodySmall!.copyWith(
                          color: theme.primaryColor,
                        ),
                      ),
                      SizedBox(
                        width: mediaQuery.size.width * 0.8,
                        child: CustomTextField(
                          controller: confirmPasswordController,
                          hint: 'Enter your Confirm Password',
                          action: TextInputAction.done,
                          onValidate: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "you must enter your confirm password";
                            }

                            if (value != passwordController.text) {
                              return "you must match the password";
                            }

                            return null;
                          },
                          maxLines: 1,
                          isPassword: true,
                        ),
                      ),
                    ],
                  ).setOnlyPadding(context, 0.04, 0.0, 0.0, 0.0),
                ),
                SizedBox(height: mediaQuery.size.height * 0.25),
                FadeInUp(
                  delay: const Duration(milliseconds: 200),
                  child: SolidRoundedButton(
                    title: "Reset ",
                    color: theme.primaryColor,
                    textColor: theme.colorScheme.onSecondary,
                    icon: Icons.arrow_forward,
                    iconColor: theme.colorScheme.onSecondary,
                    onPressed: () {
                      EasyLoading.show();
                      vm
                          .resetPassword(
                        password: passwordController.text,
                        confirmPassword: confirmPasswordController.text,
                        token: args[0],
                      )
                          .then((value) {
                        if (value) {
                          EasyLoading.dismiss();
                          navigatorKey.currentState!.pushNamedAndRemoveUntil(
                            PageRouteNames.login,
                            (route) => false,
                          );
                        } else {
                          EasyLoading.dismiss();
                        }
                      });
                    },
                  ).setHorizontalPadding(context, 0.06),
                ),
              ],
            ).setHorizontalAndVerticalPadding(context, 0.08, 0.05),
          ),
        ),
      ),
    );
  }
}
