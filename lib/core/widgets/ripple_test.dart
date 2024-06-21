import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

class RippleAnimationTest extends StatefulWidget {
  RippleAnimationTest({
    Key? key,
    required this.child,
    required this.size,
    required this.onPress,
    required this.minRadius,
    this.color = Colors.teal,
    this.repeat = false,
    this.delay = const Duration(milliseconds: 0),
    this.duration = const Duration(milliseconds: 1500),
    this.ripplesCount = 60,
  }) : super(key: key);

  final Widget child;
  final Function() onPress;
  final Size size;
  Duration delay;
  final double minRadius;
  Color color;
  final int ripplesCount;
  final Duration duration;
  final bool repeat;

  @override
  State<RippleAnimationTest> createState() => _RippleAnimationState();
}

class _RippleAnimationState extends State<RippleAnimationTest>
    with TickerProviderStateMixin {
  Widget get child => widget.child;

  double get radius => widget.minRadius;

  Duration get delay => widget.delay;

  Duration get duration => widget.duration;

  bool get repeat => widget.repeat;

  Color get color => widget.color;

  int get rippleCount => widget.ripplesCount;
  AnimationController? animationController;

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      scaleFactor: 0.6,
      onTap: () {
        widget.onPress();
        // animationController!.forward();
        if (animationController!.isCompleted) {
          animationController!.reset();
          animationController!.forward();
        } else {
          animationController!.forward();
        }
      },
      child: SizedBox(
          width: widget.size.width,
          height: widget.size.height,
          child: CustomPaint(
            painter: AnimatedCircle(animationController,
                minRadius: radius,
                wavesCount: rippleCount + 2,
                color: color,
                key: UniqueKey()),
            child: child,
          )),
    );
  }

  @override
  void initState() {
    animationController = AnimationController(vsync: this, duration: duration);
    // TODO: implement initState
    // Timer(delay, (){
    //   repeat?animationController!.repeat(): animationController!.forward();
    // });
    super.initState();
  }

  @override
  void dispose() {
    animationController!.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}

class AnimatedCircle extends CustomPainter {
  AnimatedCircle(this.animation,
      {Key? key,
      this.color = Colors.teal,
      this.minRadius = 50,
      this.wavesCount = 2})
      : super(repaint: animation);

  final Color color;
  final double minRadius;
  final int wavesCount;
  final Animation<double>? animation;

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    final Rect rect = Rect.fromLTRB(0.0, 0.0, size.width, size.height);
    for (int wave = 0; wave <= wavesCount; wave++) {
      circle(
          canvas: canvas,
          rect: rect,
          wave: wave,
          value: animation!.value,
          length: wavesCount,
          minRadius: minRadius);
    }
  }

  void circle(
      {required Canvas canvas,
      required Rect rect,
      double? minRadius,
      required int wave,
      required double value,
      int? length}) {
    Color _color;
    double r;

    if (wave != 0) {
      double opecity = (1 - ((wave - 1) / length!) - value).clamp(0.0, 1.0);
      _color = color.withOpacity(opecity);
      r = minRadius! * (1 + ((wave * value))) * value;
      final Paint paint = Paint()..color = _color;
      canvas.drawCircle(rect.center, r, paint);
    }
  }

  @override
  bool shouldRepaint(AnimatedCircle oldDelegate) => true;
}
