import 'dart:math' as math;
import 'dart:math';
import 'dart:ui';

import 'package:circular_chart_flutter/circular_chart_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/extensions/extensions.dart';
import '../../widgets/animated_circle_border.dart';

class BrewPlayView extends StatefulWidget {
  @override
  State<BrewPlayView> createState() => _BrewPlayViewState();
}

class _BrewPlayViewState extends State<BrewPlayView>
    with SingleTickerProviderStateMixin {
  double? _fraction = 0.0;

  // late Animation<double> _animation;
  // late AnimationController _controller;

  late AnimationController _controller;
  late Animation<double> _animation;

  // Number of arches to draw
  final int numberOfArches = 5;
  late List<double> angles;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Animation duration for each arch
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {
          // Update the angles based on the animation value
          angles = List<double>.generate(
            numberOfArches,
            (index) =>
                math.pi * 2 * _animation.value * (index + 1) / numberOfArches,
          );
        });
      });

    // Start the animation
    _controller.repeat(reverse: true);
    // _controller =
    //     AnimationController(duration: Duration(milliseconds: 5000), vsync: this);
    //
    // _animation = Tween(begin: 0.0, end: 1.0).animate(_controller)
    //   ..addListener(() {
    //     setState(() {
    //       _fraction = _animation.value;
    //     });
    //   });
    //
    // _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final GlobalKey<AnimatedCircularChartState> _chartKey =
      GlobalKey<AnimatedCircularChartState>();

  // List<CircularStackEntry> data = <CircularStackEntry>[
  //   CircularStackEntry(
  //     <CircularSegmentEntry>[
  //       CircularSegmentEntry(500.0, Colors.red[200], rankKey: 'Q1'),
  //       CircularSegmentEntry(1000.0, Colors.green[200], rankKey: 'Q2'),
  //       CircularSegmentEntry(2000.0, Colors.blue[200], rankKey: 'Q3'),
  //       CircularSegmentEntry(1000.0, Colors.yellow[200], rankKey: 'Q4'),
  //     ],
  //     rankKey: 'Quarterly Profits',
  //   ),
  // ];

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context);
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/brew_play_background.png"),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Row(
            children: [
              Image.asset("assets/icons/device_icon.png"),
              // SvgPicture.asset("assets/icons/device_icon.svg"),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    // args.deviceName,
                    "Chemex",
                    style: theme.textTheme.bodyLarge,
                  ),
                  Text(
                    "New Brew Session",
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              )
            ],
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/icons/wahtch_icn.svg"),
                SvgPicture.asset("assets/icons/clock_icon.svg"),
              ],
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  width: mediaQuery.size.width * 0.8,
                  height: mediaQuery.size.height * 0.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.black45,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedCircleBorder(),
                      /*Expanded(
                        child: TweenAnimationBuilder(
                          duration: const Duration(seconds: 2),
                          tween: Tween(begin: 0.0, end: 1.0),
                          curve: Curves.easeOutCubic,
                          builder: (context, value, child) {
                            return CustomPaint(
                              size: Size(mediaQuery.size.width,
                                  mediaQuery.size.height),
                              painter: ArchPainter(
                                  angles: angles ??
                                      List.filled(numberOfArches, 0)),
                              // CirclePainter(
                              //     fraction: _fraction
                              // ),
                              // painter: OpenPainter(
                              //   totalQuestions: 300,
                              //   learned: 75,
                              //   notLearned: 75,
                              //   range: value,
                              // ),
                            );
                          },
                        ),
                      ),*/
                      // const Text(
                      //   "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                      //   textAlign: TextAlign.center,
                      // ).setOnlyPadding(context,0.0,  0.025, 0.01, 0.01)
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 28,
                ),
                Row(
                  children: [
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: const Icon(
                        Icons.pause,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 20.0),
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: const Icon(
                        Icons.stop,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 28,
                ),
              ],
            ).setVerticalPadding(context, 0.1),
          ],
        ).setHorizontalPadding(context, 0.1),
      ),
    );
  }
}

class ArchPainter extends CustomPainter {
  final List<double> angles;

  ArchPainter({required this.angles});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    for (double angle in angles) {
      final rect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 3,
      );

      canvas.drawArc(
        rect,
        -angle,
        math.pi / 2,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class CustomAnimatedCircle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = size.width / 30.0;

    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset circleCenter = Offset(size.width / 2, size.height / 2);
    double circleRadius = (size.width - strokeWidth) / 3;
    Rect rectangle =
        Rect.fromCircle(center: circleCenter, radius: circleRadius);

    double startAngle = 30;
    double sweepAngle = pi;
    bool useCenter = false;

    canvas.drawArc(rectangle, startAngle, sweepAngle, useCenter, paint);

    // canvas.drawArc(rect, startAngle, sweepAngle, useCenter, paint)
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }
}

