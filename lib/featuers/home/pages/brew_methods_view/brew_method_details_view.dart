import 'package:animate_do/animate_do.dart';
import 'package:barista/core/config/page_route_names.dart';
import 'package:barista/main.dart';
import 'package:expandable_fab_lite/expandable_fab_lite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../domain/entities/home/recipe_info_entity.dart';
import '../../provider/brew_method_provider.dart';
import '../../widgets/brew_details_sliders.dart';
import '../../widgets/edit_coffee_dose_widget.dart';

class BrewMethodsDetailsView extends StatelessWidget {
  const BrewMethodsDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context);
    var vm = Provider.of<BrewMethodProvider>(context);
    var args = ModalRoute.of(context)!.settings.arguments as RecipeInfoEntity;

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/brew_method_background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Row(
            children: [
              Image.asset("assets/icons/device_icon.png"),
              // SvgPicture.asset("assets/icons/device_icon.svg"),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    args.deviceName,
                    // "Chemex",
                    style: theme.textTheme.bodyLarge,
                  ),
                  Text(
                    "New Brew Session",
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: ExpandableFab(
          controller: vm.controller,
          color: theme.primaryColor,
          icon: SvgPicture.asset(
            "assets/icons/play_icon.svg",
            color: theme.colorScheme.onSecondary,
          ),
          fabMargin: 8,
          children: [
            ActionButton(
              color: Colors.black54,
              icon: SvgPicture.asset("assets/icons/steps_icon.svg"),
              onPressed: () {},
            ),
            ActionButton(
              color: Colors.black54,
              icon: SvgPicture.asset("assets/icons/play_icon.svg"),
              onPressed: () {
                navigatorKey.currentState!.pushNamed(PageRouteNames.brewPlay);
              },
            ),
            ActionButton(
              color: Colors.black54,
              icon: SvgPicture.asset("assets/icons/slider_icon.svg"),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.black54,
                  builder: (context) => StatefulBuilder(
                    builder: (context, setState) {
                      return const BrewDetailsSliders();
                    },
                  ),
                );
              },
            ),
          ],
        ),
        body: ListView(
          children: [
            Bounceable(
              onTap: () {},
              child: FadeInUp(
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
                            "Select Coffee Beans",
                            style: theme.textTheme.bodyLarge,
                          ),
                          Container(
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
                                  "Coffee Beans",
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
                          )
                        ],
                      ),
                      const SizedBox(height: 25),
                      Image.asset("assets/images/Chart + Content.png"),
                      const SizedBox(height: 25),
                      Text(
                        "${args.coffee.toString()} g",
                        // "25 g",
                        style: theme.textTheme.headlineLarge!
                            .copyWith(fontSize: 24),
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
            ),
            const SizedBox(height: 15),
            Bounceable(
              onTap: () {
                Future.delayed(
                  const Duration(milliseconds: 200),
                  () {
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
                        children: [
                          SizedBox(
                            width: mediaQuery.size.width * 0.18,
                            child: Column(
                              children: [
                                Text(
                                  "Coffee",
                                  style: theme.textTheme.bodySmall,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "${args.coffee} g",
                                  // "25 g",
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
                              children: [
                                Text(
                                  "Water(94)",
                                  style: theme.textTheme.bodySmall,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "${args.water} g",
                                  // "340 g",
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
                              children: [
                                Text(
                                  "Grinder",
                                  style: theme.textTheme.bodySmall,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  args.grinder,
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
                              children: [
                                Text(
                                  "Drew Time",
                                  style: theme.textTheme.bodySmall,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  // args.brewedTime.toString(),
                                  "01:20",
                                  style: theme.textTheme.bodyLarge!
                                      .copyWith(color: theme.primaryColor),
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
                            "Click to change",
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
