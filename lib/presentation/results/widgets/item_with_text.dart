import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rao_academy/core/utli/loops_urls.dart';

class ItemWithText extends StatelessWidget {
  const ItemWithText(
      {Key? key, required this.title, required this.info, required this.icon})
      : super(key: key);
  final String title;
  final Widget info;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Icon(
              icon,
              size: 24.sp,
              color: LoopsColors.primaryColor,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 12.sp,
                color: LoopsColors.colorGrey,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
        if (title != 'Performance') SizedBox(width: 12.w),
        info,
      ],
    );
  }
}
