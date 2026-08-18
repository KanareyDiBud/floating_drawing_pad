import 'dart:ui';

import 'package:flutter/material.dart';

class OverlayPainter extends CustomPainter {
  final List<Offset?> points;

  OverlayPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
    ..color = Colors.grey.shade900
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 4;

    for (int i = 0; i < points.length - 1; i++ ) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      } else if (points[i] != null && points[i + 1] == null) {
        canvas.drawPoints(PointMode.points, [points[i]!], paint);
      }
    }

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {return true;}

}