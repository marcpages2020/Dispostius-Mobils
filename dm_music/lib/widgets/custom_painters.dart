import 'package:flutter/material.dart';

class CustomPainterMainScreen extends CustomPainter {
  final Color primaryColor;
  final Color secondaryColor;
  final Color thirdColor;
  CustomPainterMainScreen(
      this.primaryColor, this.secondaryColor, this.thirdColor);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = new Paint()
      ..color = primaryColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path_0 = Path();
    path_0.moveTo(0, size.height);
    path_0.lineTo(size.width, size.height);
    path_0.lineTo(size.width, size.height * 0.48);
    path_0.lineTo(0, size.height * 0.47);
    path_0.lineTo(0, size.height);
    path_0.close();

    canvas.drawPath(path_0, paint_0);

    Paint paint_1 = new Paint()
      ..color = secondaryColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path_1 = Path();
    path_1.moveTo(0, 0);
    path_1.lineTo(size.width, 0);
    path_1.lineTo(size.width, size.height * 0.77);
    path_1.quadraticBezierTo(size.width * 0.71, size.height * 0.72,
        size.width * 0.63, size.height * 0.64);
    path_1.cubicTo(size.width * 0.53, size.height * 0.58, size.width * 0.44,
        size.height * 0.67, size.width * 0.27, size.height * 0.66);
    path_1.cubicTo(size.width * 0.13, size.height * 0.66, size.width * 0.01,
        size.height * 0.59, 0, size.height * 0.54);
    path_1.quadraticBezierTo(0, size.height * 0.41, 0, 0);
    path_1.close();

    canvas.drawPath(path_1, paint_1);

    Paint paint_2 = new Paint()
      ..color = thirdColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path_2 = Path();
    path_2.moveTo(0, 0);
    path_2.lineTo(size.width, 0);
    path_2.lineTo(size.width, size.height * 0.33);
    path_2.quadraticBezierTo(size.width * 0.80, size.height * 0.33,
        size.width * 0.63, size.height * 0.38);
    path_2.cubicTo(size.width * 0.52, size.height * 0.42, size.width * 0.53,
        size.height * 0.49, size.width * 0.37, size.height * 0.55);
    path_2.quadraticBezierTo(
        size.width * 0.18, size.height * 0.60, 0, size.height * 0.60);
    path_2.lineTo(0, 0);
    path_2.close();

