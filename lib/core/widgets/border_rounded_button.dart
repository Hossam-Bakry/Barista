import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

import '../../core/extensions/extensions.dart';

class BorderRoundedButton extends StatelessWidget {
  final String title;
  final Function()? onPressed;
  final double? width;
  final double? height;
  final IconData? icon;
  final Color? color;

  const BorderRoundedButton({
    super.key,
    required this.title,
    this.color,
    this.height,
    this.icon,
    this.onPressed,
    this.width,
  });

  Widget borderRoundedButton(
    BuildContext context,
  ) {
    var theme = Theme.of(context);
    return Bounceable(
      onTap: onPressed,
      child: Container(
        width: width ?? MediaQuery.of(context).size.width,
        height: height ?? MediaQuery.of(context).size.height * 0.06,
        decoration: BoxDecoration(
          // border: Border.all(color: color ?? Colors.black, width: 1),
          borderRadius: BorderRadius.circular(138),
          color: theme.primaryColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: theme.textTheme.displayLarge!.copyWith(
                color: color ?? Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (icon != null)
              Icon(
                icon,
                size: 16,
                color: color ?? Colors.black,
              ).setOnlyPadding(context, 0, 0, 0, 0.02),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return borderRoundedButton(context);
  }
}
