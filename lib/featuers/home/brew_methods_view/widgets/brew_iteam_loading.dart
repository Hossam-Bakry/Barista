import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BrewItemLoading extends StatelessWidget {
  final int index;

  const BrewItemLoading({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      delay: Duration(milliseconds: (index * 50 + 100)),
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
    );
  }
}
