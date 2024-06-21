import 'dart:ui';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:barista/core/services/snackbar_service.dart';
import 'package:barista/featuers/home/provider/home_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/widgets/border_rounded_button.dart';
import '../../../../domain/entities/home/recipe_info_entity.dart';
import '../../../../domain/entities/home/update_recipe_request.dart';
import '../../../../main.dart';
import 'dose_item_card.dart';

enum Person {
  one,
  two,
  three,
  four,
  five,
  six,
  seven,
  eight,
  nine,
  ten,
  eleven,
  twelve,
  thirteen,
  fourteen,
  fifteen,
  sixteen,
  seventeen,
  eighteen,
  nineteen,
  twenty,
  twentyOne,
  twentyTwo,
  twentyThree,
  twentyFour,
  twentyFive,
}

class EditCoffeeDoseWidget extends StatelessWidget {
  final RecipeInfoEntity doseData;
  bool isLocked = true;

  EditCoffeeDoseWidget({
    super.key,
    required this.doseData,
  });

  final Map<Person, String> pickList = {
    Person.one: "1: 1",
    Person.two: "1: 2",
    Person.three: "1: 3",
    Person.four: "1: 4",
    Person.five: "1: 5",
    Person.six: "1: 6",
    Person.seven: "1: 7",
    Person.eight: "1: 8",
    Person.nine: "1: 9",
    Person.ten: "1: 10",
    Person.eleven: "1: 11",
    Person.twelve: "1: 12",
    Person.thirteen: "1: 13",
    Person.fourteen: "1: 14",
    Person.fifteen: "1: 15",
    Person.sixteen: "1: 16",
    Person.seventeen: "1: 17",
    Person.eighteen: "1: 18",
    Person.nineteen: "1: 19",
    Person.twenty: "1: 20",
    Person.twentyOne: "1: 21",
    Person.twentyTwo: "1: 22",
    Person.twentyThree: "1: 23",
    Person.twentyFour: "1: 24",
    Person.twentyFive: "1: 25",
  };

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var theme = Theme.of(context);

