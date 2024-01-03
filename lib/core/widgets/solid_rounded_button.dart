import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:progress_state_button/progress_button.dart';

import '../../core/extensions/extensions.dart';

class SolidRoundedButton extends StatelessWidget {
  final String title;
  final IconData? icon;
  final bool disabled, animatedButton;
  final Color? color;
  final Color? iconColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final Function()? onPressed;
  final ButtonState? state;

  const SolidRoundedButton({
    Key? key,
    required this.title,
    this.color,
    this.disabled = false,
    this.height,
    this.icon,
    this.iconColor,
    this.onPressed,
    this.textColor,
    this.width,
    this.animatedButton = false,
    this.state,
  }) : super(key: key);

  Widget solidRoundedButton(
    BuildContext context,
  ) {
    var theme = Theme.of(context);

    if (animatedButton) {
      return ProgressButton(
        onPressed: state == ButtonState.loading
            ? null
            : disabled
                ? () {}
                : onPressed,
        state: state,
        stateColors: {
          ButtonState.idle: disabled
              ? const Color.fromARGB(255, 116, 116, 116)
              : theme.primaryColor,
          ButtonState.fail: Colors.red,
          ButtonState.loading: theme.primaryColor,
          ButtonState.success: Colors.grey,
        },
        progressIndicatorAlignment: MainAxisAlignment.center,
        progressIndicatorSize: 35,
        minWidth: 80,
        radius: 30,
        stateWidgets: {
          ButtonState.idle: SizedBox(
            width: width ?? MediaQuery.of(context).size.width,
            height: height ?? MediaQuery.of(context).size.height * 0.06,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    title,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.visible,
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          color: textColor ?? Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                if (icon != null)
                  Icon(
                    icon,
                    color: iconColor ?? Colors.white,
                    size: 16,
                  ).setOnlyPadding(context, 0, 0, 0.02, 0),
              ],
            ),
          ),
          ButtonState.loading: Container(
            color: theme.primaryColor,
          ),
          ButtonState.fail: Container(
            width: width ?? MediaQuery.of(context).size.width,
            height: height ?? MediaQuery.of(context).size.height * 0.06,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(125),
            ),
            child: const Center(
              child: Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
          ),
          ButtonState.success: Container(
            width: width ?? MediaQuery.of(context).size.width,
            height: height ?? MediaQuery.of(context).size.height * 0.06,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(125),
            ),
            child: const Center(
              child: Icon(
                Icons.check,
                color: Colors.white,
              ),
            ),
          ),
        },
      );
    } else {
      return Bounceable(
        onTap: disabled ? null : onPressed,
        child: Container(
          width: width ?? MediaQuery.of(context).size.width,
          height: height ?? MediaQuery.of(context).size.height * 0.06,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(125),
            color: disabled
                ? const Color.fromARGB(255, 116, 116, 116)
                : color ?? Colors.black,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      color: textColor ?? Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(width: 10),
              if (icon != null)
                Icon(
                  icon,
                  color: iconColor ?? Colors.white,
                  size: 20,
                ).setOnlyPadding(context, 0, 0, 0.02, 0),
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return solidRoundedButton(
      context,
    );
  }
}
