import 'package:flutter/material.dart';

class HorizontalDashedBorderPainter extends CustomPainter {
  final double dashWidth;
  final double dashSpace;
  final Color color;
  final double borderThickness;

  HorizontalDashedBorderPainter({
    required this.dashWidth,
    required this.dashSpace,
    required this.color,
    required this.borderThickness,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = borderThickness
      ..style = PaintingStyle.stroke;

    double startX = 0;
    double startY = 0;

    _drawDashedLine(
        canvas, paint, Offset(startX, startY), Offset(size.width, startY));
  }

  void _drawDashedLine(Canvas canvas, Paint paint, Offset start, Offset end) {
    final dashPath = Path();
    double distance = (end - start).distance;
    double dashCount = (distance / (dashWidth + dashSpace)).floorToDouble();

    for (int i = 0; i < dashCount; i++) {
      double dx = start.dx + (i * (dashWidth + dashSpace));
      double dy = start.dy;
      dashPath.moveTo(dx, dy);
      dashPath.lineTo(
        dx + dashWidth,
        dy,
      );
    }

    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class DashedBorder extends StatelessWidget {
  final Widget child;
  final double dashWidth;
  final double dashSpace;
  final Color borderColor;
  final double borderThickness; // Added border thickness

  const DashedBorder({
    super.key,
    required this.child,
    this.dashWidth = 8.0,
    this.dashSpace = 4.0,
    this.borderColor = Colors.black,
    this.borderThickness = 2.0, // Default border thickness
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: HorizontalDashedBorderPainter(
        dashWidth: dashWidth,
        dashSpace: dashSpace,
        color: borderColor,
        borderThickness: borderThickness, // Pass the border thickness here
      ),
      child: child,
    );
  }
}
