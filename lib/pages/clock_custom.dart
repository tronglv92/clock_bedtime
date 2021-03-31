import 'dart:math' as math;


import 'package:clock_bedtime/helper/constant.dart';
import 'package:clock_bedtime/helper/helper.dart';
import 'package:flutter/material.dart';






class ClockCustom extends CustomPainter {
  final BuildContext context;
  final double start;
  final double end;
  ClockCustom({this.context,this.start,this.end});

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint

    // double SIZE=size.width-PADDING*2;
    // double R=size.width/2;
    //   Offset centerTest = Offset(SIZE / 2,SIZE / 2);


    Offset center = Offset(size.width / 2, size.width / 2);
    double radius = math.min(size.width / 2, size.width / 2) ;





    ///main
    Paint paintMain = Paint()
      ..color = Colors.orange.withOpacity(0.5)
      ..strokeWidth = Constant.STROKE
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;



    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -1 * start,
        -1 *  Helper.absoluteDuration(start, end), false, paintMain);



    double delta = 2 * math.pi / Constant.LINES;

    /// line circle
    Paint paintLine = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.red
      ..strokeWidth = 2;
    for (int i = 0; i < Constant.LINES; i++) {
      double theta = i * delta;

      if(Helper.checkInsideArc(theta, start, end)==true)
        {
          Offset p1 = Helper.polar2Canvas(
              PolarPoint(theta: theta, radius: radius+Constant.PADDING / 2), center);
          Offset p2 = Helper.polar2Canvas(
              PolarPoint(theta: theta, radius: radius-Constant.PADDING / 2), center);



          canvas.drawLine(p1, p2, paintLine);
        }

    }




    /// Indicator Circle bed
    // circle indicator
    Paint paintCircleIndicator = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;
    Offset bedPos =
    Helper.polar2Canvas(PolarPoint(theta: start, radius: radius), center);



    canvas.drawCircle(bedPos, Constant.STROKE/2, paintCircleIndicator);

    //icon bed
    final iconBed = Icons.king_bed;
    TextPainter textPainterBed = TextPainter(textDirection: TextDirection.rtl);
    textPainterBed.text = TextSpan(
        text: String.fromCharCode(iconBed.codePoint),
        style: TextStyle(fontSize: Constant.ICON_SIZE, fontFamily: iconBed.fontFamily));
    textPainterBed.layout();
    Offset offsetIconBed =
    Offset(bedPos.dx - Constant.ICON_SIZE / 2, bedPos.dy - Constant.ICON_SIZE / 2);
    textPainterBed.paint(canvas, offsetIconBed);

    /// Indicator Circle Alarm
    //circle alarm
    Offset alarmPos =
    Helper.polar2Canvas(PolarPoint(theta: end, radius: radius), center);
    canvas.drawCircle(alarmPos, Constant.STROKE/2, paintCircleIndicator);

    //icon alarm
    final iconAlarm = Icons.alarm;
    TextPainter textPainterAlarm =
    TextPainter(textDirection: TextDirection.rtl);
    textPainterAlarm.text = TextSpan(
        text: String.fromCharCode(iconAlarm.codePoint),
        style:
        TextStyle(fontSize: Constant.ICON_SIZE, fontFamily: iconAlarm.fontFamily));
    textPainterAlarm.layout();
    Offset offsetAlarm =
    Offset(alarmPos.dx - Constant.ICON_SIZE / 2, alarmPos.dy - Constant.ICON_SIZE / 2);
    textPainterAlarm.paint(canvas, offsetAlarm);


  }

  double toRadius(int degree) {
    return (math.pi * degree) / 180;
  }

  @override
  bool shouldRepaint(ClockCustom oldDelegate) {
    // TODO: implement shouldRepaint
    return start!=oldDelegate.start || end!=oldDelegate.end ;
  }
}