    canvas.drawPath(path_2, paint_2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class CustomPainterSignInFlow extends CustomPainter {
  final Color primaryColor;
  final Color secondaryColor;
  final Color thirdColor;
  CustomPainterSignInFlow(
      this.primaryColor, this.secondaryColor, this.thirdColor);

  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    Paint paint_0 = new Paint()
      ..color = primaryColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.63);
    path_0.quadraticBezierTo(size.width * 0.10, size.height * 0.66,
        size.width * 0.20, size.height * 0.63);
    path_0.cubicTo(size.width * 0.32, size.height * 0.58, size.width * 0.23,
        size.height * 0.53, size.width * 0.41, size.height * 0.49);
    path_0.cubicTo(size.width * 0.63, size.height * 0.47, size.width * 0.61,
        size.height * 0.36, size.width * 0.81, size.height * 0.36);
    path_0.quadraticBezierTo(
        size.width * 0.93, size.height * 0.33, size.width, size.height * 0.25);
    path_0.lineTo(size.width, 0);
    path_0.lineTo(0, 0);

    canvas.drawPath(path_0, paint_0);

    Paint paint_1 = new Paint()
      ..color = secondaryColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path_1 = Path();
    path_1.moveTo(size.width, size.height * 0.60);
    path_1.quadraticBezierTo(size.width * 0.78, size.height * 0.61,
        size.width * 0.73, size.height * 0.58);
    path_1.cubicTo(size.width * 0.67, size.height * 0.56, size.width * 0.63,
        size.height * 0.51, size.width * 0.69, size.height * 0.46);
    path_1.cubicTo(size.width * 0.71, size.height * 0.41, size.width * 0.50,
        size.height * 0.39, size.width * 0.49, size.height * 0.35);
    path_1.cubicTo(size.width * 0.42, size.height * 0.29, size.width * 0.47,
        size.height * 0.23, size.width * 0.55, size.height * 0.19);
    path_1.cubicTo(size.width * 0.65, size.height * 0.16, size.width * 0.67,
        size.height * 0.18, size.width * 0.74, size.height * 0.14);
    path_1.cubicTo(size.width * 0.81, size.height * 0.11, size.width * 0.75,
        size.height * 0.07, size.width * 0.82, size.height * 0.03);
    path_1.quadraticBezierTo(
        size.width * 0.85, size.height * 0.01, size.width, 0);

    canvas.drawPath(path_1, paint_1);

    Paint paint_2 = new Paint()
      ..color = thirdColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path_2 = Path();
    path_2.moveTo(0, size.height * 0.52);
    path_2.quadraticBezierTo(size.width * 0.21, size.height * 0.51,
        size.width * 0.30, size.height * 0.47);
    path_2.cubicTo(size.width * 0.40, size.height * 0.44, size.width * 0.41,
        size.height * 0.34, size.width * 0.51, size.height * 0.31);
    path_2.cubicTo(size.width * 0.63, size.height * 0.27, size.width * 0.71,
        size.height * 0.30, size.width * 0.81, size.height * 0.27);
    path_2.cubicTo(size.width * 0.90, size.height * 0.25, size.width * 0.96,
        size.height * 0.22, size.width, size.height * 0.18);
    path_2.quadraticBezierTo(size.width, size.height * 0.14, size.width, 0);
    path_2.lineTo(0, 0);

    canvas.drawPath(path_2, paint_2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class CustomPainterProfile extends CustomPainter {
  final Color primaryColor;
  final Color secondaryColor;
  final Color thirdColor;
  final Color fourColor;
  CustomPainterProfile(
      this.primaryColor, this.secondaryColor, this.thirdColor, this.fourColor);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = new Paint()
      ..color = primaryColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.53);
    path_0.lineTo(size.width, size.height * 0.54);
    path_0.lineTo(size.width, size.height);
    path_0.lineTo(0, size.height);
    path_0.lineTo(0, size.height * 0.53);
    path_0.close();

    canvas.drawPath(path_0, paint_0);

    Paint paint_1 = new Paint()
      ..color = secondaryColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path_1 = Path();
    path_1.moveTo(0, size.height * 0.00);
    path_1.lineTo(0, size.height * 0.82);
    path_1.quadraticBezierTo(size.width * 0.12, size.height * 0.78,
        size.width * 0.19, size.height * 0.73);
    path_1.cubicTo(size.width * 0.26, size.height * 0.70, size.width * 0.19,
        size.height * 0.65, size.width * 0.27, size.height * 0.62);
    path_1.cubicTo(size.width * 0.37, size.height * 0.60, size.width * 0.41,
        size.height * 0.64, size.width * 0.53, size.height * 0.64);
    path_1.cubicTo(size.width * 0.68, size.height * 0.63, size.width * 0.70,
        size.height * 0.53, size.width * 0.82, size.height * 0.56);
    path_1.cubicTo(size.width * 0.90, size.height * 0.59, size.width * 0.89,
        size.height * 0.65, size.width * 0.83, size.height * 0.68);
    path_1.cubicTo(size.width * 0.74, size.height * 0.70, size.width * 0.72,
        size.height * 0.74, size.width * 0.73, size.height * 0.78);
    path_1.quadraticBezierTo(
        size.width * 0.75, size.height * 0.83, size.width, size.height * 0.87);
    path_1.lineTo(size.width, 0);

    canvas.drawPath(path_1, paint_1);

    Paint paint_2 = new Paint()
      ..color = thirdColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path_2 = Path();
    path_2.moveTo(0, size.height * 0.36);
    path_2.quadraticBezierTo(size.width * -0.03, size.height * 0.48,
        size.width * 0.08, size.height * 0.50);
    path_2.cubicTo(size.width * 0.22, size.height * 0.53, size.width * 0.36,
        size.height * 0.58, size.width * 0.49, size.height * 0.57);
    path_2.cubicTo(size.width * 0.61, size.height * 0.57, size.width * 0.67,
        size.height * 0.32, size.width * 0.79, size.height * 0.31);
    path_2.quadraticBezierTo(
        size.width * 0.98, size.height * 0.30, size.width, size.height * 0.38);
    path_2.lineTo(size.width, 0);
    path_2.lineTo(0, 0);
    path_2.lineTo(0, size.height * 0.36);
    path_2.close();

    canvas.drawPath(path_2, paint_2);

    Paint paint_3 = new Paint()
      ..color = fourColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path_3 = Path();
    path_3.moveTo(0, size.height * 0.38);
    path_3.quadraticBezierTo(size.width * 0.31, size.height * 0.48,
        size.width * 0.42, size.height * 0.46);
    path_3.cubicTo(size.width * 0.54, size.height * 0.44, size.width * 0.55,
        size.height * 0.33, size.width * 0.50, size.height * 0.28);
    path_3.cubicTo(size.width * 0.48, size.height * 0.24, size.width * 0.24,
        size.height * 0.23, size.width * 0.27, size.height * 0.18);
    path_3.cubicTo(size.width * 0.27, size.height * 0.12, size.width * 0.57,
        size.height * 0.10, size.width * 0.64, size.height * 0.13);
    path_3.cubicTo(size.width * 0.73, size.height * 0.17, size.width * 0.62,
        size.height * 0.29, size.width * 0.70, size.height * 0.33);
    path_3.cubicTo(size.width * 0.75, size.height * 0.36, size.width * 0.90,
        size.height * 0.43, size.width, size.height * 0.39);
    path_3.quadraticBezierTo(size.width, size.height * 0.29, size.width, 0);
    path_3.lineTo(0, 0);

    canvas.drawPath(path_3, paint_3);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
