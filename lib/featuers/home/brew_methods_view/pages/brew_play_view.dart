import 'dart:async';
import 'dart:ui';

import 'package:barista/core/config/page_route_names.dart';
import 'package:custom_timer/custom_timer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/services/sound_service.dart';
import '../../../../core/widgets/border_rounded_button.dart';
import '../../../../domain/entities/home/recipe_info_entity.dart';
import '../../../../main.dart';
import '../provider/brew_method_provider.dart';
import '../widgets/animated_circle_border.dart';

class BrewPlayView extends StatefulWidget {
  final RecipeInfoEntity? recipeInfo;

  const BrewPlayView({
    super.key,
    this.recipeInfo,
  });

  @override
  State<BrewPlayView> createState() => _BrewPlayViewState();
}

class _BrewPlayViewState extends State<BrewPlayView>
    with TickerProviderStateMixin {
  late Animation<double> _animationStart;
  late CurvedAnimation _curvedAnimation;

  // late CustomTimerController _controller;
  late CustomTimerController _startController;
  late BrewMethodProvider provider;

  @override
  void initState() {
    provider = Provider.of<BrewMethodProvider>(context, listen: false);
    provider.createControllers(this, widget.recipeInfo!.recipeSteps);

    _startController = CustomTimerController(
      vsync: this,
      begin: const Duration(seconds: 3),
      end: const Duration(),
      initialState: CustomTimerState.reset,
      interval: CustomTimerInterval.seconds,
    );
    provider.controller = CustomTimerController(
      // _controller = CustomTimerController(
      vsync: this,
      end: Duration(seconds: provider.totalTime),
      begin: const Duration(),
      initialState: CustomTimerState.finished,
      interval: CustomTimerInterval.milliseconds,
    );
    _startController.start();
    // Timer(
    //   const Duration(seconds: 5),
    //   () {
    //     NotificationService.showNotification(
    //         title: "Next Step", body: "previous step: }");
    //   },
    // );

    super.initState();
  }

  @override
  void dispose() {
    provider.controller.dispose();
    _startController.dispose();
    _curvedAnimation.dispose();
    _animationStart.removeListener(() {});

    for (var element in provider.controllersList) {
      element.dispose();
    }
    super.dispose();
  }

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
              margin: const EdgeInsets.symmetric(horizontal: 30),
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.01,
                horizontal: 2,
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
                  Lottie.asset("assets/icons/coffee_prepare_done.json",
                      alignment: Alignment.topCenter,
                      fit: BoxFit.fitHeight,
                      height: MediaQuery.of(context).size.height * 0.15,
                      repeat: false),
                  Text(
                    "recipe_data.dialog_title_play".tr(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "recipe_data.dialog_desc_play".tr(),
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
                      onPressed: () {
                        navigatorKey.currentState!.pop();
                        navigatorKey.currentState!.pushReplacementNamed(
                          PageRouteNames.brewDonePage,
                          arguments: widget.recipeInfo,
                        );
                        Provider.of<BrewMethodProvider>(context, listen: false)
                            .clearProviderData();
                      }),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  var done = false;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context);

    return Consumer<BrewMethodProvider>(
      builder: (context, vm, _) {
        // print(vm.stepNumber);

        if (vm.controllersList[vm.controllersList.length - 1].isCompleted) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            // Your code HERE
            // Flutter will wait until the current build is completed before executing this code.
            showEndDialog(context);
          });
        }

        _curvedAnimation = CurvedAnimation(
          parent: vm.controllersList[vm.stepNumber],
          curve: Curves.linear,
        );

        _animationStart =
            Tween<double>(begin: 0, end: 360).animate(_curvedAnimation)
              ..addListener(
                () {
                  vm.playNextAnimation(context);
                },
              );

        return Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/brew_play_background.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Scaffold(
            appBar: AppBar(
              centerTitle: false,
              leading: InkWell(
                onTap: () {
                  navigatorKey.currentState!.pop();
                  Future.delayed(
                    const Duration(seconds: 1),
                    () => provider.clearProviderData(),
                  );
                },
                child: const Icon(Icons.arrow_back_ios),
              ),
              title: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // args.deviceName,
                        widget.recipeInfo!.deviceName,
                        style: theme.textTheme.bodyLarge,
                      ),
                      Text(
                        "recipe_data.brew_new_session".tr(),
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  )
                ],
              ),
              actions: [
                InkWell(
                  onTap: () {
                    navigatorKey.currentState!.pushNamedAndRemoveUntil(
                      PageRouteNames.home,
                      (route) => false,
                    );
                    vm.clearProviderData();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: theme.primaryColor,
                      child: Icon(
                        Icons.home_filled,
                        size: 32,
                        color: theme.colorScheme.onSecondary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (vm.isStart == false)
                  Countdown(
                    seconds: 3,
                    build: (BuildContext context, double time) => Text(
                      time.toString().substring(0, 1),
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: theme.primaryColor,
                          ),
                    ),
                    interval: const Duration(seconds: 1),
                    onFinished: () {
                      SoundService.instance.playTapDownSound();
                      vm.changeStartState(true);
                      provider.controller.start();
                      vm.play();
                    },
                  ),
                if (vm.isStart == true)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          padding: const EdgeInsets.only(top: 8),
                          alignment: Alignment.center,
                          child:
                              SvgPicture.asset("assets/icons/wahtch_icn.svg")),
                      const SizedBox(width: 8.0),
                      SizedBox(
                        width: 160,
                        child: CustomTimer(
                          controller: provider.controller,
                          builder: (state, time) {
                            provider.initialTime = time.duration.inSeconds;
                            return Row(
                              children: [
                                Text(
                                  "${time.minutes}:${time.seconds}.",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                Text(
                                  time.milliseconds.substring(0, 2),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                ),
                              ],
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      width: mediaQuery.size.width * 0.8,
                      height: mediaQuery.size.height * 0.52,
                      padding: const EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Colors.black45,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // const Spacer(),
                          SizedBox(
                            height: mediaQuery.size.height * 0.3,
                            child: Stack(
                              alignment: Alignment.center,
                              clipBehavior: Clip.none,
                              children: [
                                CustomPaint(
                                  painter: CirclePainter(
                                    arc: _animationStart.value,
                                    startAngle: _animationStart.value,
                                    progressColor: vm
                                        .stepsDetails[vm.stepNumber].stepColor,
                                  ),
                                ),
                                Positioned(
                                  left:
                                      MediaQuery.of(context).size.width * 0.465,
                                  child: Knob(),
                                ),
                                WaterFlow(
                                  controller: vm.controllersList[vm.stepNumber],
                                  recipeInfo: widget.recipeInfo!,
                                ),
                              ],
                            ),
                          ),
                          Text(
                            widget.recipeInfo!.recipeSteps[vm.stepNumber]
                                .description,
                            // "Wait for the water to drain through the grounds. When done remove the filter and serve.",
                            textAlign: TextAlign.center,
                          ).setHorizontalAndVerticalPadding(
                              context, 0.01, 0.02),
                        ],
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (vm.stepNumber != 0)
                      Bounceable(
                        onTap: () {
                          vm.playPreviousStep();
                        },
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: theme.primaryColor.withOpacity(0.4),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                      ),
                    const Spacer(),
                    Row(
                      children: [
                        if (vm.controllersList[vm.stepNumber].isAnimating ||
                            vm.isStart == false)
                          GestureDetector(
                            onTap: () {
                              vm.pause();
                              provider.controller.pause();
                            },
                            child: Container(
                              width: 42,
                              height: 42,
                              decoration: BoxDecoration(
                                  color: Colors.white24,
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: const Icon(
                                Icons.pause_rounded,
                                color: Colors.red,
                                size: 28,
                              ),
                            ),
                          ),
                        if (!vm.controllersList[vm.stepNumber].isAnimating &&
                            vm.isStart == true)
                          GestureDetector(
                            onTap: () {
                              vm.reset();
                              provider.controller.reset();
                            },
                            child: Container(
                              width: 42,
                              height: 42,
                              decoration: BoxDecoration(
                                  color: Colors.white24,
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: const Icon(
                                Icons.stop_rounded,
                                color: Colors.red,
                                size: 28,
                              ),
                            ),
                          ),
                        const SizedBox(width: 20.0),
                        if (!vm.controllersList[vm.stepNumber].isAnimating &&
                            vm.isStart == true)
                          GestureDetector(
                            onTap: () async {
                              // showEndDialog(context);
                              await SoundService.instance.playTapDownSound();
                              vm.play();
                              provider.controller.start();
                            },
                            child: Container(
                              width: 42,
                              height: 42,
                              decoration: BoxDecoration(
                                  color: Colors.white24,
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: const Icon(
                                Icons.play_arrow_rounded,
                                color: Colors.amber,
                                size: 28,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const Spacer(),
                    if (vm.isStart != false)
                      Bounceable(
                        onTap: () {
                          vm.playNextStep(showEndDialog);
                          print("done");
                        },
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: theme.primaryColor.withOpacity(0.4),
                          child: const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                      ),
                  ],
                ).setVerticalPadding(context, 0.1),
              ],
            ).setHorizontalPadding(context, 0.1),
          ),
        );
      },
    );
  }
}
