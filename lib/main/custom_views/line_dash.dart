import 'package:flutter/material.dart';

class LineDash extends StatelessWidget {
  const LineDash({Key? key, this.height = 1, this.color = Colors.black, this.direction = Axis.horizontal})
      : super(key: key);
  final double height;
  final Color color;
  final direction;

  @override
  Widget build(BuildContext context) {
    double boxWidth;
    double dashWidth;
    double dashHeight;
    int dashCount;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if(direction == Axis.horizontal) {
          boxWidth = constraints.constrainWidth();
          dashWidth = 5.0;
          dashHeight = height;
          dashCount = (boxWidth / (2 * dashWidth)).floor();
        } else {
          boxWidth = constraints.constrainHeight();
          dashWidth = height;
          dashHeight = 5.0;
          dashCount = (boxWidth / (2 * dashWidth)).floor();
        }
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: direction,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}