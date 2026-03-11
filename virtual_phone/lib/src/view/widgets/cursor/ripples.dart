import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:math' as math show sqrt;

class Ripples extends StatefulWidget {
  const Ripples({
    super.key,
    this.size = 80.0,
    this.color = Colors.blue,
  });

  final double size;
  final Color color;

  @override
  RipplesState createState() => RipplesState();
}

class RipplesState extends State<Ripples> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _paintCircle(
    Canvas canvas,
    Rect rect,
    double value,
    Color color,
  ) {
    final opacity = (1.0 - (value / 4.0)).clamp(0.0, 1.0);
    final colorWithOpacity = color.withOpacity(opacity);
    final size = rect.width / 2;
    final area = size * size;
    final radius = math.sqrt(area * value / 4);
    final paint = Paint()..color = colorWithOpacity;
    canvas.drawCircle(rect.center, radius, paint);
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CirclePainter(
        _controller,
        color: widget.color,
        paintCircle: _paintCircle,
      ),
      child: SizedBox(
        width: widget.size * 2.125,
        height: widget.size * 2.125,
      ),
    );
  }
}

class _CirclePainter extends CustomPainter {
  _CirclePainter(
    this._animation, {
    required this.color,
    required this.paintCircle,
  }) : super(repaint: _animation);

  final Color color;
  final Animation<double> _animation;
  final Function(Canvas, Rect, double, Color) paintCircle;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromLTRB(0.0, 0.0, size.width, size.height);

    for (int wave = 3; wave >= 0; wave--) {
      paintCircle(canvas, rect, wave + _animation.value, color);
    }
  }

  @override
  bool shouldRepaint(_CirclePainter oldDelegate) => true;
}
