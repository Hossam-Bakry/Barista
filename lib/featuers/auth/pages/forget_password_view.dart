import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:provider/provider.dart';

import '../../../core/config/page_route_names.dart';
import '../../../core/extensions/extensions.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/solid_rounded_button.dart';
import '../../../featuers/auth/provider/forget_password_provider.dart';
import '../../../main.dart';

class ForgetPasswordView extends StatelessWidget {
  ForgetPasswordView({super.key});

  final TextEditingController _controller = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<ForgetPasswordProvider>(context, listen: false);
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
        floatingActionButton: FadeInUp(
          delay: const Duration(milliseconds: 200),
          child: SolidRoundedButton(
            animatedButton: false,
            title: "Send",
            state: ButtonState.idle,
            color: theme.primaryColor,
            textColor: theme.colorScheme.onSecondary,
            icon: Icons.arrow_forward,
            iconColor: theme.colorScheme.onSecondary,
            onPressed: () {
              EasyLoading.show();
              vm.forgetPasseword(_controller.text).then((value) {
                if (value == true) {
                  EasyLoading.dismiss();
                  navigatorKey.currentState!.pushReplacementNamed(
                    PageRouteNames.otp,
                    arguments: [
                      _controller.text,
                      true,
                    ],
                  );
                } else {
                  EasyLoading.dismiss();
                }
              });
            },
          ).setHorizontalPadding(context, 0.06),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
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
                "Forget \nPssword",
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
                    width: mediaQuery.size.width * 0.8,
                    child: CustomTextField(
                      controller: _controller,
                      hint: 'Enter your E-mail',
                      action: TextInputAction.next,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ).setHorizontalAndVerticalPadding(context, 0.08, 0.05),
      ),
    );
  }
}
