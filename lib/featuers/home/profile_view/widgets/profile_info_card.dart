import 'package:animate_do/animate_do.dart';
import 'package:barista/core/extensions/extensions.dart';
import 'package:flutter/material.dart';

class ProfileInfoCard extends StatelessWidget {
  final String title;
  final String? subtTitle;
  final int fadeAnimationTime;
  Widget? customWidget;
  bool isCustomize;

  ProfileInfoCard({
    super.key,
    required this.title,
    this.subtTitle,
    required this.fadeAnimationTime,
    this.customWidget,
    this.isCustomize = false,
  });

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var theme = Theme.of(context);

    return FadeInUp(
      delay: Duration(milliseconds: fadeAnimationTime),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.bodyMedium!.copyWith(
              color: theme.primaryColor,
            ),
          ),
          if (isCustomize == false)
            SizedBox(
              width: mediaQuery.size.width * 0.9,
              child: Text(
                subtTitle ?? "",
                style: theme.textTheme.bodyLarge,
              ),
            ).setOnlyPadding(context, 0.015, 0.01, 0.0, 0.0),
          if (isCustomize == true) customWidget!,
          const Divider(
            indent: 5,
            endIndent: 10,
            thickness: 0.5,
          )
        ],
      ),
    ).setVerticalPadding(context, 0.02);
  }
}