class CirclePainter extends CustomPainter {
  final double? fraction;
  late Paint _circlePaint;
  late bool isDraw = false;

  CirclePainter({this.fraction}) {
    _circlePaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;
  }

  final Paint _paint = Paint()
    ..color = Colors.black
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 3;

  @override
  void paint(Canvas canvas, Size size) {
    final Path path = Path();

    path.addArc(
        Rect.fromCircle(
            center: Offset(size.width / 2, size.height / 2),
            radius: 131.0909090909091),
        _degreesToRadians(-90).toDouble(),
        (_degreesToRadians(269.999 * fraction!).toDouble() -
            _degreesToRadians(-90).toDouble()));

    if (true) {
      path.arcTo(
          Rect.fromCircle(
              center: Offset(size.width / 2, size.height / 2),
              radius: 42.32727272727273),
          _degreesToRadians(269.999 * fraction!).toDouble(),
          _degreesToRadians(-90).toDouble() -
              _degreesToRadians((269.999) * fraction!).toDouble(),
          false);
    }
    path.addArc(
        Rect.fromCircle(
            center: Offset(size.width / 2, size.height / 2),
            radius: 131.0909090909091),
        _degreesToRadians(-90).toDouble(),
        (_degreesToRadians(179.999 * fraction!).toDouble() -
            _degreesToRadians(-90).toDouble()));
    path.arcTo(
        Rect.fromCircle(
            center: Offset(size.width / 2, size.height / 2),
            radius: 42.32727272727273),
        _degreesToRadians(179.999 * fraction!).toDouble(),
        _degreesToRadians(-90).toDouble() -
            _degreesToRadians((179.999) * fraction!).toDouble(),
        false);
    canvas.drawPath(path, _circlePaint);
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) {
    return oldDelegate.fraction != fraction;
  }
}

num _degreesToRadians(num deg) => deg * (pi / 180);

// class OpenPainter extends CustomPainter {
//   final learned;
//   final notLearned;
//   final range;
//   final totalQuestions;
//   double pi = math.pi;
//
//   OpenPainter({this.learned, this.totalQuestions, this.notLearned, this.range});
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     double strokeWidth = 20;
//     Rect myRect = const Offset(-50.0, -50.0) & const Size(100.0, 100.0);
//
//     var paint1 = Paint()
//       ..color = Colors.red
//       ..strokeWidth = strokeWidth
//       ..style = PaintingStyle.stroke;
//     var paint2 = Paint()
//       ..color = Colors.green
//       ..strokeWidth = strokeWidth
//       ..style = PaintingStyle.stroke;
//     var paint3 = Paint()
//       ..color = Colors.yellow
//       ..strokeWidth = strokeWidth
//       ..style = PaintingStyle.stroke;
//
//     double firstLineRadianStart = 0;
//     double _unAnswered =
//         (totalQuestions - notLearned - learned) * range / totalQuestions;
//     double firstLineRadianEnd = (360 * _unAnswered) * math.pi / 180;
//     canvas.drawArc(
//         myRect, firstLineRadianStart, firstLineRadianEnd, false, paint1);
//
//     double _learned = (learned) * range / totalQuestions;
//     double secondLineRadianEnd = getRadians(_learned);
//     canvas.drawArc(
//         myRect, firstLineRadianEnd, secondLineRadianEnd, false, paint2);
//     double _notLearned = (notLearned) * range / totalQuestions;
//     double thirdLineRadianEnd = getRadians(_notLearned);
//     canvas.drawArc(myRect, firstLineRadianEnd + secondLineRadianEnd,
//         thirdLineRadianEnd, false, paint3);
//
//     // drawArc(Rect rect, double startAngle, double sweepAngle, bool useCenter, Paint paint)
//   }
//
//   double getRadians(double value) {
//     return (360 * value) * pi / 180;
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => true;
// }

class StaticColors {
  static const List<Color> _defaultBarColors = [
    Color.fromRGBO(30, 0, 59, 1.0),
    Color.fromRGBO(236, 0, 138, 1.0),
    Color.fromRGBO(98, 133, 218, 1.0),
  ];
}

