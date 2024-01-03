import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/solid_rounded_button.dart';
import '../../../featuers/auth/provider/auth_provider.dart';
import '../../../featuers/auth/widget/register_vierw.dart';
import '../widget/login_view.dart';

class AuthView extends StatelessWidget {
  final PageController _pageController = PageController();

  final TextEditingController emailLoginController =
      TextEditingController(text: "hossam.mostafa.bakry@gmail.com");
  final TextEditingController passwordLoginController =
      TextEditingController(text: "Asdf1234@");

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailRegisterController = TextEditingController();
  final TextEditingController passwordRegisterController =
      TextEditingController();
  final TextEditingController confirmPasswordRegisterController =
      TextEditingController();

  final TextEditingController reActivateController = TextEditingController();

  var registerFormKey = GlobalKey<FormState>();
  var loginFormKey = GlobalKey<FormState>();

  AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var vm = Provider.of<AuthProvider>(context);

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/auth_background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        // floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        // floatingActionButton: FadeInUp(
        //   delay: const Duration(milliseconds: 200),
        //   child: Consumer<AuthProvider>(
        //     builder: (context, provider, ch) {
        //       return SolidRoundedButton(
        //         animatedButton: true,
        //         title: provider.authType == "Login" ? "Login" : "Register",
        //         state: provider.authButtonState,
        //         color: theme.primaryColor,
        //         textColor: theme.colorScheme.onSecondary,
        //         icon: Icons.arrow_forward,
        //         iconColor: theme.colorScheme.onSecondary,
        //         onPressed: () {
        //           if (provider.authType != "Login") {
        //             if (registerFormKey.currentState!.validate()) {
        //               provider.setAuthButtonState(ButtonState.loading);
        //               var data = RegisterRequestData(
        //                 userName: fullNameController.text,
        //                 email: emailRegisterController.text,
        //                 country: "Egypt",
        //                 phoneNumber: "01142480146",
        //                 password: passwordRegisterController.text,
        //                 confirmPassword: confirmPasswordRegisterController.text,
        //               );
        //               if (kDebugMode) {
        //                 print(data);
        //               }
        //               provider.register(data).then((value) {
        //                 if (value == true) {
        //                   provider.setAuthButtonState(ButtonState.success);
        //                   SnackBarService.showSuccessMessage(
        //                       provider.registerData.message);
        //                   Future.delayed(
        //                     const Duration(seconds: 1),
        //                     () => provider
        //                         .setAuthButtonState(ButtonState.idle),
        //                   );
        //                   navigatorKey.currentState
        //                       ?.pushNamed(PageRouteNames.otp, arguments: emailRegisterController.text);
        //                 } else {
        //                   provider.setAuthButtonState(ButtonState.fail);
        //                   Future.delayed(
        //                     const Duration(seconds: 1),
        //                     () => provider
        //                         .setAuthButtonState(ButtonState.idle),
        //                   );
        //                 }
        //               });
        //             }
        //           }
        //
        //           if (provider.authType == "Login") {
        //             if (loginFormKey.currentState!.validate()) {
        //               provider.setAuthButtonState(ButtonState.loading);
        //               provider
        //                   .login(
        //                 username: emailLoginController.text,
        //                 password: passwordLoginController.text,
        //               )
        //                   .then((value) {
        //                 if (value == true) {
        //                   provider.setAuthButtonState(ButtonState.success);
        //                   SnackBarService.showSuccessMessage(
        //                       "you are loged in successfully");
        //                   Future.delayed(
        //                     const Duration(seconds: 1),
        //                     () => provider
        //                         .setAuthButtonState(ButtonState.idle),
        //                   );
        //                   navigatorKey.currentState
        //                       ?.pushNamed(PageRouteNames.home);
        //                 } else {
        //                   provider.setAuthButtonState(ButtonState.fail);
        //                   Future.delayed(
        //                     const Duration(seconds: 1),
        //                     () => provider
        //                         .setAuthButtonState(ButtonState.idle),
        //                   );
        //                 }
        //               });
        //
        //               print("Login");
        //               print(emailLoginController.text);
        //               print(passwordLoginController.text);
        //             }
        //           }
        //         },
        //       ).setHorizontalPadding(context, 0.06);
        //     },
        //   ),
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _pageController.jumpToPage(1);
                          vm.changeAuthUI("Register");
                        },
                        child: Container(
                          width: vm.authType != "Login" ? 85 : 40,
                          height: vm.authType != "Login" ? 185 : 100,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(100),
                              bottomRight: Radius.circular(100),
                            ),
                            color: Color(0xFF922E25),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RotatedBox(
                                quarterTurns: -1,
                                child: Text(
                                  "Register",
                                  style: theme.textTheme.titleLarge!.copyWith(
                                    color: vm.authType == "Login"
                                        ? Colors.white54
                                        : Colors.white,
                                    fontWeight: vm.authType == "Login"
                                        ? FontWeight.normal
                                        : FontWeight.w500,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              if (vm.authType != "Login")
                                Container(
                                  width: 10,
                                  height: 10,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white),
                                )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _pageController.jumpToPage(0);
                          vm.changeAuthUI("Login");
                        },
                        child: Container(
                          width: vm.authType == "Login" ? 85 : 40,
                          height: vm.authType == "Login" ? 186 : 100,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(100),
                              bottomRight: Radius.circular(100),
                            ),
                            color: Color(0xFF922E25),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RotatedBox(
                                quarterTurns: -1,
                                child: Text(
                                  "Login",
                                  style: theme.textTheme.titleLarge!.copyWith(
                                    color: vm.authType != "Login"
                                        ? Colors.white54
                                        : Colors.white,
                                    fontWeight: vm.authType != "Login"
                                        ? FontWeight.normal
                                        : FontWeight.w500,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              if (vm.authType == "Login")
                                Container(
                                  width: 10,
                                  height: 10,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white),
                                )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        LoginView(
                          emailController: emailLoginController,
                          passwordController: passwordLoginController,
                          formKey: loginFormKey,
                        ).setHorizontalPadding(context, 0.015),
                        RegisterView(
                          fullNameController: fullNameController,
                          emailController: emailRegisterController,
                          passwordController: passwordRegisterController,
                          confirmPasswordController:
                              confirmPasswordRegisterController,
                          formKey: registerFormKey,
                        ).setHorizontalPadding(context, 0.015),
                      ],
                    ),
                  )
                ],
              ),
            ),
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
        // key: formKey,
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
                  // if (formKey.currentState!.validate()) {
                  //   // if(_controller.text.isNotEmpty) {
                  //   navigatorKey.currentState!.pop();
                  //   navigatorKey.currentState!.pushNamed(PageRouteNames.otp,
                  //       arguments: [_controller.text, false]);
                  // }
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
