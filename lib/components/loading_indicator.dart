import 'package:flutter/material.dart';

class CircularProgressIndicatorWidget extends StatelessWidget {
  CircularProgressIndicatorWidget({this.height = 40, this.color = Colors.blue});

  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: 16,
      ),
      height: height,
      alignment: Alignment.center,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          color,
        ),
      ),
    );
  }
}
