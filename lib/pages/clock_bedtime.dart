import 'package:clock_bedtime/helper/constant.dart';
import 'package:clock_bedtime/helper/helper.dart';
import 'package:clock_bedtime/models/region.dart';
import 'package:clock_bedtime/pages/inside_clock.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'clock_custom.dart';
import 'column_time.dart';

const double SIZE = 200;

class ClockBedtime extends StatefulWidget {
  @override
  _ClockBedtimeState createState() => _ClockBedtimeState();
}

class _ClockBedtimeState extends State<ClockBedtime> {
  double start = 0;
  double end = math.pi / 2;

  Region region = Region(offset: null, status: Status.NONE);
  final keyParent = GlobalKey();
  final keyChild=GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double duration = Helper.absoluteDuration(start, end);
    String durationName=  Helper.formatDuration2(Helper.radToMinutes(duration));
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromRGBO(47, 44, 50, 1)),
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          renderColumnTime(),
          SizedBox(
            height: 30,
          ),
          renderClock(),
          Text(
            durationName,
            style: TextStyle(
                fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget renderClock() {

    return GestureDetector(
      onPanDown: (DragDownDetails startDrag) {
        Offset center = Offset(SIZE / 2, SIZE / 2);
        double radius = math.min(SIZE / 2, SIZE / 2);
        Offset bedPos = Helper.polar2Canvas(
            PolarPoint(theta: start, radius: radius), center);
        Offset alarmPos =
            Helper.polar2Canvas(PolarPoint(theta: end, radius: radius), center);

        RenderBox renderChild = keyChild.currentContext.findRenderObject();
        RenderBox renderParent = keyParent.currentContext.findRenderObject();
        Offset bedPosGlobal= renderChild.localToGlobal(bedPos);
        Offset bedPosLocal=renderParent.globalToLocal(bedPosGlobal);

        Offset alarmPosGlobal= renderChild.localToGlobal(alarmPos);
        Offset alarmPosLocal=renderParent.globalToLocal(alarmPosGlobal);

        if (Helper.containedInSquare(
                startDrag.localPosition, bedPosLocal, Constant.STROKE) ==
            true) {
          region.status = Status.START;
          region.offset = start;
          print("onPanDown start ");
        } else if (Helper.containedInSquare(
                startDrag.localPosition, alarmPosLocal, Constant.STROKE) ==
            true) {
          region.status = Status.END;
          region.offset = end;
          print("onPanDown end ");
        } else {
          region.status = Status.MAIN;
          region.offset =
              Helper.canvas2Polar(startDrag.localPosition, center).theta;
          print("onPanDown main ");
        }
      },
      onPanUpdate: (DragUpdateDetails updateDrag) {
        Offset center = Offset((SIZE+50) / 2, (SIZE+50) / 2);
        double theta=Helper.canvas2Polar(updateDrag.localPosition, center).theta;

        double delta = theta - region.offset;
        setState(() {
          if (region.status == Status.START || region.status == Status.MAIN) {
            start = Helper.normalize(start + delta);
          }
          if (region.status == Status.END || region.status == Status.MAIN) {
            end =  Helper.normalize(end + delta);
          }

          region.offset = theta;
        });
      },
      onPanEnd: (DragEndDetails endDrag) {
        region = Region(offset: null, status: Status.NONE);
      },
      child: Container(
        height: SIZE+Constant.STROKE,
        width: SIZE+Constant.STROKE,
        key: keyParent,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular((SIZE+Constant.STROKE)/2),
            color: Colors.black),
        child: Center(
          child: Container(
            height: SIZE,
            width: SIZE,
            key: keyChild,

            child: CustomPaint(
              painter: ClockCustom(context: context, start: start, end: end),
              child: Center(
                child: Container(
                  height: SIZE-Constant.STROKE,
                  width: SIZE-Constant.STROKE,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular((SIZE-Constant.STROKE) / 2),
                    
                    color: Color.fromRGBO(47, 44, 50, 1),

                  ),
                  child: CustomPaint(
                    painter: InsideClock(),
                  ),

                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget renderColumnTime() {

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ColumnTime(
          label: "BEDTIME",
          icon: Icons.king_bed,
          time: Helper.formatDuration(Helper.radToMinutes(start)),
          day: "Tomorrow",
        ),
        SizedBox(
          width: 50,
        ),
        ColumnTime(
          label: "WAKE UP",
          icon: Icons.alarm,
          time: Helper.formatDuration(Helper.radToMinutes(end)),
          day: "Tomorrow",
        ),
      ],
    );
  }
}
