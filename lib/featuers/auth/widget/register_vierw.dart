import 'package:animate_do/animate_do.dart';
import 'package:barista/featuers/auth/provider/auth_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../core/config/app_icons.dart';
import '../../../core/config/page_route_names.dart';
import '../../../core/extensions/extensions.dart';
import '../../../core/services/snackbar_service.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/solid_rounded_button.dart';
import '../../../domain/entities/auth/register_request_data.dart';
import '../../../main.dart';

class RegisterView extends StatelessWidget {
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController reActivateController = TextEditingController();
  final GlobalKey<FormState> formKey;
  final GlobalKey<FormState> bottomSheetFormState = GlobalKey<FormState>();

  RegisterView({
    super.key,
    required this.fullNameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context);

    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: mediaQuery.size.height * 0.18),
            // SizedBox(height: mediaQuery.size.height * 0.1,),
            // const Spacer(),
            FadeInRight(
              delay: const Duration(milliseconds: 50),
              child: Text(
                "Welcome To ",
                style: theme.textTheme.bodyLarge,
              ),
            ),
            FadeInRight(
              delay: const Duration(milliseconds: 100),
              child: Text(
                "Barista",
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
            const SizedBox(height: 50),
            // const Spacer(),
            FadeInUp(
              delay: const Duration(milliseconds: 200),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Full Name",
                    style: theme.textTheme.bodySmall!.copyWith(
                      color: theme.primaryColor,
                    ),
                  ),
                  SizedBox(
                    width: mediaQuery.size.width * 0.7,
                    child: CustomTextField(
                      controller: fullNameController,
                      hint: 'Enter your Full Name',
                      action: TextInputAction.next,
                      onValidate: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "you must enter your full name";
                        }

                        var regex = RegExp(r"^[A-Za-z]+[0-9]+$");

                        if (!regex.hasMatch(value)) {
                          return "The userName must contain characters and end with numbers without spaces.";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            FadeInUp(
              delay: const Duration(milliseconds: 250),
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
              ).setOnlyPadding(context, 0.02, 0.0, 0.0, 0.0),
            ),
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
                    width: mediaQuery.size.width * 0.7,
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
                    width: mediaQuery.size.width * 0.7,
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
              ).setOnlyPadding(context, 0.02, 0.0, 0.0, 0.0),
            ),
            SizedBox(height: mediaQuery.size.height * 0.08),
            // const Spacer(),
            FadeInUp(
              delay: const Duration(milliseconds: 400),
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isDismissible: true,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.0),
                        topRight: Radius.circular(25.0),
                      ),
                    ),
                    builder: (context) => Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: bottomSheet(context),
                    ),
                  );
                },
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppIcons.mailIcon,
                      color: theme.primaryColor,
                      height: 24,
                      width: 24,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "already recived code?",
                      textAlign: TextAlign.start,
                      style: theme.textTheme.bodyMedium!.copyWith(
                          color: theme.primaryColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.none),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: mediaQuery.size.height * 0.05),
            FadeInUp(
              child: Consumer<AuthProvider>(
                builder: (context, provider, child) => SolidRoundedButton(
                  title: "Register",
                  color: theme.primaryColor,
                  textColor: theme.colorScheme.onSecondary,
                  icon: Icons.arrow_forward,
                  iconColor: theme.colorScheme.onSecondary,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      EasyLoading.show();
                      var data = RegisterRequestData(
                        userName: fullNameController.text,
                        email: emailController.text,
                        country: "Egypt",
                        phoneNumber: "01142480146",
                        password: passwordController.text,
                        confirmPassword: confirmPasswordController.text,
                      );
                      if (kDebugMode) {
                        print(data);
                      }
                      provider.register(data).then((value) {
                        if (value == true) {
                          EasyLoading.dismiss();
                          SnackBarService.showSuccessMessage(
                            provider.registerData.message,
                          );
                          navigatorKey.currentState?.pushNamed(
                            PageRouteNames.otp,
                            arguments: [
                              emailController.text,
                              false,
                            ],
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
          ],
        ),
      ),
    );
  }

  bottomSheet(
    BuildContext context,
  ) {
    var mediaQuery = MediaQuery.of(context);
    var theme = Theme.of(context);

    return StatefulBuilder(
      builder: (context, setState) => Form(
        key: bottomSheetFormState,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          height: mediaQuery.size.height * 0.35,
          decoration: BoxDecoration(
            color: theme.colorScheme.onSecondary.withOpacity(0.9),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Text(
                "Please provide here the mail that you got a code",
                style: theme.textTheme.titleLarge!.copyWith(
                  color: theme.primaryColor,
                  fontSize: 18,
                ),
              ),
              const Spacer(),
              SizedBox(
                // width: mediaQuery.size.width * 0.7,
                child: CustomTextField(
                  controller: reActivateController,
                  hint: 'Enter your E-mail',
                  action: TextInputAction.done,
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
              const Spacer(),
              SizedBox(
                height: mediaQuery.size.height * 0.02,
              ),
              SolidRoundedButton(
                title: "Verify account",
                height: 45,
                color: theme.primaryColor,
                textColor: theme.colorScheme.onSecondary,
                icon: Icons.arrow_forward,
                iconColor: theme.colorScheme.onSecondary,
                onPressed: () {
                  if (bottomSheetFormState.currentState!.validate()) {
                    navigatorKey.currentState!.pop();
                    navigatorKey.currentState!.pushNamed(
                      PageRouteNames.otp,
                      arguments: [
                        emailController.text,
                        false,
                      ],
                    );
                  }
                },
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
