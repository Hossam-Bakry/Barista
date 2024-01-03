import 'package:barista/core/config/page_route_names.dart';
import 'package:barista/core/extensions/extensions.dart';
import 'package:barista/main.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../domain/entities/intor/intor_data.dart';

class IntroView extends StatefulWidget {
  const IntroView({Key? key}) : super(key: key);

  @override
  State<IntroView> createState() => _IntroViewState();
}

class _IntroViewState extends State<IntroView> {
  final PageController _pageController = PageController();

  int currentIndex = 0;
  final List<IntroData> _list = [
    const IntroData(
      title: "It’s a Coffee time ?",
      body: "Get your favourite food the fastest way possible.",
      image: "assets/images/intro_one.png",
    ),
    const IntroData(
      title: "It’s a Coffee time ?",
      body: "Get your favourite food the fastest way possible.",
      image: "assets/images/intro_two.png",
    ),
    const IntroData(
      title: "It’s a Coffee time ?",
      body: "Get your favourite food the fastest way possible.",
      image: "assets/images/intro_three.png",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            "assets/images/intro_background.png",
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(_list[index].image,
                          height: mediaQuery.height * 0.6,
                          width: mediaQuery.width,
                          fit: BoxFit.fitHeight),
                    ],
                  );
                },
                itemCount: _list.length,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            AnimatedSmoothIndicator(
              activeIndex: currentIndex,
              count: 3,
              effect: CustomizableEffect(
                dotDecoration: DotDecoration(
                    width: 10,
                    height: 10,
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white38),
                activeDotDecoration: DotDecoration(
                  width: 15,
                  height: 15,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                spacing: 15,
              ),
            ),
            Column(
              children: [
                Text(
                  "It’s a Coffee time ?",
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                Text(
                  "Get your favourite food the fastest way possible.",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleMedium,
                ).setHorizontalPadding(context, 0.1),
              ],
            ).setOnlyPadding(context, 0.05, 0.05, 0.0, 0.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    if (currentIndex == 2) {
                      navigatorKey.currentState!
                          .pushReplacementNamed(PageRouteNames.login);
                    } else {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.easeInOutQuint,
                      );
                    }
                  },
                  borderRadius: BorderRadius.circular(25.0),
                  child: AnimatedContainer(
                    alignment: Alignment.center,
                    duration: const Duration(milliseconds: 300),
                    height: 50,
                    width: (currentIndex == (_list.length - 1))
                        ? mediaQuery.width * 0.8
                        : 180,
                    decoration: BoxDecoration(
                      color: theme.primaryColor,
                      borderRadius: BorderRadius.circular(35),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        (currentIndex == (_list.length - 1))
                            ? Text(
                                "Lets Start",
                                style: theme.textTheme.bodyMedium!.copyWith(
                                    color: theme.colorScheme.onSecondary,
                                    fontWeight: FontWeight.w500),
                              )
                            : Text(
                                "Next",
                                style: theme.textTheme.bodyMedium!.copyWith(
                                    color: theme.colorScheme.onSecondary,
                                    fontWeight: FontWeight.w500),
                              ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.arrow_forward,
                          size: 18,
                          color: theme.colorScheme.onSecondary,
                        )
                      ],
                    ),
                  ),
                ),
                if (currentIndex != 2)
                  GestureDetector(
                    onTap: () {
                      navigatorKey.currentState!
                          .pushReplacementNamed(PageRouteNames.login);
                    },
                    child: Text(
                      "Skip",
                      style: theme.textTheme.bodyLarge,
                    ),
                  )
              ],
            ).setHorizontalAndVerticalPadding(context, 0.1, 0.04),
            // const Spacer(),
          ],
        ),
      ),
    );
  }
}
