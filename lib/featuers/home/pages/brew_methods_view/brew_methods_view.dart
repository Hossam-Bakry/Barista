import 'package:barista/featuers/home/widgets/brew_iteam_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../core/config/app_icons.dart';
import '../../../../core/config/page_route_names.dart';
import '../../../../core/extensions/extensions.dart';
import '../../../../main.dart';
import '../../provider/home_provider.dart';
import '../../widgets/brew_item_widget.dart';

class BrewMethodsView extends StatelessWidget {
  const BrewMethodsView({super.key});

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
          Image.asset("assets/images/profile.png"),
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
            "Brew Methos",
            style: theme.textTheme.titleLarge,
          ),
          Text(
            "Select a Guide to start",
            style: theme.textTheme.bodyMedium!
                .copyWith(color: const Color(0xFF6E8882)),
          ),
          // Expanded(
          //   child: GridView(
          //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //       crossAxisCount: 2,
          //       childAspectRatio: 9/11
          //     ),
          //     children: [
          //       BrewItemEven(image: provider.brewDataList[0].image, title: provider.brewDataList[0].title,),
          //       BrewItemOdd(image: provider.brewDataList[1].image, title: provider.brewDataList[1].title,),
          //       BrewItemEven(image: provider.brewDataList[2].image, title: provider.brewDataList[2].title,),
          //       BrewItemOdd(image: provider.brewDataList[3].image, title: provider.brewDataList[3].title,),
          //       BrewItemEven(image: provider.brewDataList[4].image, title: provider.brewDataList[4].title,),
          //       BrewItemOdd(image: provider.brewDataList[5].image, title: provider.brewDataList[5].title,),
          //       BrewItemEven(image: provider.brewDataList[6].image, title: provider.brewDataList[6].title,),
          //     ],
          //   ),
          // ),
          const SizedBox(height: 20),
          Expanded(
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
