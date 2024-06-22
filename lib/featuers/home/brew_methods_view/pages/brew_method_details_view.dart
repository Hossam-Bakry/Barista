import 'package:animate_do/animate_do.dart';
import 'package:barista/featuers/home/brew_methods_view/widgets/brew_details_steps.dart';
import 'package:barista/featuers/home/provider/home_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:expandable_fab_lite/expandable_fab_lite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../../core/extensions/extensions.dart';
import '../../../../../domain/entities/home/recipe_info_entity.dart';
import '../../../../../main.dart';
import '../../../../core/config/constants.dart';
import '../provider/brew_method_provider.dart';
import '../widgets/brew_details_sliders.dart';
import '../widgets/edit_coffee_dose_widget.dart';
import 'brew_play_view.dart';

class BrewMethodsDetailsView extends StatelessWidget {
  const BrewMethodsDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context);
    var vm = Provider.of<BrewMethodProvider>(context);
    var viewModel = Provider.of<HomeProvider>(context);
    var args = ModalRoute.of(context)!.settings.arguments as RecipeInfoEntity;

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: (args.brewDeviceImage == null || args.brewDeviceImage.isEmpty)
              ? const AssetImage("assets/images/brew_method_background.png")
              : NetworkImage("${Constants.baseURL}${args.brewDeviceImage}")
                  as ImageProvider,
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          centerTitle: false,
          title: Row(
            children: [
              // Image.asset("assets/icons/device_icon.png"),
              // SvgPicture.asset("assets/icons/device_icon.svg"),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    args.deviceName,
                    style: theme.textTheme.bodyLarge,
                  ),
                  Text(
                    "recipe_data.brew_new_session".tr(),
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: ExpandableFab(
          fabSize: 50,
          heroTag: "heroTag",
          controller: vm.expandFabController,
          color: theme.primaryColor,
          icon: SvgPicture.asset(
            "assets/icons/play_icon.svg",
            height: 18,
            width: 18,
            color: theme.colorScheme.onSecondary,
          ),
          fabMargin: 8,
          children: [
            ActionButton(
              heroTage: "button1",
              color: Colors.black54,
              icon: SvgPicture.asset("assets/icons/steps_icon.svg"),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  isDismissible: false,
                  backgroundColor: Colors.black54,
                  builder: (context) => StatefulBuilder(
                    builder: (context, setState) {
                      return BrewDetailsSteps(
                        recipeInfoEntity: args,
                      );
                    },
                  ),
                );
              },
            ),
            ActionButton(
              heroTage: "button2",
              color: Colors.black54,
              icon: SvgPicture.asset("assets/icons/play_icon.svg"),
              onPressed: () {
                navigatorKey.currentState!.push(
                  MaterialPageRoute(
                    builder: (context) => BrewPlayView(
                      recipeInfo: args,
                    ),
                  ),
                );
              },
            ),
            ActionButton(
              heroTage: "button3",
              color: Colors.black54,
              icon: SvgPicture.asset("assets/icons/slider_icon.svg"),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  isDismissible: false,
                  backgroundColor: Colors.black54,
                  builder: (context) => StatefulBuilder(
                    builder: (context, setState) {
                      return BrewDetailsSliders(
                        recipeInfoEntity: args,
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
        body: Column(
          children: [
            FadeInUp(
              delay: const Duration(milliseconds: 150),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                decoration: BoxDecoration(
                  // color: Color(0xFF0E382F),
                  color: theme.colorScheme.onSecondary,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "recipe_data.select_coffee_beans".tr(),
                          style: theme.textTheme.bodyLarge,
                        ),
                        Bounceable(
                          onTap: () {
                            Future.delayed(
                              const Duration(milliseconds: 200),
                              () {
                                viewModel.setDefaultDoseValues(args);
                                showModalBottomSheet(
                                  context: context,
                                  backgroundColor: Colors.transparent,
                                  isScrollControlled: true,
                                  isDismissible: true,
                                  builder: (context) => StatefulBuilder(
                                    builder: (context, setState) {
                                      return EditCoffeeDoseWidget(
                                          doseData: args);
                                    },
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4.0),
                            decoration: BoxDecoration(
                              // color: Color(0xFF0E382F),
                              color: theme.primaryColor,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  "recipe_data.coffee_beans".tr(),
                                  style: theme.textTheme.bodyLarge!.copyWith(
                                    color: theme.colorScheme.onSecondary,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                CircleAvatar(
                                  radius: 13,
                                  backgroundColor:
                                      theme.colorScheme.onSecondary,
                                  child: Icon(
                                    Icons.add,
                                    size: 20,
                                    color: theme.primaryColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 25),
                    Image.asset("assets/images/Chart + Content.png"),
                    const SizedBox(height: 25),
                    Text(
                      "${args.coffee.toString()} g",
                      // "25 g",
                      style:
                          theme.textTheme.headlineLarge!.copyWith(fontSize: 24),
                    ),
                    const SizedBox(height: 15),
                    // Text(
                    //   "Click to change",
                    //   style: theme.textTheme.bodyMedium!
                    //       .copyWith(color: const Color(0xFF6E8882)),
                    // ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            Bounceable(
              onTap: () {
                Future.delayed(
                  const Duration(milliseconds: 200),
                  () {
                    viewModel.setDefaultDoseValues(args);
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      isDismissible: true,
                      builder: (context) => StatefulBuilder(
                        builder: (context, setState) {
                          return EditCoffeeDoseWidget(doseData: args);
                        },
                      ),
                    );
                  },
                );
              },
              // onTap: () {
              /*Future.delayed(
                  const Duration(milliseconds: 200),
                  () {
                    viewModel.setDefaultDoseValues(args);
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      isDismissible: true,
                      builder: (context) => StatefulBuilder(
                        builder: (context, setState) {
                          return EditCoffeeDoseWidget(doseData: args);
                        },
                      ),
                    );
                  },
                );*/
              // },
              child: FadeInUp(
                delay: const Duration(milliseconds: 200),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  decoration: BoxDecoration(
                    // color: Color(0xFF0E382F),
                    color: theme.colorScheme.onSecondary,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: mediaQuery.size.width * 0.18,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "recipe_data.coffee".tr(),
                                  style: theme.textTheme.bodySmall,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "${args.coffee.toInt()} g",
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.bodyLarge!
                                      .copyWith(color: theme.primaryColor),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 60,
                            color: const Color(0x4DFFFFFF),
                          ),
                          SizedBox(
                            width: mediaQuery.size.width * 0.18,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "recipe_data.water".tr(),
                                  style: theme.textTheme.bodySmall,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "${args.water} ml",
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.bodyLarge!
                                      .copyWith(color: theme.primaryColor),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 60,
                            color: const Color(0x4DFFFFFF),
                          ),
                          SizedBox(
                            width: mediaQuery.size.width * 0.18,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "recipe_data.grinder".tr(),
                                  style: theme.textTheme.bodySmall,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  args.grinder,
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.bodyLarge!
                                      .copyWith(color: theme.primaryColor),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 60,
                            color: const Color(0x4DFFFFFF),
                          ),
                          SizedBox(
                            width: mediaQuery.size.width * 0.18,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "recipe_data.brew_time".tr(),
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.bodySmall,
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      args.brewedTime.toString(),
                                      // "01:20",
                                      textAlign: TextAlign.center,
                                      style: theme.textTheme.bodyLarge!
                                          .copyWith(color: theme.primaryColor),
                                    ),
                                    Text(
                                      "recipe_data.minute".tr(),
                                      textAlign: TextAlign.center,
                                      style: theme.textTheme.bodySmall
                                          ?.copyWith(color: theme.primaryColor),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "recipe_data.click_to_change".tr(),
                            style: theme.textTheme.bodyMedium!
                                .copyWith(color: const Color(0xFF6E8882)),
                          ),
                          const SizedBox(width: 6.0),
                          const Icon(
                            Icons.arrow_forward,
                            size: 20,
                            color: Color(0xFF6E8882),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ).setHorizontalAndVerticalPadding(context, 0.025, 0.04),
      ),
    );
  }
}
