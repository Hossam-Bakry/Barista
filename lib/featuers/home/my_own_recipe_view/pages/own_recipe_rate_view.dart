import 'package:animate_do/animate_do.dart';
import 'package:barista/core/extensions/extensions.dart';
import 'package:barista/domain/entities/home/recipe_rate_response.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:expandable_fab_lite/expandable_fab_lite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../core/widgets/custom_text_field.dart';
import '../../../../main.dart';
import '../../brew_methods_view/pages/brew_play_view.dart';
import '../../brew_methods_view/provider/brew_method_provider.dart';
import '../../brew_methods_view/widgets/brew_details_sliders.dart';
import '../../brew_methods_view/widgets/brew_details_steps.dart';

class OwnRecipeRateView extends StatelessWidget {
  const OwnRecipeRateView({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context);
    var args = ModalRoute.of(context)!.settings.arguments as List;

    return Consumer<BrewMethodProvider>(
      builder: (context, vm, _) => Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/brew_play_background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "my_own_recipe.my_own_recipe_rate".tr(),
              style: theme.textTheme.titleLarge,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: ExpandableFab(
            fabSize: 50,
            // heroTag: "heroTag",
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
                // heroTage: "button1",
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
                          recipeInfoEntity: args[0],
                        );
                      },
                    ),
                  );
                },
              ),
              ActionButton(
                // heroTage: "button2",
                color: Colors.black54,
                icon: SvgPicture.asset("assets/icons/play_icon.svg"),
                onPressed: () {
                  navigatorKey.currentState!.push(
                    MaterialPageRoute(
                      builder: (context) => BrewPlayView(
                        recipeInfo: args[0],
                      ),
                    ),
                  );
                },
              ),
              ActionButton(
                // heroTage: "button3",
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
                          recipeInfoEntity: args[0],
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
          body: ListView(
            children: [
              const SizedBox(height: 40),
              FadeInUp(
                delay: const Duration(milliseconds: 150),
                child: Container(
                  width: mediaQuery.size.width,
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
                                  "my_own_recipe.coffee".tr(),
                                  style: theme.textTheme.bodySmall,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  " ${args[0].coffee} g",
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
                                  "my_own_recipe.water".tr(),
                                  style: theme.textTheme.bodySmall,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  " ${args[0].water} g",
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
                                  "my_own_recipe.grinder".tr(),
                                  style: theme.textTheme.bodySmall,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  args[0].grinder,
                                  textAlign: TextAlign.center,
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
                            "my_own_recipe.review_your_recipe".tr(),
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
              const SizedBox(height: 20),
              FadeInUp(
                delay: const Duration(milliseconds: 200),
                child: Container(
                  width: mediaQuery.size.width,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                  decoration: BoxDecoration(
                    // color: Color(0xFF0E382F),
                    color: theme.colorScheme.onSecondary,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "my_own_recipe.additional_info".tr(),
                        style: theme.textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "my_own_recipe.brew_time".tr(),
                            style: theme.textTheme.bodyMedium,
                          ),
                          Text(
                            "${(args[0].brewedTime * 60).toString().substring(0, 4)} ${"my_own_recipe.secs".tr()}",
                            style: theme.textTheme.bodyMedium!
                                .copyWith(color: theme.primaryColor),
                          ),
                        ],
                      ),
                      const Divider(thickness: 0.5),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "my_own_recipe.rating".tr(),
                            style: theme.textTheme.bodyMedium,
                          ),
                          RatingBar.builder(
                            ignoreGestures: true,
                            initialRating:
                                (args[1] as List<RecipeRateResponse>).isEmpty
                                    ? 0
                                    : ((args[1] as List<RecipeRateResponse>)
                                                .last
                                                .rate)
                                            .toDouble() ??
                                        0,
                            minRating: 1,
                            direction: Axis.horizontal,
                            itemSize: 26,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              vm.setRating(rating.toInt());
                              print(rating);
                            },
                          ),
                        ],
                      ),
                      const Divider(thickness: 0.5),
                      const SizedBox(height: 10),
                      CustomTextField(
                        enabled: false,
                        // controller: vm.commentController,
                        value: (args[1] as List<RecipeRateResponse>).isEmpty
                            ? "0"
                            : (args[1] as List<RecipeRateResponse>)
                                .last
                                .comment,
                        hint: "my_own_recipe.add_note".tr(),
                        hintColor: Colors.white38,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 60),
            ],
          ).setHorizontalAndVerticalPadding(context, 0.05, 0.02),
        ),
      ),
    );
  }
}
