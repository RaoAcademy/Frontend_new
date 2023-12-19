import 'package:flutter/material.dart';
import 'package:rao_academy/core/widgets/arc.dart';

class SemiCircleWithRCorner extends StatelessWidget {
  const SemiCircleWithRCorner({
    Key? key,
    required this.radius,
    required this.angle,
    required this.color,
  }) : super(key: key);
  final double radius;
  final double angle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Transform.rotate(
          alignment: FractionalOffset.center,
          angle: angle / 57.2958,
          child: MyArc(
            diameter: radius * 2,
            color: color,
          ) /* ContainerWithBorder(
          alignment: Alignment.center,
          height: radius,
          width: radius * 2,
          boxColor: Colors.transparent,
          // boxColor: LoopsColors.lightGrey,
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(1000.sp),
                topRight: Radius.circular(1000.sp),
                bottomLeft: Radius.circular(60.sp),
                bottomRight: Radius.circular(60.sp),
              ),
            ),
          ),
        ), */
          ),
    );
  }
}
