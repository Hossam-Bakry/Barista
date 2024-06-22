import 'dart:convert';
import 'dart:ui';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../../core/config/constants.dart';
import '../../../../core/extensions/extensions.dart';
import '../../../../core/widgets/border_rounded_button.dart';
import '../../../../core/widgets/image_grapper.dart';
import '../../../../domain/entities/profile/user_data.dart';
import '../../../../featuers/home/provider/home_provider.dart';
import '../../../../main.dart';
import '../widgets/profile_info_card.dart';

class EditProfileInfoView extends StatelessWidget {
  UserData userData = UserData();
  final Base64Codec base64 = const Base64Codec();

  EditProfileInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var theme = Theme.of(context);

    return Consumer<HomeProvider>(builder: (context, vm, _) {
      vm.printData();
      return ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            height: mediaQuery.size.height * 0.95,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () => navigatorKey.currentState!.pop(),
                    child: Container(
                      width: 32,
                      height: 32,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: theme.primaryColor)),
                      child: Icon(
                        Icons.close,
                        size: 22,
                        color: theme.primaryColor,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "Complete Profile",
                    textAlign: TextAlign.start,
                    style: theme.textTheme.titleLarge,
                  ),
                ),
                const SizedBox(height: 25),
                GestureDetector(
                  onTap: () => imageGrapper(context,
                      addToList: (file) => vm.takeProfileImage(file)),
                  child: Stack(
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
                                    "${Constants.baseURL}${userData.imagePath}",
                                  ),
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.white,
                        size: 36,
                      ),
                    ],
                  ),
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
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => showCountryPicker(
                                context: context,
                                countryListTheme: CountryListThemeData(
                                  flagSize: 28,
                                  backgroundColor: Colors.grey.shade800,
                                  textStyle: TextStyle(
                                      fontSize: 18,
                                      color:
                                          theme.primaryColor.withOpacity(0.8)),
                                  bottomSheetHeight: 500,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20.0),
                                    topRight: Radius.circular(20.0),
                                  ),
                                  inputDecoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 20),
                                    hintText: 'Start typing to search',
                                    hintStyle:
                                        const TextStyle(color: Colors.white38),
                                    prefixIcon: const Icon(
                                      Icons.search,
                                      color: Colors.white38,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: const BorderSide(
                                        color: Colors.white38,
                                      ),
                                    ),
                                  ),
                                ),
                                onSelect: (Country country) {
                                  vm.setOriginalCountry(
                                      country.name, "+${country.phoneCode}");
                                },
                              ),
                              child: ProfileInfoCard(
                                title: "profile.original_country".tr(),
                                subtTitle: "${vm.originalCountry}",
                                fadeAnimationTime: 100,
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => showCountryPicker(
                                  context: context,
                                  countryListTheme: CountryListThemeData(
                                    flagSize: 28,
                                    backgroundColor: Colors.grey.shade800,
                                    textStyle: TextStyle(
                                        fontSize: 18,
                                        color: theme.primaryColor
                                            .withOpacity(0.8)),
                                    bottomSheetHeight: 500,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                      topRight: Radius.circular(20.0),
                                    ),
                                    inputDecoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 20),
                                      hintText: 'Start typing to search',
                                      hintStyle: const TextStyle(
                                          color: Colors.white38),
                                      prefixIcon: const Icon(
                                        Icons.search,
                                        color: Colors.white38,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        borderSide: const BorderSide(
                                          color: Colors.white38,
                                        ),
                                      ),
                                    ),
                                  ),
                                  onSelect: (Country country) {
                                    vm.setCountry(
                                        country.name, "+${country.phoneCode}");
                                  }),
                              child: ProfileInfoCard(
                                title: "profile.country".tr(),
                                subtTitle: "${vm.country}",
                                fadeAnimationTime: 100,
                              ),
                            ),
                          ),
                        ],
                      ),
                      ProfileInfoCard(
                        title: "profile.phone_number".tr(),
                        fadeAnimationTime: 100,
                        isCustomize: true,
                        customWidget: TextFormField(
                          controller: vm.editPhoneController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: userData.phoneNumber,
                            hintStyle: theme.textTheme.bodyLarge,
                          ),
                        ),
                      ),
                      ProfileInfoCard(
                        title: "profile.birth_date".tr(),
                        fadeAnimationTime: 200,
                        isCustomize: true,
                        customWidget: GestureDetector(
                          onTap: () async {
                            var selected = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1800),
                              lastDate: DateTime(2030),
                            );

                            if (selected != null) {
                              vm.editBirthDateController.text =
                                  DateFormat.yMMMMd().format(selected);
                            }
                          },
                          child: TextFormField(
                            style: theme.textTheme.bodyLarge,
                            controller: vm.editBirthDateController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: userData.birthday,
                              hintStyle: theme.textTheme.bodyLarge,
                              suffixIcon: Icon(
                                Icons.calendar_month_outlined,
                                color: theme.primaryColor,
                              ),
                            ),
                            enabled: false,
                          ),
                        ),
                      ),
                      ProfileInfoCard(
                        title: "profile.gender".tr(),
                        subtTitle: userData.gender ?? "",
                        fadeAnimationTime: 250,
                        isCustomize: true,
                        customWidget: SizedBox(
                            child: CustomDropdown<String>(
                          initialItem: vm.genderList[0] == userData.gender
                              ? vm.genderList[0]
                              : vm.genderList[1],
                          hintText: 'Select your gender',
                          items: vm.genderList,
                          closedHeaderPadding: const EdgeInsets.symmetric(
                              horizontal: 2, vertical: 10),
                          decoration: CustomDropdownDecoration(
                              listItemStyle: theme.textTheme.bodyLarge!
                                  .copyWith(color: Colors.amber, fontSize: 20),
                              expandedFillColor: Colors.grey.shade800,
                              expandedSuffixIcon: Icon(
                                Icons.keyboard_arrow_up_rounded,
                                color: theme.primaryColor,
                              ),
                              listItemDecoration: ListItemDecoration(
                                highlightColor: theme.colorScheme.onSecondary
                                    .withOpacity(0.7),
                                selectedColor: theme.primaryColor,
                              ),
                              closedSuffixIcon: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: theme.primaryColor,
                              ),
                              closedFillColor: Colors.transparent,
                              closedBorderRadius: BorderRadius.circular(0),
                              closedBorder: const Border(
                                  bottom: BorderSide(
                                      color: Colors.transparent, width: 0.5)),
                              hintStyle: theme.textTheme.bodyLarge),
                          onChanged: (value) {
                            vm.setGender(value!);
                            // genderValue = value;
                            print(value);
                          },
                        )),
                      ),
                    ],
                  ).setVerticalPadding(context, 0.04),
                ),
                BorderRoundedButton(
                  title: "Save Changes",
                  color: theme.colorScheme.onSecondary,
                  icon: Icons.arrow_forward,
                  fontSize: 18,
                  onPressed: () {
                    vm.updateProfileInfo().then((value) {
                      if (value == true) {
                        vm.getProfileInfo();
                        navigatorKey.currentState!.pop();
                        showDialog(
                          context: context,
                          builder: (context) =>
                              StatefulBuilder(builder: (context, setState) {
                            return AlertDialog(
                              backgroundColor: Colors.transparent,
                              contentPadding: EdgeInsets.zero,
                              insetPadding: const EdgeInsets.all(16),
                              content: ClipRect(
                                child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: mediaQuery.size.height * 0.4,
                                    width: mediaQuery.size.width,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    padding: EdgeInsets.symmetric(
                                      vertical: mediaQuery.size.height * 0.01,
                                      horizontal: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white10,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 5,
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Lottie.asset(
                                          "assets/icons/done_icon.json",
                                          alignment: Alignment.topCenter,
                                          fit: BoxFit.cover,
                                          height: mediaQuery.size.height * 0.2,
                                        ),
                                        Text(
                                          "Your changes have been successfully!",
                                          textAlign: TextAlign.center,
                                          style: theme.textTheme.titleLarge,
                                        ),
                                        const Spacer(
                                          flex: 1,
                                        ),
                                        BorderRoundedButton(
                                          width: mediaQuery.size.width * 0.4,
                                          height:
                                              mediaQuery.size.height * 0.054,
                                          title: "Done",
                                          color: theme.colorScheme.onSecondary,
                                          onPressed: () =>
                                              navigatorKey.currentState!.pop(),
                                        ),
                                        const Spacer(),
                                        // Row(
                                        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        //   children: [
                                        //     BorderRoundedButton(
                                        //       width: mediaQuery.size.width * 0.4,
                                        //       height: mediaQuery.size.height * 0.054,
                                        //       title: solidButtonTitle,
                                        //       onPressed: solidButtonOnPressed,
                                        //     ),
                                        //     if(showBorderRoundedButton)
                                        //       BorderRoundedButton(
                                        //         width: mediaQuery.size.width * 0.4,
                                        //         height: mediaQuery.size.height * 0.054,
                                        //         title: borderedButtonTitle,
                                        //         color: const Color(0xff838388),
                                        //         onPressed: borderedButtonOnPressed,
                                        //       ),
                                        //   ],
                                        // ).setOnlyPadding(context, 0, 0, 0, 0),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        );
                      }
                    });
                  },
                ).setVerticalPadding(context, 0.04),
              ],
            ).setHorizontalAndVerticalPadding(context, 0.04, 0.015),
          ),
        ),
      );
    });
  }
}
