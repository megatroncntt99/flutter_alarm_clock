import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ClockView extends StatelessWidget {
  const ClockView({
    Key key,
    this.size = 250,
    @required this.dateTime,
  }) : super(key: key);
  final double size;
  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      child: Transform.rotate(
        angle: -pi / 2,
        child: CustomPaint(
          painter: ClockPainter(context, dateTime),
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  final BuildContext context;
  final DateTime dateTime;

  ClockPainter(this.context, this.dateTime);
  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final center = Offset(centerX, centerY);

    final radius = min(centerX, centerY);

    final fillBrush = Paint()..color = Color(0xFF444974);
    final dashBrush = Paint()
      ..color = Color(0xFFEAECFF)
      ..strokeWidth = 2;

    final outLineBrush = Paint()
      ..color = Color(0xFFEAECFF)
      ..strokeWidth = size.width / 20
      ..style = PaintingStyle.stroke;
    final centerFillBrush = Paint()..color = Color(0xFFEAECFF);

    final secHandBrush = Paint()
      ..color = Colors.orange[300]
      ..strokeWidth = size.width / 60
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final minHandBrush = Paint()
      ..shader = RadialGradient(colors: [Color(0xFF748EF6), Color(0xFF77DDFF)])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..strokeWidth = size.width / 30
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final hourHandBrush = Paint()
      ..shader = RadialGradient(colors: [Color(0xFFEA74AB), Color(0xFFC279FB)])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..strokeWidth = size.width / 24
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, radius * 0.75, fillBrush);

    canvas.drawCircle(center, radius * 0.75, outLineBrush);

    double hourHandX =
        centerX + radius * 0.4 * cos(dateTime.hour * 30 * pi / 180);
    double hourHandY =
        centerX + radius * 0.4 * sin(dateTime.hour * 30 * pi / 180);
    canvas.drawLine(center, Offset(hourHandX, hourHandY), hourHandBrush);

    double minHandX =
        centerX + radius * 0.55 * cos(dateTime.minute * 6 * pi / 180);
    double minHandY =
        centerX + radius * 0.55 * sin(dateTime.minute * 6 * pi / 180);
    canvas.drawLine(center, Offset(minHandX, minHandY), minHandBrush);

    double secHandX =
        centerX + radius * 0.6 * cos(dateTime.second * 6 * pi / 180);
    double secHandY =
        centerX + radius * 0.6 * sin(dateTime.second * 6 * pi / 180);
    canvas.drawLine(center, Offset(secHandX, secHandY), secHandBrush);

    canvas.drawCircle(center, radius * 0.12, centerFillBrush);

    var outerCircleRadius = radius;
    var innerCircleRadius = radius * 0.9;

    for (int i = 0; i <= 360; i += 12) {
      final x1 = centerX + outerCircleRadius * cos(i * pi / 180);
      final y1 = centerX + outerCircleRadius * sin(i * pi / 180);

      final x2 = centerX + innerCircleRadius * cos(i * pi / 180);
      final y2 = centerX + innerCircleRadius * sin(i * pi / 180);

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
    }
  }

  @override
  bool shouldRepaint(ClockPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(ClockPainter oldDelegate) => true;
}
