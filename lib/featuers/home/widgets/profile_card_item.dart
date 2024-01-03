import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileCardItem extends StatelessWidget {
  final String icon;
  final String title;
  final void Function()? onTap;

  const ProfileCardItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Column(
      children: [
        Row(
          children: [
            SvgPicture.asset(icon),
            const SizedBox(width: 20),
            Text(
              title,
              style: theme.textTheme.bodyLarge,
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_forward_ios,
                size: 20,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const Divider(
          color: Colors.white60,
        ),
      ],
    );
  }
}
