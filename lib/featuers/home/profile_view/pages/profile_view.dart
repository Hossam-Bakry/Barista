import 'dart:convert';
import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:barista/core/config/page_route_names.dart';
import 'package:barista/core/extensions/extensions.dart';
import 'package:barista/domain/entities/profile/user_data.dart';
import 'package:barista/featuers/home/provider/home_provider.dart';
import 'package:barista/main.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';

import '../../../../core/config/constants.dart';
import '../widgets/profile_card_item.dart';

class ProfileView extends StatefulWidget {
  UserData _userData = UserData();
  final Base64Codec base64 = const Base64Codec();

  ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  UserData _userData = UserData();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var provider = Provider.of<HomeProvider>(context);

    return Consumer<HomeProvider>(
      builder: (context, vm, child) => Column(
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: theme.primaryColor,
                    width: 2,
                  ),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: (_userData.imagePath == null)
                        ? (provider.profileImage.isEmpty)
                            ? const AssetImage(
                                "assets/images/profile.png",
                              ) as ImageProvider
                            : MemoryImage(
                                base64.decode(provider.profileImage),
                              )
                        : NetworkImage(
                            "${Constants.baseURL}${_userData.imagePath}"),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    UserData().userName ?? "",
                    style: theme.textTheme.bodyLarge,
                  ),
                  Text(
                    "profile.profile_complete".tr(),
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            child: ListView(
              children: [
                FadeInRight(
                  delay: const Duration(milliseconds: 100),
                  child: ProfileCardItem(
                    icon: "assets/icons/profile_icon.svg",
                    title: "profile.personal_data".tr(),
                    onTap: () {
                      navigatorKey.currentState!
                          .pushNamed(PageRouteNames.profileData);
                    },
                  ),
                ),
                // FadeInRight(
                //   delay: const Duration(milliseconds: 200),
                //   child: ProfileCardItem(
                //     icon: "assets/icons/favorite_icon.svg",
                //     title: "profile.favorite".tr(),
                //     onTap: () {},
                //   ),
                // ),
                FadeInRight(
                  delay: const Duration(milliseconds: 300),
                  child: ProfileCardItem(
                    icon: "assets/icons/lang.svg",
                    title: "profile.language".tr(),
                    isCustom: true,
                    widget: CustomDropdown(
                      items: const ["English", "عربي"],
                      initialItem:
                          context.locale == Locale("en") ? "English" : "عربي",
                      closedHeaderPadding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      onChanged: (value) {
                        if (value == "English") {
                          vm.setLanguage("en", context);
                        } else if (value == "عربي") {
                          vm.setLanguage("ar", context);
                        }
                        Phoenix.rebirth(context);
                      },
                      decoration: CustomDropdownDecoration(
                          closedFillColor: Colors.black38,
                          closedSuffixIcon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            size: 20,
                            color: theme.primaryColor,
                          ),
                          expandedFillColor: Colors.black,
                          headerStyle: theme.textTheme.bodyLarge,
                          expandedSuffixIcon: Icon(
                            Icons.keyboard_arrow_up_rounded,
                            size: 20,
                            color: theme.primaryColor,
                          )),
                    ),
                    onTap: () {},
                  ),
                ),
                FadeInRight(
                  delay: const Duration(milliseconds: 400),
                  child: ProfileCardItem(
                      icon: "assets/icons/logout.svg",
                      title: "profile.logout".tr(),
                      onTap: () {
                        _showLogoutDialog(context, vm);
                      }),
                ),
              ],
            ),
          )
        ],
      ).setHorizontalAndVerticalPadding(context, 0.04, 0.08),
    );
  }

  _showLogoutDialog(BuildContext context, HomeProvider vm) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => StatefulBuilder(builder: (context, setState) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          backgroundColor: Colors.transparent,
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                width: MediaQuery.of(context).size.width * 0.6,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "profile.dialog_title_logout".tr(),
                      style: TextStyle(fontSize: 16),
                      softWrap: true,
                      textAlign: TextAlign.center,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 110,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 20,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(35),
                            ),
                            child: Text(
                              'profile.cancel'.tr(),
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            vm.logOut();
                          },
                          child: Container(
                            width: 110,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 20,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(35),
                            ),
                            child: Text(
                              'profile.logout'.tr(),
                              style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
