import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileCardItem extends StatelessWidget {
  final String icon;
  final String title;
  final void Function()? onTap;
  final bool isCustom;
  final Widget? widget;

  const ProfileCardItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.isCustom = false,
    this.widget,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            onTap!();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 40,
              child: Row(
                children: [
                  SvgPicture.asset(
                    icon,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 20),
                  Text(
                    title,
                    style: theme.textTheme.bodyLarge,
                  ),
                  const Spacer(),
                  if (isCustom) Expanded(child: widget!),
                  if (!isCustom)
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                      color: Colors.white,
                    ),
                ],
              ),
            ),
          ),
        ),
        const Divider(
          color: Colors.white60,
        ),
      ],
    );
  }
}
