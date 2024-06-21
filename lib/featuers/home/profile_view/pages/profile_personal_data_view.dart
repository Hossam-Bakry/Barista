import 'dart:convert';

import 'package:barista/core/extensions/extensions.dart';
import 'package:barista/domain/entities/profile/user_data.dart';
import 'package:barista/featuers/home/profile_view/pages/edit_profile_info_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../core/config/constants.dart';
import '../../provider/home_provider.dart';
import '../widgets/profile_info_card.dart';

class ProfilePersonalDataView extends StatelessWidget {
  UserData userData = UserData();
  final Base64Codec base64 = const Base64Codec();

  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emialController = TextEditingController();
  TextEditingController _birthDateController = TextEditingController();
  TextEditingController _genderController = TextEditingController();

  ProfilePersonalDataView({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var theme = Theme.of(context);

    return Consumer<HomeProvider>(
      builder: (context, vm, _) => Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/home_bakground.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            toolbarHeight: 60,
            title: Text(
              "profile.profile".tr(),
              style: theme.textTheme.titleLarge!.copyWith(color: Colors.white),
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  // navigatorKey.currentState!
                  //     .pushNamed(PageRouteNames.editProfileData);
                  vm.setDefaultValue();
                  showModalBottomSheet(
                    context: context,
                    enableDrag: false,
                    isDismissible: false,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => EditProfileInfoView(),
                  );
                },
                child: SvgPicture.asset("assets/icons/edit_icon.svg"),
              ),
              const SizedBox(width: 20),
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "profile.personal_data".tr(),
                textAlign: TextAlign.start,
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: theme.primaryColor,
                        width: 2,
                      ),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: (userData.imagePath == null)
                            ? (vm.profileImage.isEmpty)
                                ? const AssetImage(
                                    "assets/images/profile.png",
                                  ) as ImageProvider
                                : MemoryImage(
                                    base64.decode(vm.profileImage),
                                  )
                            : NetworkImage(
                                "${Constants.baseURL}${userData.imagePath}"),
                      ),
                    ),
                  ),
                  // const Icon(
                  //   Icons.camera_alt_outlined,
                  //   color: Colors.white70,
                  //   size: 36,
                  // ),
                ],
              ),
              Expanded(
                child: ListView(
                  children: [
                    ProfileInfoCard(
                      title: "profile.user_name".tr(),
                      subtTitle: userData.userName ?? "",
                      fadeAnimationTime: 100,
                    ),
                    ProfileInfoCard(
                      title: "profile.email".tr(),
                      subtTitle: userData.email ?? "",
                      fadeAnimationTime: 150,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ProfileInfoCard(
                            title: "profile.original_country".tr(),
                            subtTitle: userData.originalCountry ?? "",
                            fadeAnimationTime: 200,
                          ),
                        ),
                        Expanded(
                          child: ProfileInfoCard(
                            title: "profile.country".tr(),
                            subtTitle: userData.country ?? "",
                            fadeAnimationTime: 200,
                          ),
                        ),
                      ],
                    ),
                    ProfileInfoCard(
                      title: "profile.phone_number".tr(),
                      subtTitle: userData.phoneNumber ?? "",
                      fadeAnimationTime: 200,
                    ),
                    ProfileInfoCard(
                      title: "profile.birth_date".tr(),
                      subtTitle: userData.birthday ?? "",
                      fadeAnimationTime: 250,
                    ),
                    ProfileInfoCard(
                      title: "profile.gender".tr(),
                      subtTitle: userData.gender ?? "",
                      fadeAnimationTime: 300,
                    ),
                  ],
                ).setVerticalPadding(context, 0.04),
              )
            ],
          ).setHorizontalAndVerticalPadding(context, 0.04, 0.015),
        ),
      ),
    );
  }
}
