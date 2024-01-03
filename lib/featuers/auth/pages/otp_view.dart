import 'package:animate_do/animate_do.dart';
import 'package:barista/core/extensions/extensions.dart';
import 'package:barista/core/widgets/solid_rounded_button.dart';
import 'package:barista/featuers/auth/provider/otp_provider.dart';
import 'package:barista/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../../core/config/page_route_names.dart';
import '../../../core/services/snackbar_service.dart';

class OTPView extends StatelessWidget {
  OTPView({super.key});

  final TextEditingController _controller = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  final formatter = NumberFormat('00');

  final defaultPinTheme = PinTheme(
    width: 48,
    height: 48,
    margin: const EdgeInsets.symmetric(horizontal: 4),
    textStyle: TextStyle(
        fontSize: 20,
        color: Theme.of(navigatorKey.currentState!.context)
            .colorScheme
            .onSecondary,
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(
          color: Theme.of(navigatorKey.currentState!.context).primaryColor),
      borderRadius: BorderRadius.circular(8.0),
    ),
  );

  @override
  Widget build(BuildContext context) {
    var arg = ModalRoute.of(context)!.settings.arguments as List;

    var provider = Provider.of<OTPProvider>(context);
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context);

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
        ),
        floatingActionButton: FadeInUp(
          delay: const Duration(milliseconds: 200),
          child: Consumer<OTPProvider>(
            builder: (context, vm, child) => SolidRoundedButton(
              disabled: vm.isDisable,
              title: "Verify",
              color: theme.primaryColor,
              textColor: theme.colorScheme.onSecondary,
              icon: Icons.arrow_forward,
              iconColor: theme.colorScheme.onSecondary,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  EasyLoading.show();

                  // Activate Account
                  if (arg[1] == false) {
                    vm.verifyOTP(email: arg[0], code: _controller.text).then(
                      (value) {
                        if (value == true) {
                          EasyLoading.dismiss();
                          SnackBarService.showSuccessMessage(
                              "Account verified successfully");
                          navigatorKey.currentState?.pushReplacementNamed(
                            PageRouteNames.login,
                          );
                        } else {
                          EasyLoading.dismiss();
                        }
                      },
                    );
                  }
                  // Rest Password
                  if (arg[1] == true) {
                    vm
                        .verifyRestPassword(
                      email: arg[0],
                      code: _controller.text,
                    )
                        .then(
                      (value) {
                        if (value) {
                          EasyLoading.dismiss();

                          navigatorKey.currentState?.pushReplacementNamed(
                            PageRouteNames.resetPassword,
                            arguments: [
                              vm.tokenRestPasswordOTP,
                              arg[0],
                              // vm.tokenRestPasswordOTP,
                            ],
                          );
                        } else {
                          EasyLoading.dismiss();
                        }
                      },
                    );
                  }
                }
              },
            ).setHorizontalPadding(context, 0.06),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Column(
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
                "OTP \nVerification",
                style: theme.textTheme.headlineLarge,
              ),
            ),
            FadeInRight(
              delay: const Duration(milliseconds: 100),
              child: Container(
                height: 4,
                width: 20,
                color: theme.primaryColor,
              ),
            ),
            const SizedBox(height: 10),
            FadeInRight(
              delay: const Duration(milliseconds: 150),
              child: SizedBox(
                width: mediaQuery.size.width * 0.7,
                child: Text(
                  "ww will send you an otp message \non this e-mail ${arg[0]}",
                  textAlign: TextAlign.start,
                  style: theme.textTheme.bodyLarge,
                ),
              ),
            ),
            const SizedBox(height: 60),
            Center(
              child: Form(
                key: _formKey,
                child: Pinput(
                  controller: _controller,
                  keyboardType: TextInputType.name,
                  length: 4,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: defaultPinTheme.copyDecorationWith(
                    border: Border.all(color: theme.primaryColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  submittedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration?.copyWith(
                      color: theme.primaryColor,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "you must enter your e-mail";
                    }
                    if (value.length < 4) {
                      return "Pin is incorrect";
                    }
                    return null;
                  },
                  showCursor: true,
                  cursor: Container(
                    width: 2,
                    height: 25,
                    color: theme.primaryColor,
                  ),

                  onChanged: (value) {
                    if (value.length == 4) {
                      provider.changeVerifyButtonDisableState(false);
                    } else {
                      provider.changeVerifyButtonDisableState(true);
                    }
                  },

                  // pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                ),
              ),
            ),
            Center(
              child: Countdown(
                seconds: 30,
                build: (BuildContext context, double time) => Text(
                  "00:${formatter.format(time)}",
                  style: theme.textTheme.bodyLarge!.copyWith(),
                ),
                onFinished: () {
                  // print('Timer is done!');
                },
              ),
            ).setVerticalPadding(context, 0.1),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "You don’t receive it? ",
                  style: theme.textTheme.bodyLarge,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Resend it",
                    style: theme.textTheme.bodyLarge!
                        .copyWith(color: theme.primaryColor),
                  ),
                ),
              ],
            )
          ],
        ).setHorizontalAndVerticalPadding(context, 0.08, 0.05),
      ),
    );
  }
}
