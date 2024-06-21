import 'package:animate_do/animate_do.dart';
import 'package:barista/core/config/page_route_names.dart';
import 'package:barista/core/extensions/extensions.dart';
import 'package:barista/featuers/home/brew_methods_view/provider/brew_method_provider.dart';
import 'package:barista/main.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/entities/home/recipe_info_entity.dart';

class BrewDetailsSteps extends StatelessWidget {
  RecipeInfoEntity recipeInfoEntity;

  BrewDetailsSteps({
    super.key,
    required this.recipeInfoEntity,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context);
    var vm = Provider.of<BrewMethodProvider>(context);

    return StatefulBuilder(
      builder: (context, setState) => Container(
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
                    "general.skip".tr(),
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: theme.primaryColor,
                    ),
                  ).setOnlyPadding(context, 0.0, 0.02, 0.0, 0.0),
                ),
                GestureDetector(
                  onTap: () =>
                      navigatorKey.currentState!.pushNamedAndRemoveUntil(
                    PageRouteNames.brewDonePage,
                    arguments: recipeInfoEntity,
                    (route) => false,
                  ),
                  child: Text(
                    "general.done".tr(),
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: theme.primaryColor,
                    ),
                  ).setOnlyPadding(context, 0.0, 0.02, 0.0, 0.0),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) => FadeInUp(
                  delay: Duration(milliseconds: ((index + 1) * 100) + 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 10,
                        height: 100,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 40),
                        decoration: BoxDecoration(
                          color: vm.stepsDetails[index].stepColor,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          // height: 130,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 6),
                          decoration: BoxDecoration(
                            color:
                                theme.colorScheme.onSecondary.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                "${recipeInfoEntity.recipeSteps[index].brewedTime} sec",
                                textAlign: TextAlign.end,
                                style: theme.textTheme.bodyLarge,
                              ),
                              Text(
                                recipeInfoEntity.recipeSteps[index].title
                                    .toString(),
                                textAlign: TextAlign.start,
                                style: theme.textTheme.bodyMedium!.copyWith(
                                    color: theme.primaryColor,
                                    decoration: TextDecoration.underline,
                                    decorationColor: theme.primaryColor),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                recipeInfoEntity.recipeSteps[index].description
                                    .toString(),
                                textAlign: TextAlign.start,
                                style: theme.textTheme.bodyLarge,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                itemCount: recipeInfoEntity.recipeSteps.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
