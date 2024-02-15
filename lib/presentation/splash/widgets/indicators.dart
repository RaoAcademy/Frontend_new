import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:EdTestz/core/utli/loops_urls.dart';
import 'package:EdTestz/core/widgets/container_with_border.dart';

class Indicators extends StatelessWidget {
  const Indicators({Key? key, required this.count, required this.activeIndex})
      : super(key: key);
  final int count;
  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (var i = 0; i < count; i++)
            ContainerWithBorder(
              height: 6.sp,
              width: 6.sp,
              borderRadius: 10.sp,
              boxColor: i == activeIndex
                  ? LoopsColors.colorWhite
                  : LoopsColors.colorGrey.withOpacity(0.4),
            )
        ],
      ),
    );
  }
}
