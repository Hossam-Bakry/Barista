import 'dart:convert';

import 'package:barista/featuers/home/brew_methods_view/widgets/brew_iteam_loading.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';

import '../../../../../core/config/app_icons.dart';
import '../../../../../core/config/page_route_names.dart';
import '../../../../../core/extensions/extensions.dart';
import '../../../../../main.dart';
import '../../../../core/config/constants.dart';
import '../../../../domain/entities/profile/user_data.dart';
import '../../provider/home_provider.dart';
import '../widgets/brew_item_widget.dart';

class BrewMethodsView extends StatelessWidget {
  UserData _userData = UserData();
  final Base64Codec base64 = const Base64Codec();

  BrewMethodsView({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<HomeProvider>(context);
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          const SizedBox(width: 20),
          SvgPicture.asset(AppIcons.baristaTitle),
          const Spacer(),
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: theme.primaryColor,
                width: 2,
              ),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: (_userData.imagePath == null)
                    ? (provider.profileImage.isEmpty)
                        ? const AssetImage(
                            "assets/images/profile.png",
                          ) as ImageProvider
                        : MemoryImage(
                            base64.decode(provider.profileImage),
                          )
                    : NetworkImage(
                        "${Constants.baseURL}${_userData.imagePath}"),
              ),
            ),
          ),
          // Image.asset("assets/images/profile.png"),
          // SvgPicture.asset(AppIcons.profileIcon),
          const SizedBox(width: 20),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
            child: TextField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                hintText: "Brew Guide , Methods , Roaster ..",
                hintStyle: theme.textTheme.bodyMedium,
                filled: true,
                fillColor: Colors.black26,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ).setOnlyPadding(context, 0.02, 0.03, 0.0, 0.0),
          Text(
            "home.barista_methods".tr(),
            style: theme.textTheme.titleLarge,
          ),
          Text(
            "home.select_one".tr(),
            style: theme.textTheme.bodyMedium!
                .copyWith(color: const Color(0xFF6E8882)),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: LiquidPullToRefresh(
              height: 60,
              color: theme.primaryColor.withOpacity(0.4),
              backgroundColor: theme.colorScheme.onSecondary,
              springAnimationDurationInMilliseconds: 1000,
              animSpeedFactor: 2,
              showChildOpacityTransition: true,
              borderWidth: 2,
              onRefresh: provider.onRefresh,
              child: StaggeredGridView.countBuilder(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                itemBuilder: (context, index) => provider.isLoading
                    ? BrewItemLoading(
                        index: index,
                      )
                    : Bounceable(
                        onTap: () {
                          provider.changeListViewSelectedIndex(index);
                          Future.delayed(
                            const Duration(milliseconds: 300),
                            () {
                              navigatorKey.currentState?.pushNamed(
                                PageRouteNames.brewMethodDetails,
                                arguments: provider.brewDevicesList[index],
                              );
                            },
                          );
                        },
                        child: BrewItemWidget(
                          image: provider.getDeviceImage(index),
                          recipeInfoEntity: provider.brewDevicesList[index],
                          index: index,
                        ),
                      ),
                itemCount:
                    provider.isLoading ? 8 : provider.brewDevicesList.length,
                staggeredTileBuilder: (int index) =>
                    StaggeredTile.count(1, index.isEven ? 1.0 : 1.5),
              ),
            ),
          ),
        ],
      ).setHorizontalPadding(context, 0.04),
    );
  }
}

class BrewData {
  final String image;
  final String title;

  BrewData({
    required this.image,
    required this.title,
  });
}
