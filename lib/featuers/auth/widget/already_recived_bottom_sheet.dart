import 'package:barista/core/config/page_route_names.dart';
import 'package:barista/main.dart';
import 'package:flutter/material.dart';

import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/solid_rounded_button.dart';

class AlreadyRecivedBottomSheet extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  AlreadyRecivedBottomSheet({super.key});

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var theme = Theme.of(context);

    return StatefulBuilder(
      builder: (context, setState) => Form(
        key: formKey,
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
                  controller: _controller,
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
                  if (formKey.currentState!.validate()) {
                    // if(_controller.text.isNotEmpty) {
                    navigatorKey.currentState!.pop();
                    navigatorKey.currentState!.pushNamed(
                      PageRouteNames.otp,
                      arguments: [
                        _controller.text,
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
