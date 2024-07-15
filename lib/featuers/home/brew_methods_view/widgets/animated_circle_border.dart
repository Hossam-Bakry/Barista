import 'dart:math' as math;
import 'package:barista/main.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/entities/home/recipe_info_entity.dart';
import 'wave.dart';
import '../../../../domain/entities/home/recipe_steps_details.dart';
import '../provider/brew_method_provider.dart';

class AnimatedCircleBorder extends StatefulWidget {
  // AnimationController animatedController;
  List<AnimationController> controllersList;
  List<RecipeStepDetails> stepsList;
  BrewMethodProvider vm;

  AnimatedCircleBorder({
    super.key,
    // required this.animatedController,
    required this.controllersList,
    required this.stepsList,
    required this.vm,
  });

  @override
  State<AnimatedCircleBorder> createState() => _AnimatedCircleBorderState();
}

class _AnimatedCircleBorderState extends State<AnimatedCircleBorder>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animationStart;
  late CurvedAnimation _curvedAnimation;

  // late BrewMethodProvider vm;

  @override
  void initState() {
    super.initState();

    // vm = Provider.of<BrewMethodProvider>(context, listen: false);
    _curvedAnimation = CurvedAnimation(
      parent: widget.controllersList[widget.vm.stepNumber],
      curve: Curves.linear,
    );
  }


  @override
  void dispose() {
    for(var element in widget.controllersList){
      element.dispose();
    }
    _curvedAnimation.dispose();
    _animationStart.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _animationStart =
        Tween<double>(begin: 0, end: 360).animate(_curvedAnimation)
          ..addListener(() {
            if (mounted) setState(() {});
          });
    if (widget.controllersList[widget.vm.stepNumber].isCompleted) {
      widget.controllersList[widget.vm.stepNumber].reset();
      widget.vm.increaseStepNumber().then((value) {
        print("Done ---->");
        widget.controllersList[widget.vm.stepNumber].forward();
        setState(() {});
      });
    }

    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            CustomPaint(
              painter: CirclePainter(
                arc: _animationStart.value,
                startAngle: _animationStart.value,
                progressColor: widget.stepsList[widget.vm.stepNumber].stepColor,
              ),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width * 0.465,
              child: Knob(),
            ),
            // WaterFlow(),
          ],
        ),
      ],
    );
  }
}

class CirclePainter extends CustomPainter {
  double arc;
  Color progressColor;
  double startAngle;

  CirclePainter({
    required this.startAngle,
    required this.progressColor,
    required this.arc,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var sweepAngle = -arc;
    Offset center = size.center(Offset.zero);

    Rect rect = Rect.fromCircle(
        center: center,
        radius: MediaQuery.of(navigatorKey.currentContext!).size.width * 0.28);

    var paint1 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 16
      ..color = progressColor;

    canvas.drawArc(
      rect,
      startAngle,
      math.pi * 2,
      false,
      Paint()
        ..color = Colors.white10
        ..style = PaintingStyle.stroke
        ..strokeWidth = 18,
    );

    canvas.drawArc(
        rect, toRadian(startAngle), toRadian(sweepAngle), false, paint1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class MyPainter extends CustomPainter {
  final double firstValue;
  final double secondValue;
  final double thirdValue;
  final double fourthValue;

  MyPainter(
    this.firstValue,
    this.secondValue,
    this.thirdValue,
    this.fourthValue,
  );

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = const Color(0xff3B6ABA).withOpacity(.8)
      ..style = PaintingStyle.fill;

    var path = Path()
      ..moveTo(0, size.height / firstValue)
      ..cubicTo(size.width * .4, size.height / secondValue, size.width * .7,
          size.height / thirdValue, size.width, size.height / fourthValue)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class Knob extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 6,
      width: 30,
      decoration: BoxDecoration(
        color: Colors.black87,
        border: Border.all(color: Colors.white, width: 1.5),
        // shape: BoxShape.circle,
      ),
    );
  }
}

class WaterFlow extends StatefulWidget {
  AnimationController controller;
  RecipeInfoEntity recipeInfo;

  WaterFlow({
    super.key,
    required this.controller,
    required this.recipeInfo,
  });

  @override
  State<WaterFlow> createState() => _WaterFlowState();
}

class _WaterFlowState extends State<WaterFlow> with TickerProviderStateMixin {
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
  }
@override
  void dispose() {

    widget.controller.dispose();
    super.dispose();
  }
  @override
  void deactivate() {}

  @override
  Widget build(BuildContext context) {
    return Consumer<BrewMethodProvider>(
      builder: (context, vm, _) {
        _animation = Tween<double>(begin: 0.0, end: 1).animate(
          CurvedAnimation(
            parent: vm.controllersList[vm.stepNumber],
            curve: Curves.linear,
          ),
        )..addListener(() {
            if (mounted) setState(() {});
          });

        return Container(
          width: MediaQuery.of(navigatorKey.currentContext!).size.width * 0.45,
          height: MediaQuery.of(navigatorKey.currentContext!).size.width * 0.45,
          decoration: const BoxDecoration(
              color: Colors.white10, shape: BoxShape.circle),
          child: Stack(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipPath(
                clipper: _CircleClipper(),
                child: CustomPaint(
                  painter: _CirclePainter(
                    color: Colors.white10,
                  ),
                  child: Stack(
                    children: [
                      Wave(
                        value: _animation.value,
                        color: Colors.blue.shade400,
                        direction: Axis.vertical,
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${widget.recipeInfo.water.ceilToDouble()} g",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 30),
                  ),
                  const Divider(
                    indent: 20,
                    endIndent: 20,
                    color: Colors.grey,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            "recipe_data.weight".tr(),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            "${widget.recipeInfo.coffee.ceilToDouble()}g",
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: Theme.of(context).primaryColor,
                                    ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

const double _twoPi = math.pi * 2.0;
const double _epsilon = .001;
const double _sweep = _twoPi - _epsilon;

class _CirclePainter extends CustomPainter {
  final Color color;

  _CirclePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    canvas.drawArc(Offset.zero & size, 0, _sweep, false, paint);
  }

  @override
  bool shouldRepaint(_CirclePainter oldDelegate) => color != oldDelegate.color;
}

class _CircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()..addArc(Offset.zero & size, 0, _sweep);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

double toRadian(double value) => (value * math.pi) / 180;
