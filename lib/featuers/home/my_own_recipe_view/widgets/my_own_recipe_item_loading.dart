import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MyOwnRecipeItemLoading extends StatelessWidget {
  final int index;

  const MyOwnRecipeItemLoading({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      delay: Duration(milliseconds: (index * 50 + 100)),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 120,
        width: MediaQuery.of(context).size.width,
        child: Shimmer.fromColors(
          direction: ShimmerDirection.ltr,
          period: const Duration(milliseconds: 2000),
          baseColor: Colors.grey.withOpacity(0.5),
          highlightColor: Colors.grey.shade500,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
        ),
      ),
    );
  }
}
