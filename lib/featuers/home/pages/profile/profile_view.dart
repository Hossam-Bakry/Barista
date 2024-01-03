import 'package:animate_do/animate_do.dart';
import 'package:barista/core/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../widgets/profile_card_item.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 35,
              backgroundColor: Colors.white,
              child: Image.asset(
                "assets/images/profile.png",
                fit: BoxFit.cover,
                width: 70,
                height: 70,
              ),
            ),
            const SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hossam Bakry !",
                  style: theme.textTheme.bodyLarge,
                ),
                Text(
                  "Complete Profile",
                  style: theme.textTheme.bodyMedium!
                      .copyWith(decoration: TextDecoration.underline),
                ),
              ],
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {},
              child: SvgPicture.asset("assets/icons/edit_icon.svg"),
            ),
          ],
        ),
        // ProfileCardItem(
        //   icon: "assets/icons/profile_icon.svg",
        //   title: "Personal Data",
        //   onTap: () {},
        // ),
        Expanded(
          child: ListView(
            // padding: EdgeInsets,
            children: [
              FadeInRight(
                delay: const Duration(milliseconds: 100),
                child: ProfileCardItem(
                  icon: "assets/icons/profile_icon.svg",
                  title: "Personal Data",
                  onTap: () {},
                ),
              ),
              FadeInRight(
                delay: const Duration(milliseconds: 200),
                child: ProfileCardItem(
                  icon: "assets/icons/favorite_icon.svg",
                  title: "Favorite",
                  onTap: () {},
                ),
              ),
              FadeInRight(
                delay: const Duration(milliseconds: 300),
                child: ProfileCardItem(
                  icon: "assets/icons/language_icon.svg",
                  title: "Language",
                  onTap: () {},
                ),
              ),
              FadeInRight(
                delay: const Duration(milliseconds: 400),
                child: ProfileCardItem(
                  icon: "assets/icons/logout_icon.svg",
                  title: "Logout",
                  onTap: () {},
                ),
              ),
            ],
          ),
        )
      ],
    ).setHorizontalAndVerticalPadding(context, 0.04, 0.08);
  }
}
