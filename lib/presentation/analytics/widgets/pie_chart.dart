// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rao_academy/core/utli/loops_urls.dart';
import 'package:rao_academy/core/widgets/container_with_border.dart';
import 'package:rao_academy/core/widgets/pie_chart.dart';

class PieChartWithImage extends StatelessWidget {
  const PieChartWithImage({
    Key? key,
    required this.values,
    required this.colors,
  }) : super(key: key);
  final List<double> values;
  final List<Color> colors;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /*  Positioned(
                                    top: 0,
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Center(
                                      child: ContainerWithBorder(
                                        height: 160.sp,
                                        width: 160.sp,
                                        borderRadius: 120.sp,
                                        boxShadow: [BoxShadow(blurRadius: 80.sp)],
                                      ),
                                    ),
                                  ), */
        Center(
          child: Transform.scale(
            scaleY: -1,
            child: Transform(
              transform: Matrix4.rotationZ(90 / 57.2958),
              alignment: FractionalOffset.center,
              child: SizedBox(
                // color: LoopsColors.lightGrey,
                height: 260.sp,
                width: 260.sp,
                child: PieChart(
                  valueList: values,
                  colors: colors,
                  height: 80.sp,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          right: 0,
          child: Center(
            child: ContainerWithBorder(
              boxShadow: [
                BoxShadow(blurRadius: 12.sp, color: LoopsColors.lightGrey)
              ],
              boxColor: LoopsColors.selectedColor,
              height: 60.sp,
              width: 60.sp,
              borderRadius: 120.sp,
              child: SvgPicture.asset(
                'assets/icons/logos/power.svg',
              ),
            ),
          ),
        )
      ],
    );
  }
}
