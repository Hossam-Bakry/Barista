import 'package:barista/core/extensions/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../../core/config/page_route_names.dart';
import '../../../../featuers/home/my_own_recipe_view/widgets/my_own_recipe_card.dart';
import '../../../../featuers/home/provider/home_provider.dart';
import '../../../../main.dart';
import '../widgets/my_own_recipe_item_loading.dart';

class MyOwnRecipeView extends StatelessWidget {
  const MyOwnRecipeView({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var theme = Theme.of(context);

    return Consumer<HomeProvider>(
      builder: (context, vm, child) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 100.0),
          child: Column(
            children: [
              Container(
                alignment: Alignment.bottomCenter,
                width: mediaQuery.size.width,
                height: 100,
                child: Text(
                  "my_own_recipe.my_own_recipe.".tr(),
                  style: theme.textTheme.titleLarge,
                ),
              ),
              if (vm.myOwnBrewDevicesList.isEmpty)
                Lottie.asset(
                  "assets/icons/empty_icn.json",
                  alignment: Alignment.topCenter,
                  fit: BoxFit.fitHeight,
                  height: MediaQuery.of(context).size.height * 0.25,
                  repeat: true,
                ).setOnlyPadding(context, 0.2, 0.02, 0.0, 0.0),
              if (vm.myOwnBrewDevicesList.isEmpty)
                Center(
                  child: Text(
                    "You have no recipes yet.",
                    style: theme.textTheme.titleLarge,
                  ),
                ),
              if (vm.myOwnBrewDevicesList.isNotEmpty)
                Expanded(
                  child: LiquidPullToRefresh(
                    height: 60,
                    color: theme.primaryColor.withOpacity(0.4),
                    backgroundColor: theme.colorScheme.onSecondary,
                    springAnimationDurationInMilliseconds: 1000,
                    animSpeedFactor: 2,
                    showChildOpacityTransition: true,
                    borderWidth: 2,
                    onRefresh: () async {
                      vm.changeMyOwnRecipeViewLoadingStatus(true);
                      vm.getMyOwnRecipe();
                      vm.changeMyOwnRecipeViewLoadingStatus(false);
                    },
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 10),
                      itemBuilder: (context, index) =>
                          vm.isLoadingMyOwnRecipePage
                              ? MyOwnRecipeItemLoading(
                                  index: index,
                                )
                              : Bounceable(
                                  onTap: () {
                                    Future.delayed(
                                      Duration(milliseconds: 100),
                                      () {
                                        vm
                                            .getRecipeRate(vm
                                                .myOwnBrewDevicesList[index].id
                                                .toString())
                                            .then((value) {
                                          navigatorKey.currentState?.pushNamed(
                                            PageRouteNames.ownRecipeRateView,
                                            arguments: [
                                              vm.myOwnBrewDevicesList[index],
                                              vm.rateResponseList
                                            ],
                                          );
                                        });
                                      },
                                    );
                                  },
                                  child: MyOwnRecipeCard(
                                    recipeDeviceData:
                                        vm.myOwnBrewDevicesList[index],
                                    index: index,
                                  ),
                                ),
                      itemCount: vm.isLoadingMyOwnRecipePage
                          ? 7
                          : vm.myOwnBrewDevicesList.length,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
