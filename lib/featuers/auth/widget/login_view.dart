import 'package:animate_do/animate_do.dart';
import 'package:barista/core/config/page_route_names.dart';
import 'package:barista/featuers/auth/provider/auth_provider.dart';
import 'package:barista/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:provider/provider.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/services/snackbar_service.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/solid_rounded_button.dart';

class LoginView extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  const LoginView({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context);

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          const Spacer(),
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
              "Login",
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
              "Welcome to your comfort \nzone for coffee !",
              textAlign: TextAlign.start,
              style: theme.textTheme.bodyLarge,
            ),
          ),
          const Spacer(),
          FadeInUp(
            delay: const Duration(milliseconds: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "E-mail",
                  style: theme.textTheme.bodySmall!.copyWith(
                    color: theme.primaryColor,
                  ),
                ),
                SizedBox(
                  width: mediaQuery.size.width * 0.7,
                  child: CustomTextField(
                    controller: emailController,
                    hint: 'Enter your E-mail',
                    action: TextInputAction.next,
                    onValidate: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "you must enter your e-mail";
                      }

                      var regex = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

                      if (!regex.hasMatch(value)) {
                        return "Invalid email";
                      }

                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
          FadeInUp(
            delay: const Duration(milliseconds: 200),
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
                  width: mediaQuery.size.width * 0.7,
                  child: CustomTextField(
                    controller: passwordController,
                    hint: 'Enter your Password',
                    action: TextInputAction.done,
                    onValidate: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "you must enter your password";
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
          const SizedBox(height: 40),
          FadeInUp(
            delay: const Duration(milliseconds: 250),
            child: GestureDetector(
              onTap: () {
                navigatorKey.currentState?.pushNamed(
                  PageRouteNames.forgetPassword,
                );
              },
              child: SizedBox(
                width: mediaQuery.size.width * 0.7,
                child: Text(
                  "Forgot Password?",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium!.copyWith(
                    decorationStyle: TextDecorationStyle.solid,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ),
          const Spacer(),
          const Spacer(),
          FadeInUp(
            child: Consumer<AuthProvider>(
              builder: (context, provider, child) => SolidRoundedButton(
                animatedButton: true,
                title: "Login",
                state: ButtonState.idle,
                color: theme.primaryColor,
                textColor: theme.colorScheme.onSecondary,
                icon: Icons.arrow_forward,
                iconColor: theme.colorScheme.onSecondary,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    EasyLoading.show();
                    provider
                        .login(
                      username: emailController.text,
                      password: passwordController.text,
                    )
                        .then((value) {
                      if (value == true) {
                        EasyLoading.dismiss();
                        SnackBarService.showSuccessMessage(
                          "you are loged in successfully",
                        );
                        navigatorKey.currentState?.pushNamedAndRemoveUntil(
                          PageRouteNames.home,
                          (route) => false,
                        );
                      } else {
                        EasyLoading.dismiss();
                      }
                    });
                  }
                },
              ),
            ),
          ).setOnlyPadding(context, 0.0, 0.08, 0.08, 0.0),
          // const Spacer(),

          // const Spacer(),
        ],
      ),
    );
  }
}
