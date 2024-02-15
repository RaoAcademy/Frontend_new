import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:EdTestz/core/utli/custom_progress.dart';
import 'package:EdTestz/core/utli/loops_urls.dart';

class BarGraph extends StatelessWidget {
  const BarGraph({
    Key? key,
    required this.keyValueMap,
    this.colors,
    this.bgColors,
    this.bgColor,
    this.showValue = false,
    this.padding,
    this.margin,
    this.height,
    this.maxlableWidth = 60,
    this.maxProgressLength,
    this.text,
  }) : super(key: key);
  final Map<String, num> keyValueMap;
  final List<Color>? colors;
  final List<Color>? bgColors;
  final Color? bgColor;
  final bool showValue;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final num? height;
  final num? maxlableWidth;
  final num? maxProgressLength;
  final String? text;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height?.toDouble(),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (int i = 0; i < keyValueMap.length; i++)
                Container(
                  padding: padding,
                  margin: margin,
                  child: Row(
                    children: [
                      Container(
                        width: maxlableWidth?.toDouble() ?? 40.w,
                        padding: EdgeInsets.only(right: 4.w),
                        constraints: BoxConstraints(
                          minWidth: maxlableWidth?.toDouble() ?? 40.w,
                        ),
                        child: Text(
                          keyValueMap.keys.toList()[i],
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.right,
                          maxLines: 4,
                        ),
                      ),
                      Expanded(
                        child: ProgressBar(
                          max: maxProgressLength?.toDouble() ?? 1,
                          showValueAtTheEnd: showValue,

                          color: colors?[i] ??
                              LoopsColors.textColor.withOpacity(0.5),
                          bgColor: bgColors?[i] ??
                              bgColor ??
                              LoopsColors.textColor.withOpacity(0),
                          value: keyValueMap.values.toList()[i] /100,
                        ),
                      ),
                    ],
                  ),
                )
            ],
          ),
          Positioned(
            left: maxlableWidth != null ? maxlableWidth! + 8.w : 48.w,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 24.h),
              width: 1.sp,
              color: LoopsColors.lightGrey,
              height: (keyValueMap.length * 90).h,
            ),
          ),
          if (text != null)
            Positioned(
                bottom: 6.h,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 14.sp,
                    ),
                    Text(text ?? ''),
                  ],
                ))
        ],
      ),
    );
  }
}
