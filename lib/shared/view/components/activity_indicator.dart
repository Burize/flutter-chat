import 'package:flutter/material.dart';

typedef void TOnChanged(bool value);

class ActivityIdicator extends StatelessWidget {
  final double diameter;
  final Color color;
  final double strokeWidth;

  ActivityIdicator({this.diameter = 12, this.color = Colors.black, this.strokeWidth = 2});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: diameter,
        height: diameter,
        child:
            CircularProgressIndicator(strokeWidth: strokeWidth, valueColor: new AlwaysStoppedAnimation<Color>(color)));
  }
}
