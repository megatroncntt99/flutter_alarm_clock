import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ClockView extends StatefulWidget {
  const ClockView({Key key}) : super(key: key);

  @override
  _ClockViewState createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {
  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      this.setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -pi / 2,
      child: Container(
        width: 300,
        height: 300,
        child: CustomPaint(
          painter: ClockPainter(),
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  var dateTime = DateTime.now();
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
      ..strokeWidth = 16
      ..style = PaintingStyle.stroke;
    final centerFillBrush = Paint()..color = Color(0xFFEAECFF);

    final secHandBrush = Paint()
      ..color = Colors.orange[300]
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final minHandBrush = Paint()
      ..shader = RadialGradient(colors: [Color(0xFF748EF6), Color(0xFF77DDFF)])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final hourHandBrush = Paint()
      ..shader = RadialGradient(colors: [Color(0xFFEA74AB), Color(0xFFC279FB)])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..strokeWidth = 16
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, radius - 40, fillBrush);

    canvas.drawCircle(center, radius - 40, outLineBrush);

    double hourHandX = centerX + 60 * cos(dateTime.hour * 30 * pi / 180);
    double hourHandY = centerX + 60 * sin(dateTime.hour * 30 * pi / 180);
    canvas.drawLine(center, Offset(hourHandX, hourHandY), hourHandBrush);

    double minHandX = centerX + 70 * cos(dateTime.minute * 6 * pi / 180);
    double minHandY = centerX + 70 * sin(dateTime.minute * 6 * pi / 180);
    canvas.drawLine(center, Offset(minHandX, minHandY), minHandBrush);

    double secHandX = centerX + 80 * cos(dateTime.second * 6 * pi / 180);
    double secHandY = centerX + 80 * sin(dateTime.second * 6 * pi / 180);
    canvas.drawLine(center, Offset(secHandX, secHandY), secHandBrush);

    canvas.drawCircle(center, 15, centerFillBrush);

    var outerCircleRadius = radius;
    var innerCircleRadius = radius - 14;

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
