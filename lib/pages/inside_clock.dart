import 'package:clock_bedtime/helper/constant.dart';
import 'package:clock_bedtime/helper/helper.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class InsideClock extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Offset center = Offset(size.width / 2, size.width / 2);
    double radius = math.min(size.width / 2, size.width / 2);


    Paint paintLine = Paint()..color = Color.fromRGBO(100, 99, 103,1.0)..strokeWidth=2..style=PaintingStyle.stroke;
    for (int i = 0; i < 24; i++) {
      double theta = (i * Constant.TAU) / 24;
      Offset p1 = Helper.polar2Canvas(
          PolarPoint(theta: theta, radius: radius ), center);
      Offset p2 = Helper.polar2Canvas(
          PolarPoint(theta: theta, radius: radius -  Constant.PADDING), center);
      canvas.drawLine(p1, p2, paintLine);

      for(int j=0;j<4;j++)
        {
          double alpha = (i * Constant.TAU) / 24 + (j + 1) * (Constant.TAU / 24 / 4);
          Offset s = Helper.polar2Canvas(
              PolarPoint(theta: alpha, radius: radius ), center);
          Offset e = Helper.polar2Canvas(
              PolarPoint(theta: alpha, radius: radius -  Constant.PADDING/2), center);
          canvas.drawLine(s, e, paintLine);
        }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
