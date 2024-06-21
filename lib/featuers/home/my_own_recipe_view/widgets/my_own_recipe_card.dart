import 'package:animate_do/animate_do.dart';
import 'package:barista/core/extensions/extensions.dart';
import 'package:barista/featuers/home/provider/home_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/entities/home/recipe_info_entity.dart';

class MyOwnRecipeCard extends StatelessWidget {
  RecipeInfoEntity recipeDeviceData;
  final int index;

  MyOwnRecipeCard({
    super.key,
    required this.recipeDeviceData,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context);
    var vm = Provider.of<HomeProvider>(context);

    return FadeInUp(
      delay: Duration(
        milliseconds: 100 + ((index + 1) * 50),
      ),
      child: Container(
        height: 120,
        margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recipeDeviceData.deviceName,
                  style: theme.textTheme.bodyLarge!
                      .copyWith(color: theme.primaryColor, fontSize: 14),
                ).setOnlyPadding(context, 0.004, 0.008, 0.02, 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: mediaQuery.size.width * 0.16,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "my_own_recipe.coffee".tr(),
                            style: theme.textTheme.bodySmall,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "${recipeDeviceData.coffee} g",
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyMedium!
                                .copyWith(color: theme.primaryColor),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: const Color(0x4DFFFFFF),
                    ),
                    SizedBox(
                      width: mediaQuery.size.width * 0.16,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "my_own_recipe.water".tr(),
                            style: theme.textTheme.bodySmall,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "${recipeDeviceData.water} g",
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyMedium!
                                .copyWith(color: theme.primaryColor),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: const Color(0x4DFFFFFF),
                    ),
                    SizedBox(
                      width: mediaQuery.size.width * 0.16,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "my_own_recipe.grinder".tr(),
                            style: theme.textTheme.bodySmall,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            recipeDeviceData.grinder,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyMedium!
                                .copyWith(color: theme.primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "${"my_own_recipe.created_at".tr()} : ",
                      style: theme.textTheme.bodySmall!
                          .copyWith(color: theme.primaryColor),
                    ).setOnlyPadding(context, 0.01, 0.006, 0.01, 0.01),
                    Text(
                      DateFormat.yMMMMd().format(DateTime.parse(
                        recipeDeviceData.createdAt,
                      )),
                      style: theme.textTheme.bodySmall,
                    ).setOnlyPadding(context, 0.01, 0.006, 0.02, 0.0),
                  ],
                ),
              ],
            ),
            const Spacer(),
            // Container(
            //   width: 118,
            //   height: 118,
            //   decoration: BoxDecoration(
            //       image: DecorationImage(
            //     image: (recipeDeviceData.brewDeviceImage.isEmpty)
            //         ? AssetImage(
            //       vm.getDeviceImage(0),
            //           )
            //         : NetworkImage(
            //                 "${Constants.baseURL}${recipeDeviceData.brewDeviceImage}")
            //             as ImageProvider,
            //   )),
            // ),
            // if (recipeDeviceData.brewDeviceImage.isEmpty)
            Image.asset(vm.getDeviceImage(0)),
            // if (recipeDeviceData.brewDeviceImage.isNotEmpty)
            //   Image.network(
            //       "${Constants.baseURL}${recipeDeviceData.brewDeviceImage}"),
          ],
        ),
      ),
    );
  }
}
