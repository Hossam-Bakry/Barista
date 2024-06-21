import 'package:flutter/material.dart';

class BrewItemOdd extends StatelessWidget {
  final String image;
  final String title;

  const BrewItemOdd({
    super.key,
    required this.image,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Container(
      width: 170,
      height: 255,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        image: DecorationImage(
          image: AssetImage(image),
        ),
      ),
      child: Text(
        title,
        style: theme.textTheme.bodyLarge,
      ),
    );
  }
}
