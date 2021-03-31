import 'dart:math' as math;

import 'package:flutter/cupertino.dart';

class PolarPoint {
  double theta;
  double radius;

  PolarPoint({this.theta, this.radius});
}

class Helper {
  //https://stackoverflow.com/questions/54444944/convert-html-canvas-coordinate-system-to-cartesian-system
  static Offset canvas2Cartesian(Offset pos, Offset center) {
    return Offset(pos.dx - center.dx, -1 * (pos.dy - center.dy));
  }

  static Offset cartesian2Canvas(Offset pos, Offset center) {
    return Offset(pos.dx + center.dx, -1 * pos.dy + center.dy);
  }

  static Offset polar2Cartesian(PolarPoint p) {
    return Offset(p.radius * math.cos(p.theta), p.radius * math.sin(p.theta));
  }

  static PolarPoint cartesian2Polar(Offset pos) {
    return PolarPoint(
        theta: math.atan2(pos.dy, pos.dx),
        radius: math.sqrt(math.pow(pos.dx, 2) + math.pow(pos.dy, 2)));
  }

  static Offset polar2Canvas(PolarPoint p, Offset center) {
    return cartesian2Canvas(polar2Cartesian(p), center);
  }

  static PolarPoint canvas2Polar(Offset pos, Offset center) {
    return cartesian2Polar(canvas2Cartesian(pos, center));
  }

  static bool containedInSquare(Offset value, Offset center, double side) {
    Offset topLeft = Offset(center.dx - side / 2, center.dy - side / 2);
    return value.dx >= topLeft.dx &&
        value.dy >= topLeft.dy &&
        value.dx <= topLeft.dx + side &&
        value.dy <= topLeft.dy + side;
  }
  static double normalize(double value)
  {
    double rest=value%(2*math.pi);
    return rest>0?rest:(2*math.pi)+rest;
  }
  static double absoluteDuration(double start,double end)
  {
    return start > end ? end+2*math.pi-start : end - start;
  }
  static bool checkInsideArc(double theta,double start,double end)
  {

    if(end>start)
      {
        return theta>=start && theta<=end;
      }
    else
      {
        return theta>=start || theta<=end;
      }
  }

  static double radToMinutes(double rad) {

    return (24 * 60 * rad) / (2 *math.pi);
  }
  static double degreesToRad(double degrees)
  {
    return degrees*(math.pi/180);
  }
  static String formatDuration(double value)
  {
    int duration=value.round();

    int minutes = duration % 60;
    double hours = (duration - minutes) / 60;
    return pad(hours.round()) +":"+pad(minutes.round());
  }
  static String formatDuration2(double value)
  {
    int duration=value.round();

    int minutes = duration % 60;
    double hours = (duration - minutes) / 60;
    return hours.round().toString()+" hr:"+minutes.toString()+" min";
  }
  static String pad(int n) {
    return (n < 10) ? ("0" + n.toString()) : n.toString();
  }
}
