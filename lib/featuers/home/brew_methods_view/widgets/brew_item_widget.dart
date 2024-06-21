import 'package:animate_do/animate_do.dart';
import 'package:barista/core/config/constants.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entities/home/recipe_info_entity.dart';

class BrewItemWidget extends StatelessWidget {
  final RecipeInfoEntity recipeInfoEntity;
  final String image;

  // final String title;
  final int index;

  const BrewItemWidget({
    super.key,
    required this.index,
    required this.image,
    required this.recipeInfoEntity,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return FadeInUp(
      delay: Duration(milliseconds: (index * 50 + 100)),
      child: Container(
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          image: DecorationImage(
            image:
                // AssetImage(
                //   image,
                // ),
                (recipeInfoEntity.brewDeviceImage == null ||
                        recipeInfoEntity.brewDeviceImage.isEmpty)
                    ? AssetImage(
                        image,
                      )
                    : NetworkImage(
                            "${Constants.baseURL}${recipeInfoEntity.brewDeviceImage}")
                        as ImageProvider,
            fit: BoxFit.cover,
          ),
        ),
        child: Text(
          recipeInfoEntity.deviceName,
          style: theme.textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
