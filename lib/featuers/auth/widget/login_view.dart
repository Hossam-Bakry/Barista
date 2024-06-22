import 'package:animate_do/animate_do.dart';
import 'package:barista/core/config/page_route_names.dart';
import 'package:barista/core/services/notification_service.dart';
import 'package:barista/featuers/auth/pages/in_app_web_view.dart';
import 'package:barista/featuers/auth/provider/auth_provider.dart';
import 'package:barista/main.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:provider/provider.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/services/in_app_browser.dart';
import '../../../core/services/snackbar_service.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/or_divider.dart';
import '../../../core/widgets/ripple_test.dart';
import '../../../core/widgets/solid_rounded_button.dart';

class LoginView extends StatefulWidget {
  // final TextEditingController emailController;
  // final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  const LoginView({
    super.key,
    // required this.emailController,
    // required this.passwordController,
    required this.formKey,
  });

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final browserSafari = MyChromeSafariBrowser();
  final browser = MyInAppBrowser();

  final settings = InAppBrowserClassSettings(
    browserSettings: InAppBrowserSettings(
      hideUrlBar: false,
      closeButtonColor: Colors.black,
      toolbarTopTintColor: Colors.white,
      toolbarTopBackgroundColor: Colors.white,
      toolbarBottomBackgroundColor: Colors.white,
      toolbarBottomTintColor: Colors.white,
      hideTitleBar: true,
      hideToolbarBottom: false,
    ),
    webViewSettings: InAppWebViewSettings(
      javaScriptEnabled: true,
      javaScriptCanOpenWindowsAutomatically: true,
      allowContentAccess: true,
      userAgent: "random",
      isInspectable: kDebugMode,
      clearCache: true,
    ),
  );

  @override
  void initState() {
    browserSafari.addMenuItem(
      ChromeSafariBrowserMenuItem(
        id: 1,
        label: 'Custom item menu 1',
        onClick: (url, title) {
          print('Custom item menu 1 clicked!');
        },
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context);

    return Form(
      key: widget.formKey,
      child: Consumer<AuthProvider>(
        builder: (context, provider, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 80),
              const Spacer(),
              FadeInRight(
                delay: const Duration(milliseconds: 50),
                child: Text(
                  "general.barista".tr(),
                  style: theme.textTheme.bodyLarge,
                ),
              ),
              FadeInRight(
                delay: const Duration(milliseconds: 100),
                child: Text(
                  "auth.login".tr(),
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
              // const Spacer(),
              const SizedBox(height: 50),
              FadeInUp(
                delay: const Duration(milliseconds: 100),
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
                        controller: provider.emailController,
                        hint: "auth.enter_your_email".tr(),
                        action: TextInputAction.next,
                        onValidate: (value) {
                          if (value == null || value.trim().isEmpty) {
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
                ),
              ),
              FadeInUp(
                delay: const Duration(milliseconds: 200),
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
                        controller: provider.passwordController,
                        hint: "auth.enter_your_password".tr(),
                        action: TextInputAction.done,
                        onValidate: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "auth.password_validation_message".tr();
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
              const SizedBox(height: 20),
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
                      "auth.forget_password".tr(),
                      textAlign: TextAlign.start,
                      style: theme.textTheme.bodyMedium!.copyWith(
                        decorationStyle: TextDecorationStyle.solid,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Spacer(),
              FadeInUp(
                child: SolidRoundedButton(
                  animatedButton: true,
                  title: "auth.login".tr(),
                  state: ButtonState.idle,
                  color: theme.primaryColor,
                  textColor: theme.colorScheme.onSecondary,
                  icon: Icons.arrow_forward,
                  iconColor: theme.colorScheme.onSecondary,
                  onPressed: () {
                    NotificationService.showNotification(title: "title", body: "body");
                    if (widget.formKey.currentState!.validate()) {
                      EasyLoading.show();
                      provider
                          .login(
                        username: provider.emailController.text,
                        password: provider.passwordController.text,
                      )
                          .then((value) {
                        if (value == true) {
                          EasyLoading.dismiss();
                          SnackBarService.showSuccessMessage(
                            "you are loged in successfully",
                          );
                          navigatorKey.currentState?.pushNamedAndRemoveUntil(
                            // PageRouteNames.brewPlay,
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
              ).setOnlyPadding(
                  context,
                  0.0,
                  0.015,
                  context.locale == const Locale("en") ? 0.04 : 0.0,
                  context.locale == const Locale("en") ? 0.0 : 0.08),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () async {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        isDismissible: false,
                        builder: (context) {
                          return SizedBox(
                            height: mediaQuery.size.height * 0.9,
                            width: mediaQuery.size.width,
                            child: InAppWebViewWidget(),
                          );
                        },
                      ).then(
                        (value) {
                          navigatorKey.currentState?.pushNamedAndRemoveUntil(
                            // PageRouteNames.brewPlay,
                            PageRouteNames.home,
                            (route) => false,
                          );
                        },
                      );
                    },
                    child: const CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.transparent,
                      backgroundImage:
                          AssetImage("assets/icons/google_icn.png"),
                    ),
                  ),
                  const CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.transparent,
                    backgroundImage:
                        AssetImage("assets/icons/facebook_icn.png"),
                  ),
                  const CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage("assets/icons/apple_icn.png"),
                  ),
                ],
              ).setOnlyPadding(context, 0.012, 0.012, 0.08, 0.08),
              AnimatedContainer(
                height: 155,
                duration: const Duration(milliseconds: 1000),
                child: Column(
                  children: [
                    const OrDivider(),
                    const SizedBox(
                      height: 15,
                    ),
                    RippleAnimationTest(
                      repeat: true,
                      onPress: () {
                        HapticFeedback.lightImpact();
                        Future.delayed(const Duration(milliseconds: 500), () {
                          provider.loginByBiometrics();
                        });
                      },
                      color: Colors.grey.withOpacity(0.001),
                      minRadius: 35,
                      ripplesCount: 5,
                      duration: const Duration(milliseconds: 800),
                      size: const Size(55, 55),
                      child: FadeIn(
                        delay: const Duration(milliseconds: 1200),
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            // border: Border.all(
                            //     color: Colors.black),
                          ),
                          child: Image.asset(
                            "assets/images/icn_fingerprint_faceID.png",
                            color: theme.primaryColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "auth.login_biometric".tr(),
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    )
                  ],
                ),
              ).setOnlyPadding(
                  context,
                  0.0,
                  0.02,
                  context.locale == const Locale("en") ? 0.08 : 0.08,
                  context.locale == const Locale("en") ? 0.08 : 0.08),
              const Spacer(),
            ],
          );
        },
      ),
    );
  }
}
