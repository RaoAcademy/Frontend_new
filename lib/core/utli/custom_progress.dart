import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rao_academy/core/utli/loops_urls.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    Key? key,
    this.max = 1,
    required this.value,
    this.showValueAtTheEnd = false,
    this.color,
    this.bgColor = Colors.transparent,
    this.gradient,
  }) : super(key: key);
  final double max;
  final double value;
  final bool showValueAtTheEnd;
  final Color? color;
  final Color bgColor;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, boxConstraints) {
        final x = boxConstraints.maxWidth;
        final percent = (value / max) * x;
        return Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 4.h, bottom: 4.h),
                child: Stack(
                  children: [
                    Container(
                      width: x,
                      height: 7.h,
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(35),
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      width: percent,
                      height: 7.h,
                      decoration: BoxDecoration(
                        color: color ?? LoopsColors.secondaryColor,
                        borderRadius: BorderRadius.circular(35),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // if (showValueAtTheEnd)
            Column(
              children: [
                SizedBox(
                  height: 1.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 4.w),
                  child: Text(
                    '${(value * 100).toStringAsFixed(0)}s',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: LoopsColors.colorBlack,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class CustomProgressBar extends StatelessWidget {
  const CustomProgressBar({
    Key? key,
    this.max = 1,
    required this.value,
    this.showValueAtTheEnd = false,
    this.color,
    this.bgColor = Colors.transparent,
    this.gradient,
  }) : super(key: key);
  final double max;
  final double value;
  final bool showValueAtTheEnd;
  final Color? color;
  final Color bgColor;
  final LinearGradient? gradient;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, boxConstraints) {
        // final x = boxConstraints.maxWidth;
        final percent = (value / max) * MediaQuery.of(context).size.width / 1.8;
        return Row(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 4.h, bottom: 4.h),
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 1.8,
                    height: 7.h,
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(35),
                    ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    width: percent,
                    height: 7.h,
                    decoration: BoxDecoration(
                      color: color ?? LoopsColors.secondaryColor,
                      borderRadius: BorderRadius.circular(35),
                      gradient: gradient,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
