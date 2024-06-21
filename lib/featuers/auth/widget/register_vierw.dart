import 'package:animate_do/animate_do.dart';
import 'package:barista/featuers/auth/provider/auth_provider.dart';
import 'package:easy_localization/easy_localization.dart';
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
  String? genderValue;
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController dateController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController reActivateController = TextEditingController();
  final GlobalKey<FormState> formKey;
  final GlobalKey<FormState> bottomSheetFormState = GlobalKey<FormState>();

  RegisterView({
    super.key,
    required this.fullNameController,
    required this.emailController,
    required this.dateController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Consumer<AuthProvider>(
        builder: (context, vm, _) => SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: mediaQuery.size.height * 0.18),
                FadeInRight(
                  delay: const Duration(milliseconds: 50),
                  child: Text(
                    "auth.welcome".tr(),
                    style: theme.textTheme.bodyLarge,
                  ),
                ),
                FadeInRight(
                  delay: const Duration(milliseconds: 100),
                  child: Text(
                    "general.barista".tr(),
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
                    "auth.desc".tr(),
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
                        "auth.full_name".tr(),
                        style: theme.textTheme.bodySmall!.copyWith(
                          color: theme.primaryColor,
                        ),
                      ),
                      SizedBox(
                        width: mediaQuery.size.width * 0.7,
                        child: CustomTextField(
                          controller: fullNameController,
                          hint: "auth.enter_your_name".tr(),
                          action: TextInputAction.next,
                          onValidate: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "auth.name_validation_message".tr();
                            }

                            // var regex = RegExp(r"^[A-Za-z]+[0-9]+$");
                                //
                                // if (!regex.hasMatch(value)) {
                                //   return "The userName must contain characters and end with numbers without spaces.";
                                // }
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
                            "auth.email".tr(),
                            style: theme.textTheme.bodySmall!.copyWith(
                              color: theme.primaryColor,
                            ),
                          ),
                          SizedBox(
                            width: mediaQuery.size.width * 0.7,
                            child: CustomTextField(
                              controller: emailController,
                              hint: "auth.enter_your_email".tr(),
                              action: TextInputAction.next,
                              onValidate: (value) {
                                if (value == null || value
                                    .trim()
                                    .isEmpty) {
                                  return "auth.email_validation_message".tr();
                                }

                            var regex = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

                            if (!regex.hasMatch(value)) {
                                  return "auth.invalid_email".tr();
                                }

                            return null;
                          },
                        ),
                      ),
                    ],
                  ).setOnlyPadding(context, 0.02, 0.0, 0.0, 0.0),
                ),
                /* FadeInUp(
                  delay: const Duration(milliseconds: 350),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Birth Date",
                        style: theme.textTheme.bodySmall!.copyWith(
                          color: theme.primaryColor,
                        ),
                      ),
                      SizedBox(
                        width: mediaQuery.size.width * 0.7,
                        child: GestureDetector(
                          onTap: () async {
                            var selected = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1800),
                              lastDate: DateTime(2030),
                            );

                            if (selected != null) {
                              dateController.text =
                                  DateFormat.yMMMMd().format(selected);
                            }
                          },
                          child: CustomTextField(
                            controller: dateController,
                            enabled: false,
                            hint: 'Enter your Birth Date',
                            action: TextInputAction.next,
                            suffixWidget: Icon(
                              Icons.calendar_month_outlined,
                              color: theme.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ).setOnlyPadding(context, 0.02, 0.0, 0.0, 0.0),
                ),
                FadeInUp(
                  delay: const Duration(milliseconds: 400),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Gender",
                        style: theme.textTheme.bodySmall!.copyWith(
                          color: theme.primaryColor,
                        ),
                      ),
                      SizedBox(
                        width: mediaQuery.size.width * 0.7,
                        child: CustomDropdown<String>(
                          hintText: 'Select your gender',
                          items: vm.genderList,
                          closedHeaderPadding: const EdgeInsets.symmetric(horizontal: 2,vertical: 10),
                          decoration: CustomDropdownDecoration(
                            listItemStyle: theme.textTheme.bodyLarge!.copyWith(
                              color: Colors.amber,
                            ),
                            expandedFillColor: Colors.grey.shade600,
                            expandedSuffixIcon: Icon(Icons.keyboard_arrow_up_rounded, color: theme.primaryColor,),
                            listItemDecoration: ListItemDecoration(
                              highlightColor: theme.colorScheme.onSecondary.withOpacity(0.7),
                              selectedColor: theme.primaryColor,
                            ),
                            closedSuffixIcon: Icon(Icons.keyboard_arrow_down_rounded, color: theme.primaryColor,),
                            closedFillColor: Colors.transparent,
                            closedBorderRadius: BorderRadius.circular(0),
                            closedBorder: const Border(
                              bottom: BorderSide(
                                color: Colors.white,
                                width: 0.5
                              )
                            ),
                            hintStyle: theme.textTheme.bodyLarge
                          ),
                          onChanged: (value) {
                            genderValue = value;
                            print(genderValue);
                          },
                        )
                      ),
                    ],
                  ).setOnlyPadding(context, 0.02, 0.0, 0.0, 0.0),
                ),*/
                FadeInUp(
                  delay: const Duration(milliseconds: 450),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "auth.password".tr(),
                        style: theme.textTheme.bodySmall!.copyWith(
                          color: theme.primaryColor,
                        ),
                      ),
                      SizedBox(
                        width: mediaQuery.size.width * 0.7,
                        child: CustomTextField(
                          controller: passwordController,
                          hint: 'auth.enter_your_password'.tr(),
                          action: TextInputAction.done,
                          onValidate: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "auth.password_validation_message".tr();
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
                      delay: const Duration(milliseconds: 500),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "auth.confirm_password".tr(),
                            style: theme.textTheme.bodySmall!.copyWith(
                              color: theme.primaryColor,
                            ),
                          ),
                          SizedBox(
                            width: mediaQuery.size.width * 0.7,
                            child: CustomTextField(
                              controller: confirmPasswordController,
                              hint: 'auth.enter_your_confirm_password'.tr(),
                              action: TextInputAction.done,
                              onValidate: (value) {
                                if (value == null || value
                                    .trim()
                                    .isEmpty) {
                                  return "auth.password_validation_message"
                                      .tr();
                                }

                            if (value != passwordController.text) {
                              return "auth.match_password".tr();
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
                      delay: const Duration(milliseconds: 550),
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
                            builder: (context) =>
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: MediaQuery
                                        .of(context)
                                        .viewInsets
                                        .bottom,
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
                              "auth.already_received_code".tr(),
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
                        builder: (context, provider, child) =>
                            SolidRoundedButton(
                              title: "auth.register".tr(),
                              color: theme.primaryColor,
                              textColor: theme.colorScheme.onSecondary,
                              icon: Icons.arrow_forward,
                              iconColor: theme.colorScheme.onSecondary,
                              onPressed: () {
                                var data = RegisterRequestData(
                                  userName: fullNameController.text,
                                  email: emailController.text,
                                  // birthDate: dateController.text,
                                  // gender: genderValue ?? "",
                                  // country: "Egypt",
                                  // phoneNumber: "01142480146",
                                  password: passwordController.text,
                                  confirmPassword: confirmPasswordController
                                      .text,
                                );
                                if (kDebugMode) {
                                  print(data.toString());
                                }

                                if (formKey.currentState!.validate()) {
                                  EasyLoading.show();

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
                    ).setOnlyPadding(context,
                        0.0,
                        0.02,
                        context.locale == const Locale("en") ? 0.08 : 0.0,
                        context.locale == const Locale("en") ? 0.0 : 0.08),
                  ],
                ),
              ),
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