    return Consumer<HomeProvider>(
      builder: (context, vm, child) {
        print(
          doseData.ratio.toString(),
        );
        print(vm.waterController.text);
        print(vm.percentageOfLoss);
        return SizedBox(
          height: mediaQuery.size.height * 0.68,
          child: Scaffold(
            body: Container(
              width: mediaQuery.size.width,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              decoration: const BoxDecoration(
                // color: Colors.white,
                image: DecorationImage(
                  image:
                      AssetImage("assets/images/bottom_sheet_background.png"),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                // alignment: Alignment.topRight,
                children: [
                  Positioned(
                    top: -34,
                    right: 23.5,
                    child: GestureDetector(
                      onTap: () {
                        navigatorKey.currentState!.pop();
                      },
                      child: const CircleAvatar(
                        backgroundColor: Color(0xFF922E25),
                        child: Icon(Icons.close),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(
                      //   "recipe_data.cup_number".tr(),
                      //   style: theme.textTheme.bodyLarge,
                      // ),
                      // Text(
                      //   "recipe_data.choose_number".tr(),
                      //   style: theme.textTheme.bodySmall,
                      // ),
                      // Align(
                      //   alignment: context.locale == const Locale("en")
                      //       ? Alignment.topRight
                      //       : Alignment.topLeft,
                      //   child: Container(
                      //     width: 100,
                      //     padding: const EdgeInsets.symmetric(
                      //         horizontal: 6, vertical: 4),
                      //     decoration: BoxDecoration(
                      //       color: theme.primaryColor,
                      //       borderRadius: BorderRadius.circular(20),
                      //     ),
                      //     child: Row(
                      //       children: [
                      //         Expanded(
                      //           child: GestureDetector(
                      //             onTap: () {
                      //               vm.decreaseCounter();
                      //               vm.calculateCoffee();
                      //             },
                      //             child: CircleAvatar(
                      //               radius: 13,
                      //               backgroundColor:
                      //                   theme.colorScheme.onSecondary,
                      //               child: Icon(
                      //                 Icons.remove,
                      //                 color: theme.primaryColor,
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //         Expanded(
                      //           child: Text(
                      //             vm.counter.toString(),
                      //             textAlign: TextAlign.center,
                      //           ),
                      //         ),
                      //         Expanded(
                      //           child: GestureDetector(
                      //             onTap: () {
                      //               vm.increaseCounter();
                      //               vm.calculateCoffee();
                      //               // vm.calculateWater();
                      //             },
                      //             child: CircleAvatar(
                      //               radius: 13,
                      //               backgroundColor:
                      //                   theme.colorScheme.onSecondary,
                      //               child: Icon(
                      //                 Icons.add,
                      //                 color: theme.primaryColor,
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // const SizedBox(height: 10),
                      Expanded(
                        child: ListView(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Text(
                                    "${"recipe_data.coffee".tr()} ${("recipe_data.gram".tr())}",
                                    style: theme.textTheme.bodyMedium!
                                        .copyWith(color: theme.primaryColor),
                                  ),
                                ),
                                // if (isDropDown == false)
                                Expanded(
                                  flex: 2,
                                  child: TextFormField(
                                    controller: vm.coffeeController,
                                    // enabled: false,
                                    textAlign: TextAlign.center,
                                    style: theme.textTheme.bodyLarge,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                      decimal: true,
                                      signed: true,
                                    ),
                                    textInputAction: TextInputAction.done,
                                    onChanged: (value) {
                                      // if (vm.isLocked == true) {
                                      vm.changeCoffeeDose(
                                          double.tryParse(value) ?? 0);
                                      vm.calculateWater();
                                      // }

                                      // if (vm.isLocked == false) {
                                      //   vm.changeCoffeeWithUnLocked(
                                      //       double.tryParse(value) ?? 0);
                                      // }
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Enter value",
                                      contentPadding: const EdgeInsets.only(
                                          left: 10, right: 10, top: 15),
                                      hintStyle: theme.textTheme.bodyMedium,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(
                              color: Colors.white60,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Text(
                                    "${"recipe_data.water".tr()} ${("recipe_data.gram".tr())}",
                                    style: theme.textTheme.bodyMedium!
                                        .copyWith(color: theme.primaryColor),
                                  ),
                                ),
                                // if (isDropDown == false)
                                Expanded(
                                  flex: 2,
                                  child: TextFormField(
                                    controller: vm.waterController,
                                    textAlign: TextAlign.center,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                      decimal: true,
                                      signed: true,
                                    ),
                                    textInputAction: TextInputAction.done,
                                    style: theme.textTheme.bodyLarge,
                                    onChanged: (value) {
                                      // if (vm.isLocked == true) {
                                      vm.changeWaterDose(
                                          double.tryParse(value) ?? 0);
                                      vm.calculateCoffee();
                                      // }
                                      //
                                      // if (vm.isLocked == false) {
                                      //   vm.changeWaterDose(
                                      //       double.tryParse(value) ?? 0);
                                      // }
                                    },
                                    // initialValue: vm.water.toString(),
                                    decoration: InputDecoration(
                                      hintText: "Enter value",
                                      contentPadding: const EdgeInsets.only(
                                          left: 10, right: 10, top: 15),
                                      hintStyle: theme.textTheme.bodyMedium,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(
                              color: Colors.white60,
                            ),
                            Row(
                              children: [
                                // if(!vm.isLocked)
                                Expanded(
                                  child: DoseItemCard(
                                    title: "recipe_data.ratio".tr(),
                                    isDropDown: true,
                                    pickList: pickList,
                                    value: doseData.ratio.toString(),
                                    controller: vm.ratioController,
                                    onTap: () {},
                                    isDropDownEnabled:
                                        vm.isLocked ? false : true,
                                  ),
                                ),
                                const SizedBox(width: 15.0),
                                SizedBox(
                                  height: 30,
                                  child: LiteRollingSwitch(
                                    width: 100,
                                    //initial value
                                    onDoubleTap: () {},
                                    value: true,
                                    textOn: 'recipe_data.lock'.tr(),
                                    textOff: 'recipe_data.unLock'.tr(),
                                    colorOff: theme.primaryColor,
                                    colorOn: Colors.grey.shade400,
                                    iconOff: Icons.lock_open_outlined,
                                    iconOn: Icons.lock_outline,
                                    textSize: 12.0,
                                    onChanged: (bool state) {
                                      //Use it to manage the different states
                                      print(
                                          'Current State of SWITCH IS: ${vm.isLocked}');
                                      // isLocked = state;
                                      vm.setLockedStatus(state);
                                    },
                                    onTap: () {},
                                    onSwipe: () {},
                                  ),
                                ),
                              ],
                            ),
                            const Divider(
                              color: Colors.white60,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Text(
                                    "recipe_data.grinder_settings".tr(),
                                    style: theme.textTheme.bodyMedium!
                                        .copyWith(color: theme.primaryColor),
                                  ),
                                ),
                                // if (isDropDown == false)
                                Expanded(
                                  flex: 4,
                                  child: CustomDropdown(
                                    items: context.locale == const Locale("en")
                                        ? ["Fine", "Medium", "Extra Fine"]
                                        : ["جيد", "متوسط", "جيد جدا"],
                                    initialItem: doseData.grinder,
                                    decoration: CustomDropdownDecoration(
                                      closedFillColor: Colors.transparent,
                                      closedSuffixIcon: Icon(
                                        Icons.keyboard_arrow_down_outlined,
                                        color: theme.primaryColor,
                                      ),
                                      expandedFillColor: Colors.black54,
                                      expandedSuffixIcon: Icon(
                                        Icons.keyboard_arrow_up_outlined,
                                        color: theme.primaryColor,
                                      ),
                                    ),
                                    onChanged: (value) {
                                      vm.setGrinderValue(value!);
                                    },
                                  ),
                                ),
                                /*Expanded(
                                flex: 2,
                                child: TextFormField(
                                  controller: vm.grinderController,
                                  textAlign: TextAlign.center,
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                    decimal: true,
                                    signed: true,
                                  ),
                                  textInputAction: TextInputAction.done,
                                  style: theme.textTheme.bodyLarge,
                                  onChanged: (value) {
                                    if (vm.isLocked == true) {
                                      vm.changeWaterDose(
                                          double.tryParse(value) ?? 0);
                                      vm.calculateCoffee();
                                    }

                                    if (vm.isLocked == false) {
                                      vm.changeWaterDose(
                                          double.tryParse(value) ?? 0);
                                    }
                                  },
                                  // initialValue: vm.water.toString(),
                                  decoration: InputDecoration(
                                    hintText: "Enter value",
                                    contentPadding: const EdgeInsets.only(
                                        left: 10, right: 10, top: 15),
                                    hintStyle: theme.textTheme.bodyMedium,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                  ),
                                ),
                              ),*/
                              ],
                            ),
                            const Divider(
                              color: Colors.white60,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Text(
                                    "recipe_data.brew_time".tr(),
                                    style: theme.textTheme.bodyMedium!
                                        .copyWith(color: theme.primaryColor),
                                  ),
                                ),
                                // if (isDropDown == false)
                                Expanded(
                                  flex: 2,
                                  child: TextFormField(
                                    controller: vm.brewsTimeController,
                                    textAlign: TextAlign.center,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                      decimal: true,
                                      signed: true,
                                    ),
                                    textInputAction: TextInputAction.done,
                                    style: theme.textTheme.bodyLarge,
                                    // initialValue: vm.water.toString(),
                                    decoration: InputDecoration(
                                      hintText: "Enter value",
                                      contentPadding: const EdgeInsets.only(
                                          left: 10, right: 10, top: 15),
                                      hintStyle: theme.textTheme.bodyMedium,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(
                              color: Colors.white60,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Text(
                                    "recipe_data.coffee_beans".tr(),
                                    style: theme.textTheme.bodyMedium!
                                        .copyWith(color: theme.primaryColor),
                                  ),
                                ),
                                // if (isDropDown == false)
                                Expanded(
                                  flex: 2,
                                  child: TextFormField(
                                    controller: vm.coffeeBeansController,
                                    textAlign: TextAlign.center,
                                    textInputAction: TextInputAction.done,
                                    style: theme.textTheme.bodyLarge,
                                    decoration: InputDecoration(
                                      hintText: "Enter value",
                                      contentPadding: const EdgeInsets.only(
                                          left: 10, right: 10, top: 15),
                                      hintStyle: theme.textTheme.bodyMedium,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(
                              color: Colors.white60,
                            ),
                            BorderRoundedButton(
                              onPressed: () {
                                // TODO: Set Device Name and Image
                                UpdateRecipeRequest data = UpdateRecipeRequest(
                                  recipeId: doseData.id.toString(),
                                  name: doseData.deviceName,
                                  deviceImage: doseData.brewDeviceImage,
                                  coffee:
                                      double.parse(vm.coffeeController.text),
                                  water: double.parse(vm.waterController.text),
                                  ratio: "1: ${vm.ratioController.text}",
                                  drewTime:
                                      double.parse(vm.brewsTimeController.text),
                                  grinder: vm.grinderValue,
                                  coffeeBeans:
                                      vm.coffeeBeansController.text ?? "",
                                );

                                print(data.toString());

                                vm.updateRecipe(data).then(
                                  (value) {
                                    if (value) {
                                      showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (context) => StatefulBuilder(
                                            builder: (context, setState) {
                                          return AlertDialog(
                                            backgroundColor: Colors.transparent,
                                            contentPadding: EdgeInsets.zero,
                                            insetPadding:
                                                const EdgeInsets.all(16),
                                            content: ClipRect(
                                              child: BackdropFilter(
                                                filter: ImageFilter.blur(
                                                    sigmaX: 10, sigmaY: 10),
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  height:
                                                      mediaQuery.size.height *
                                                          0.4,
                                                  width: mediaQuery.size.width,
                                                  margin: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 20),
                                                  padding: EdgeInsets.symmetric(
                                                    vertical:
                                                        mediaQuery.size.height *
                                                            0.01,
                                                    horizontal: 2,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white10,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.1),
                                                        blurRadius: 5,
                                                      )
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Lottie.asset(
                                                        "assets/icons/done_icon.json",
                                                        alignment:
                                                            Alignment.topCenter,
                                                        fit: BoxFit.cover,
                                                        height: mediaQuery
                                                                .size.height *
                                                            0.2,
                                                      ),
                                                      Text(
                                                        "Your edit was saved successfully",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: theme.textTheme
                                                            .titleLarge,
                                                      ),
                                                      const Spacer(
                                                        flex: 1,
                                                      ),
                                                      BorderRoundedButton(
                                                          width: mediaQuery
                                                                  .size.width *
                                                              0.4,
                                                          height: mediaQuery
                                                                  .size.height *
                                                              0.054,
                                                          title: "Done",
                                                          color: theme
                                                              .colorScheme
                                                              .onSecondary,
                                                          onPressed: () {
                                                            vm.getMyOwnRecipe();
                                                            navigatorKey
                                                                .currentState!
                                                                .pop();
                                                            navigatorKey
                                                                .currentState!
                                                                .pop();
                                                          }),
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
                                    } else {
                                      SnackBarService.showErrorMessage(
                                          "Somthing went wrong");
                                    }
                                  },
                                );
                              },
                              title: "recipe_data.save_changes".tr(),
                              icon: Icons.arrow_forward,
                              color: theme.colorScheme.onSecondary,
                            ).setOnlyPadding(context, 0.05, 0.0, 0.0, 0.0),
                          ],
                        ),
                      ),
                      // if(WidgetsBinding.instance.window.viewInsets.bottom > 0.0)
                      //   SizedBox(
                      //     height: 200,
                      //   ),
                      // BorderRoundedButton(
                      //   onPressed: () {
                      //     // TODO: Set Device Name and Image
                      //     UpdateRecipeRequest data = UpdateRecipeRequest(
                      //       recipeId: doseData.id.toString(),
                      //       name: doseData.deviceName,
                      //       coffeeImages: doseData.brewDeviceImage,
                      //       coffee: double.parse(vm.coffeeController.text),
                      //       water: double.parse(vm.waterController.text),
                      //       ratio: "1: ${vm.ratioController.text}",
                      //       drewTime: double.parse(vm.brewsTimeController.text),
                      //       grinder: vm.grinderController.text,
                      //     );
                      //
                      //     vm.updateRecipe(data).then(
                      //       (value) {
                      //         if (value) {
                      //           showDialog(
                      //             context: context,
                      //             builder: (context) => StatefulBuilder(
                      //               builder: (context, setState) {
                      //                 return AlertDialog(
                      //                   backgroundColor: Colors.transparent,
                      //                   contentPadding: EdgeInsets.zero,
                      //                   insetPadding: const EdgeInsets.all(16),
                      //                   content: ClipRect(
                      //                     child: BackdropFilter(
                      //                       filter:
                      //                           ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      //                       child: Container(
                      //                         alignment: Alignment.center,
                      //                         height: mediaQuery.size.height * 0.4,
                      //                         width: mediaQuery.size.width,
                      //                         margin: EdgeInsets.symmetric(horizontal: 20),
                      //                         padding: EdgeInsets.symmetric(
                      //                           vertical: mediaQuery.size.height * 0.01,
                      //                           horizontal: 2,
                      //                         ),
                      //                         decoration: BoxDecoration(
                      //                           color: Colors.white10,
                      //                           boxShadow: [
                      //                             BoxShadow(
                      //                               color: Colors.black.withOpacity(0.1),
                      //                               blurRadius: 5,
                      //                             )
                      //                           ],
                      //                           borderRadius: BorderRadius.circular(16),
                      //                         ),
                      //                         child: Column(
                      //                           mainAxisAlignment: MainAxisAlignment.start,
                      //                           crossAxisAlignment: CrossAxisAlignment.center,
                      //                           children: [
                      //                             Lottie.asset(
                      //                               "assets/icons/done_icon.json",
                      //                               alignment: Alignment.topCenter,
                      //                               fit: BoxFit.cover,
                      //                               height:
                      //                                   mediaQuery.size.height * 0.2,
                      //                               // fit: BoxFit.fitHeight,
                      //                             ),
                      //                             Text(
                      //                               "Your edit was saved successfully",
                      //                               textAlign: TextAlign.center,
                      //                               style: theme.textTheme.titleLarge,
                      //                             ),
                      //                             const Spacer(
                      //                               flex: 1,
                      //                             ),
                      //                             BorderRoundedButton(
                      //                               width: mediaQuery.size.width * 0.4,
                      //                               height:
                      //                                   mediaQuery.size.height * 0.054,
                      //                               title: "Done",
                      //                               color: theme.colorScheme.onSecondary,
                      //                               onPressed: () =>
                      //                                   navigatorKey.currentState!.pop(),
                      //                             ),
                      //                             Spacer(),
                      //                             // Row(
                      //                             //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //                             //   children: [
                      //                             //     BorderRoundedButton(
                      //                             //       width: mediaQuery.size.width * 0.4,
                      //                             //       height: mediaQuery.size.height * 0.054,
                      //                             //       title: solidButtonTitle,
                      //                             //       onPressed: solidButtonOnPressed,
                      //                             //     ),
                      //                             //     if(showBorderRoundedButton)
                      //                             //       BorderRoundedButton(
                      //                             //         width: mediaQuery.size.width * 0.4,
                      //                             //         height: mediaQuery.size.height * 0.054,
                      //                             //         title: borderedButtonTitle,
                      //                             //         color: const Color(0xff838388),
                      //                             //         onPressed: borderedButtonOnPressed,
                      //                             //       ),
                      //                             //   ],
                      //                             // ).setOnlyPadding(context, 0, 0, 0, 0),
                      //                           ],
                      //                         ),
                      //                       ),
                      //                     ),
                      //                   ),
                      //                 );
                      //               }
                      //             ),
                      //           );
                      //         } else {
                      //           SnackBarService.showErrorMessage(
                      //               "Somthing went wrong");
                      //         }
                      //       },
                      //     );
                      //   },
                      //   title: "Save Changes",
                      //   icon: Icons.arrow_forward,
                      //   color: theme.colorScheme.onSecondary,
                      // ),
                    ],
                  ).setVerticalPadding(context, 0.05),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
//
// int _selectedFruit = 0;
// double _kItemExtent = 32.0;
// List<String> _fruitNames = <String>[
//   'Apple',
//   'Mango',
//   'Banana',
//   'Orange',
//   'Pineapple',
//   'Strawberry',
// ];
}
