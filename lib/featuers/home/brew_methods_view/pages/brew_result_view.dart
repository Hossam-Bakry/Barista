import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:barista/core/extensions/extensions.dart';
import 'package:barista/core/widgets/border_rounded_button.dart';
import 'package:barista/core/widgets/custom_text_field.dart';
import 'package:barista/domain/entities/home/recipe_info_entity.dart';
import 'package:barista/featuers/home/brew_methods_view/provider/brew_method_provider.dart';
import 'package:barista/featuers/home/provider/home_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../../core/config/page_route_names.dart';
import '../../../../main.dart';

class BrewResultView extends StatelessWidget {
  TextEditingController reviewController = TextEditingController();

  BrewResultView({super.key});

  showEndDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.zero,
        insetPadding: const EdgeInsets.all(16),
        content: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 30),
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.01,
                horizontal: 8,
              ),
              decoration: BoxDecoration(
                color: Colors.white10,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                  )
                ],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 15),
                  Lottie.asset(
                    "assets/icons/send_mail_icn.json",
                    alignment: Alignment.topCenter,
                    fit: BoxFit.fitHeight,
                    height: MediaQuery.of(context).size.height * 0.12,
                    repeat: true,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "rate.dialog_title_rate".tr(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "rate.dialog_desc_rate".tr(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  BorderRoundedButton(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.054,
                      title: "Done",
                      color: Theme.of(context).colorScheme.onSecondary,
                      // onPressed: () => navigatorKey.currentState!.pop(),
                      onPressed: () {
                        // navigatorKey.currentState!.pushNamedAndRemoveUntil(
                        //   PageRouteNames.home,
                        //       (route) => false,
                        // );
                        navigatorKey.currentState!.pop();
                        navigatorKey.currentState!.pop();

                        Provider.of<BrewMethodProvider>(context, listen: false)
                            .clearProviderData();
                      }),
                  Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context);
    var args = ModalRoute.of(context)!.settings.arguments as RecipeInfoEntity;

    print(args.id);
    return Consumer<BrewMethodProvider>(
      builder: (context, vm, _) => Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/brew_play_background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Beehouse",
              style: theme.textTheme.titleLarge,
            ),
          ),
          // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          // floatingActionButton: FadeInUp(
          //   delay: const Duration(milliseconds: 250),
          //   child: BorderRoundedButton(
          //     title: "Save changes",
          //     icon: Icons.arrow_forward,
          //     color: theme.colorScheme.onSecondary,
          //   ),
          // ),
          body: ListView(
            children: [
              FadeInUp(
                delay: const Duration(milliseconds: 100),
                child: Container(
                  width: mediaQuery.size.width,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.onSecondary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      SvgPicture.asset("assets/icons/cup_icn.svg"),
                      // Lottie.asset(
                      //     "assets/icons/done_create_icn.json",
                      //     alignment: Alignment.topCenter,
                      //     fit: BoxFit.fitHeight,
                      //     height: MediaQuery.of(context).size.height * 0.15,
                      //     repeat: true
                      // ),
                      Text(
                        "rate.all_done".tr(),
                        style: theme.textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "rate.desc".tr(),
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: const Color(0xFF6E8882),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              FadeInUp(
                delay: const Duration(milliseconds: 150),
                child: Container(
                  width: mediaQuery.size.width,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  decoration: BoxDecoration(
                    // color: Color(0xFF0E382F),
                    color: theme.colorScheme.onSecondary,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: mediaQuery.size.width * 0.18,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "rate.coffee".tr(),
                                  style: theme.textTheme.bodySmall,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  " ${args.coffee} g",
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.bodyLarge!
                                      .copyWith(color: theme.primaryColor),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 60,
                            color: const Color(0x4DFFFFFF),
                          ),
                          SizedBox(
                            width: mediaQuery.size.width * 0.18,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "rate.water".tr(),
                                  style: theme.textTheme.bodySmall,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  " ${args.water} g",
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.bodyLarge!
                                      .copyWith(color: theme.primaryColor),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 60,
                            color: const Color(0x4DFFFFFF),
                          ),
                          SizedBox(
                            width: mediaQuery.size.width * 0.18,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "rate.grinder".tr(),
                                  style: theme.textTheme.bodySmall,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  args.grinder,
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.bodyLarge!
                                      .copyWith(color: theme.primaryColor),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "rate.review_your_recipe".tr(),
                            style: theme.textTheme.bodyMedium!
                                .copyWith(color: const Color(0xFF6E8882)),
                          ),
                          const SizedBox(width: 6.0),
                          const Icon(
                            Icons.arrow_forward,
                            size: 20,
                            color: Color(0xFF6E8882),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              FadeInUp(
                delay: const Duration(milliseconds: 200),
                child: Container(
                  width: mediaQuery.size.width,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                  decoration: BoxDecoration(
                    // color: Color(0xFF0E382F),
                    color: theme.colorScheme.onSecondary,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "rate.additional_information".tr(),
                        style: theme.textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "rate.brew_time".tr(),
                            style: theme.textTheme.bodyMedium,
                          ),
                          Text(
                            "${(args.brewedTime * 60)} ${"rate.secs".tr()}",
                            style: theme.textTheme.bodyMedium!
                                .copyWith(color: theme.primaryColor),
                          ),
                        ],
                      ),
                      const Divider(thickness: 0.5),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "rate.rating".tr(),
                            style: theme.textTheme.bodyMedium,
                          ),
                          RatingBar.builder(
                            initialRating: 0,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: false,
                            itemSize: 26,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              vm.setRating(rating.toInt());
                              print(rating);
                            },
                          ),
                        ],
                      ),
                      const Divider(thickness: 0.5),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: vm.commentController,
                        hint: "rate.add_note".tr(),
                        hintColor: Colors.white38,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 60),
              FadeInUp(
                delay: const Duration(milliseconds: 250),
                child: BorderRoundedButton(
                  title: "rate.send_rate".tr(),
                  icon: Icons.arrow_forward,
                  color: theme.colorScheme.onSecondary,
                  onPressed: () {
                    vm.sendRate(args.id).then((value) {
                      if (value == true) {
                        showEndDialog(context);
                        vm.clearProviderData();
                      }
                    });
                  },
                ),
              ),
            ],
          ).setHorizontalAndVerticalPadding(context, 0.05, 0.02),
        ),
      ),
    );
  }
}
