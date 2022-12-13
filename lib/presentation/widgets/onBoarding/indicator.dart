// ignore_for_file: prefer_typing_uninitialized_variables, library_private_types_in_public_api
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:nftickets/utils/theme.dart';

class Indicator extends StatefulWidget {
  const Indicator({Key? key, this.size, this.progressValue}) : super(key: key);
  final size, progressValue;
  @override
  _IndicatorState createState() => _IndicatorState();
}

class _IndicatorState extends State<Indicator> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        size: Size(widget.size, widget.size),
        painter: ProgressPainter(widget.progressValue));
  }
}

class ProgressPainter extends CustomPainter {
  ProgressPainter(this.progress);
  final progress;

  @override
  void paint(Canvas canvas, Size size) {
    var linePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = AppColors.klightPurple;
    var circlePaint = Paint()
      ..style = PaintingStyle.fill
      ..color = AppColors.klightPurple;
    final radians = (progress / 100) * 2 * pi;
    _drawShape(canvas, linePaint, circlePaint, -pi / 2, radians, size);
  }

  void _drawShape(
      canvas, linePaint, circlePaint, startRadian, sweepRadian, size) {
    final centerX = size.width / 2, centerY = size.height / 2;
    final centerOffset = Offset(centerX, centerY);
    final double radius = min(size.width, size.height);

    canvas.drawArc(Rect.fromCircle(center: centerOffset, radius: radius / 2),
        startRadian, sweepRadian, false, linePaint);

    final x = (radius / 2) * (1 + sin(sweepRadian)),
        y = (radius / 2) * (1 - cos(sweepRadian));
    final circleOffset = Offset(x, y);
    if (progress != 0) {
      canvas.drawCircle(circleOffset, 5.0, circlePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
