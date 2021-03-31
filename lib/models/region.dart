import 'package:flutter/gestures.dart';

enum Status{
  NONE,
  START,
  END,
  MAIN
}

class Region{
  double offset;
  Status status;
  Region({this.offset,this.status});
}