// class _NewCurvePainter extends CustomPainter {
//   final double angle;
//
//   final double startAngle;
//   final double angleRange;
//   final double trackwidth;
//   final double shadowWidth;
//   final double? shadowstep;
//   final Color shadowColor;
//   Offset? handler;
//   Offset? center;
//   late double radius;
//   List<Color>? trackColor;
//   final bool shadow;
//
//   final bool counterClockwise;
//   _NewCurvePainter(
//       {this.angle = 30,
//         this.trackwidth = 10,
//         this.trackColor,
//         required this.startAngle,
//         this.shadowWidth = 10,
//         this.shadowstep,
//         required this.shadowColor,
//         this.shadow = false,
//         this.counterClockwise = false,
//         required this.angleRange});
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     radius = math.min(size.width / 2, size.height / 2) - trackwidth * 0.5;
//     center = Offset(size.width / 2, size.height / 2);
//
//     final progressBarRect = Rect.fromLTWH(0.0, 0.0, size.width, size.width);
//
//     Paint trackPaint;
//     if (trackColor != null) {
//       final trackGradient = SweepGradient(
//         startAngle: degreeToRadians(startAngle),
//         endAngle: degreeToRadians(360),
//         tileMode: TileMode.mirror,
//         colors: trackColor!,
//       );
//       trackPaint = Paint()
//         ..shader = trackGradient.createShader(progressBarRect)
//         ..strokeCap = StrokeCap.round
//         ..style = PaintingStyle.stroke
//         ..strokeWidth = trackwidth;
//     } else {
//       trackPaint = Paint()
//         ..strokeCap = StrokeCap.round
//         ..style = PaintingStyle.stroke
//         ..strokeWidth = trackwidth
//         ..color = Colors.grey;
//     }
//     drawCircularArc(
//         canvas: canvas,
//         size: size,
//         paint: trackPaint,
//         ignoreAngle: true,
//         spinnerMode: true);
//
//     if (!shadow) {
//       drawShadow(canvas: canvas, size: size);
//     }
//
//     final currentAngle = counterClockwise ? -angle : angle;
//     final dynamicGradient = false;
//     final gradientRotationAngle = dynamicGradient
//         ? counterClockwise
//         ? startAngle + 10.0
//         : startAngle - 10.0
//         : 0.0;
//     final GradientRotation rotation =
//     GradientRotation(degreeToRadians(gradientRotationAngle));
//
//     final gradientStartAngle = dynamicGradient
//         ? counterClockwise
//         ? 360.0 - currentAngle.abs()
//         : 0.0
//         : startAngle;
//     final gradientEndAngle = dynamicGradient
//         ? counterClockwise
//         ? 360.0
//         : currentAngle.abs()
//         : 360;
//     final colors = dynamicGradient && counterClockwise
//         ? StaticColors._defaultBarColors.reversed.toList()
//         : StaticColors._defaultBarColors;
//
//     final progressBarGradient = kIsWeb
//         ? LinearGradient(
//       tileMode: TileMode.mirror,
//       colors: colors,
//     )
//         : SweepGradient(
//       transform: rotation,
//       startAngle: degreeToRadians(gradientStartAngle),
//       endAngle: degreeToRadians(360),
//       tileMode: TileMode.mirror,
//       colors: colors,
//     );
//
//     f. inal progressBarPaint = Paint()
//       ..shader = progressBarGradient.createShader(progressBarRect)
//       ..strokeCap = StrokeCap.round
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = trackwidth;
//     drawCircularArc(canvas: canvas, size: size, paint: progressBarPaint);
//
//     var dotPaint = Paint()..color = Colors.transparent;
//
//     Offset handler = degreesToCoordinates(
//         center!, -math.pi / 2 + startAngle + currentAngle + 1.5, radius);
//     canvas.drawCircle(handler, 10, dotPaint);
//   }
//
//   drawCircularArc(
//       {required Canvas canvas,
//         required Size size,
//         required Paint paint,
//         bool ignoreAngle = false,
//         bool spinnerMode = false}) {
//     final double angleValue = ignoreAngle ? 0 : (angleRange - angle);
//     final range = counterClockwise ? -angleRange : angleRange;
//     final currentAngle = counterClockwise ? angleValue : -angleValue;
//     canvas.drawArc(
//         Rect.fromCircle(center: center!, radius: radius),
//         degreeToRadians(spinnerMode ? 0 : startAngle),
//         degreeToRadians(spinnerMode ? 360 : range + currentAngle),
//         false,
//         paint);
//   }
//
//   drawShadow({required Canvas canvas, required Size size}) {
//     final shadowStep = shadowstep != null
//         ? shadowstep!
//         : math.max(1, (shadowWidth - trackwidth) ~/ 10);
//     final maxOpacity = math.min(1.0, 2);
//     final repetitions = math.max(1, ((shadowWidth - trackwidth) ~/ shadowStep));
//     final opacityStep = maxOpacity / repetitions;
//     final shadowPaint = Paint()
//       ..strokeCap = StrokeCap.round
//       ..style = PaintingStyle.stroke;
//     for (int i = 1; i <= repetitions; i++) {
//       shadowPaint.strokeWidth = trackwidth + i * shadowStep;
//       if (StaticColors._defaultBarColors.first == primaryColor) {
//         shadowPaint.color = Colors.transparent.withOpacity(0);
//       } else {
//         shadowPaint.color = StaticColors._defaultBarColors.first == redColor
//             ? Colors.transparent
//             : shadowColor.withOpacity(maxOpacity - (opacityStep * (i - 1)));
//       }
//
//       drawCircularArc(canvas: canvas, size: size, paint: shadowPaint);
//     }
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return true;
//   }
// }
