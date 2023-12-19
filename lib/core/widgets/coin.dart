import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rao_academy/core/utli/loops_urls.dart';
import 'package:rao_academy/core/widgets/container_with_border.dart';

class Coin extends StatelessWidget {
  const Coin({Key? key, required this.coinSize}) : super(key: key);
  final double coinSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ContainerWithBorder(
          height: coinSize,
          width: coinSize,
          borderColor: LoopsColors.secondaryColor,
          borderWidth: 2.sp,
          borderRadius: coinSize * 2,
          boxColor: Colors.transparent,
          child: ContainerWithBorder(
            height: coinSize - 7.sp,
            width: coinSize - 7.sp,
            borderColor: LoopsColors.secondaryColor,
            borderWidth: 1.sp,
            borderRadius: coinSize * 2,
            boxColor: Colors.transparent,
            child: Center(
              child: Text(
                r'$',
                style: TextStyle(
                  fontSize: coinSize / 2,
                  color: LoopsColors.tertiaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 3.h,
        )
      ],
    );
  }
}
