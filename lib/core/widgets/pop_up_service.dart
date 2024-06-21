import 'package:barista/core/widgets/border_rounded_button.dart';
import 'package:flutter/material.dart';

import '../extensions/padding_ext.dart';

void popUpsMaker(
  BuildContext context, {
  required String solidButtonTitle,
  required String borderedButtonTitle,
  required String imagePath,
  double imageSize = 80,
  double buttonsSize = 170,
  bool isDismissible = false,
  bool showBorderRoundedButton = true,
  void Function()? solidButtonOnPressed,
  void Function()? borderedButtonOnPressed,
  Widget? content,
}) {
  showDialog(
    barrierDismissible: isDismissible,
    context: context,
    builder: (context) {
      var mediaQuery = MediaQuery.of(context);
      return AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.zero,
        insetPadding: const EdgeInsets.all(16),
        content: Container(
          alignment: Alignment.center,
          height: mediaQuery.size.height * 0.335,
          width: mediaQuery.size.width,
          padding: EdgeInsets.symmetric(
            vertical: mediaQuery.size.height * 0.034,
            horizontal: 2,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 5,
              )
            ],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Center(
                child: Image.asset(
                  imagePath,
                  height: mediaQuery.size.height * 0.1,
                  fit: BoxFit.fitHeight,
                ),
              ).setOnlyPadding(context, 0, 0.029, 0.0427, 0.0427),
              if (content != null)
                SizedBox(
                  height: mediaQuery.size.height * 0.08,
                  child: Center(
                    child: content,
                  ),
                ),
              const Spacer(
                flex: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BorderRoundedButton(
                    width: mediaQuery.size.width * 0.4,
                    height: mediaQuery.size.height * 0.054,
                    title: solidButtonTitle,
                    onPressed: solidButtonOnPressed,
                  ),
                  if (showBorderRoundedButton)
                    BorderRoundedButton(
                      width: mediaQuery.size.width * 0.4,
                      height: mediaQuery.size.height * 0.054,
                      title: borderedButtonTitle,
                      color: const Color(0xff838388),
                      onPressed: borderedButtonOnPressed,
                    ),
                ],
              ).setOnlyPadding(context, 0, 0, 0, 0),
            ],
          ),
        ),
      );
    },
  );
}
