import 'package:flutter/material.dart';
import 'dart:math' as math;

class AlgeriaFlag extends StatelessWidget {
  final double width;
  final double height;

  const AlgeriaFlag({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CustomPaint(
        painter: _AlgeriaFlagPainter(),
      ),
    );
  }
}

class _AlgeriaFlagPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Left Green Part
    paint.color = const Color(0xFF006633);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width / 2, size.height), paint);

    // Right White Part
    paint.color = Colors.white;
    canvas.drawRect(Rect.fromLTWH(size.width / 2, 0, size.width / 2, size.height), paint);

    // Red Color for Star and Crescent
    paint.color = const Color(0xFFD21034);

    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final outerRadius = size.height * 0.25;
    final innerRadius = size.height * 0.20;

    // Crescent
    Path crescentPath = Path();
    crescentPath.addOval(Rect.fromCircle(center: Offset(centerX, centerY), radius: outerRadius));
    
    // Create a hole for the crescent (shifted right)
    Path holePath = Path();
    // Shift slightly to the right to create the crescent shape
    holePath.addOval(Rect.fromCircle(center: Offset(centerX + (size.height * 0.05), centerY), radius: innerRadius));

    // Combine
    Path finalCrescent = Path.combine(PathOperation.difference, crescentPath, holePath);
    canvas.drawPath(finalCrescent, paint);

    // Star
    // Star center should be slightly inside the crescent opening
    final starCenter = Offset(centerX + (size.height * 0.12), centerY); 
    final starRadius = size.height * 0.15;
    Path starPath = _drawStar(starCenter.dx, starCenter.dy, 5, starRadius / 2, starRadius);
    
    // Rotate to point right? Usually points up. Algeriam flag star points up.
    // The star is usually centered on the "axis" of the crescent.
    // Let's draw it normally.
    canvas.drawPath(starPath, paint);
  }

  Path _drawStar(double cx, double cy, int spikes, double outerRadius, double innerRadius) {
    Path path = Path();
    double rot = math.pi / 2 * 3;
    double x = cx;
    double y = cy;
    double step = math.pi / spikes;

    path.moveTo(cx, cy - outerRadius);
    
    // Standard star algorithm
    for (int i = 0; i < spikes; i++) {
        x = cx + math.cos(rot) * outerRadius;
        y = cy + math.sin(rot) * outerRadius;
        path.lineTo(x, y);
        rot += step;

        x = cx + math.cos(rot) * innerRadius;
        y = cy + math.sin(rot) * innerRadius;
        path.lineTo(x, y);
        rot += step;
    }
    path.lineTo(cx, cy - outerRadius);
    path.close();
    return path;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
