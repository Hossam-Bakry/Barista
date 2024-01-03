import 'dart:math' as math;

import 'package:flutter/material.dart';

class AnimatedCircleBorder extends StatefulWidget {
  @override
  State<AnimatedCircleBorder> createState() => _AnimatedCircleBorderState();
}

class _AnimatedCircleBorderState extends State<AnimatedCircleBorder>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animationStart;
  late Animation<double> _animationEnd;
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    );

    var _curvedAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear,
    );

    _animationEnd =
        Tween<double>(begin: 0, end: 31.30).animate(_curvedAnimation)
          ..addListener(() {
            setState(() {});
          });

    _animationStart =
        Tween<double>(begin: -31.30, end: 0).animate(_curvedAnimation)
          ..addListener(() {
            setState(() {});
          });

    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    Size canvasSize = Size(screenSize.width, screenSize.height - 35);
    Offset center = canvasSize.center(Offset.zero);

    return Stack(
      // alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        CustomPaint(
          painter: CirclePainter(
            arc: _animationStart.value,
            startAngle: _animationEnd.value,
            progressColor: Colors.amber,
          ),
        ),
        Positioned(
          left: -14,
          // right: 0,
          top: -MediaQuery.of(context).size.height * 0.145,
          child: _Knob(),
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

    Rect rect = Rect.fromCircle(center: center, radius: 110);

    var paint1 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 16
      ..color = Colors.amber;

    var paint2 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 16
      ..color = Colors.amber;

    var paint3 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 16
      ..color = Colors.amber;

    canvas.drawArc(
      rect,
      startAngle,
      math.pi * 2,
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 22,
    );

    canvas.drawArc(
      rect,
      toRadian(-31.30),
      sweepAngle,
      false,
      paint1..color = Colors.red,
    );

    // canvas.drawArc(
    //   rect,
    //   toRadian(270),
    //   toRadian(50),
    //   false,
    //   paint2..color = Colors.red,
    // );
    //
    // canvas.drawArc(
    //   rect,
    //   toRadian(270),
    //   toRadian(50),
    //   false,
    //   paint3..color = Colors.red,
    // );

    // canvas.drawArc(rect, (3 * math.pi) / 2, sweepAngle, false, paint2);

    // canvas.drawArc(
    //   rect,
    //   0,
    //   math.pi,
    //   false,
    //   Paint()
    //     ..style = PaintingStyle.stroke
    //     ..color = Colors.blue
    //     ..strokeWidth = 20,
    // );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class _Knob extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 26,
      width: 26,
      decoration: BoxDecoration(
        color: Colors.black87,
        border: Border.all(color: Colors.white, width: 1.5),
        shape: BoxShape.circle,
      ),
    );
  }
}

double toRadian(double value) => (value * math.pi) / 180;
