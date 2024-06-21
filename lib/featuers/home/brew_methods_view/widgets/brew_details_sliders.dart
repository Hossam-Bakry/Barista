import 'dart:ui';

import 'package:barista/core/extensions/extensions.dart';
import 'package:barista/featuers/home/brew_methods_view/provider/brew_method_provider.dart';
import 'package:barista/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/config/page_route_names.dart';
import '../../../../domain/entities/home/recipe_info_entity.dart';

class BrewDetailsSliders extends StatelessWidget {
  RecipeInfoEntity recipeInfoEntity;

  BrewDetailsSliders({
    super.key,
    required this.recipeInfoEntity,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context);
    var vm = Provider.of<BrewMethodProvider>(context);

    return Container(
      width: mediaQuery.size.width,
      height: mediaQuery.size.height,
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 20,
      ),
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            recipeInfoEntity.deviceName,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleLarge!.copyWith(),
          ).setOnlyPadding(context, 0.05, 0.0, 0.0, 0.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => navigatorKey.currentState!.pop(),
                child: Text(
                  "Skip",
                  style: theme.textTheme.bodyLarge!.copyWith(
                    color: theme.primaryColor,
                  ),
                ).setOnlyPadding(context, 0.0, 0.06, 0.0, 0.0),
              ),
              GestureDetector(
                onTap: () => navigatorKey.currentState!.pushNamedAndRemoveUntil(
                  PageRouteNames.brewDonePage,
                  arguments: recipeInfoEntity,
                  (route) => false,
                ),
                child: Text(
                  "Done",
                  style: theme.textTheme.bodyLarge!.copyWith(
                    color: theme.primaryColor,
                  ),
                ).setOnlyPadding(context, 0.0, 0.06, 0.0, 0.0),
              ),
            ],
          ),
          Container(
            width: mediaQuery.size.width,
            height: mediaQuery.size.height * 0.65,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 40),
            decoration: BoxDecoration(
              color: theme.colorScheme.onSecondary.withOpacity(0.9),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: vm.pageController,
                    itemBuilder: (context, index) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(),
                        SvgPicture.asset(
                          "assets/icons/coffee_device_icon.svg",
                          height: 80,
                          width: 80,
                        ),
                        const SizedBox(height: 50),
                        Text(
                          recipeInfoEntity.recipeSteps[index].title,
                          // "Boil the kettle",
                          style: theme.textTheme.titleLarge,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          recipeInfoEntity.recipeSteps[index].description,
                          // "We recommend boiling more water to keep your cup warm while you brew",
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyLarge!
                              .copyWith(color: Colors.white38),
                        ),
                        const Spacer(),
                      ],
                    ),
                    itemCount: recipeInfoEntity.recipeSteps.length,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: SmoothPageIndicator(
                    controller: vm.pageController, // PageController
                    count: recipeInfoEntity.recipeSteps.length,
                    // forcing the indicator to use a specific direction
                    effect: WormEffect(
                        dotHeight: 12,
                        dotWidth: 12,
                        activeDotColor: theme.primaryColor),
                  ),
                )
              ],
            ),
          ).setOnlyPadding(context, 0.0, 0.05, 0.0, 0.0),
          /*Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white10,
                    child: Icon(
                      Icons.arrow_back,
                      color: theme.primaryColor,
                      size: 28,
                    ),
                  ),
                ),
              ),
              ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white10,
                    child: Icon(
                      Icons.arrow_forward,
                      color: theme.primaryColor,
                      size: 28,
                    ),
                  ),
                ),
              )
            ],
          ),*/
        ],
      ),
    );
  }
}
