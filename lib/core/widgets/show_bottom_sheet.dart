import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rao_academy/core/theme/custom_scroll_behaviour.dart';
import 'package:rao_academy/core/utli/loops_urls.dart';

Future loopsBottomSheet(BuildContext context, Widget child, String title) {
  return showModalBottomSheet(
    enableDrag: true,
    context: context,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12.sp))),
    backgroundColor: LoopsColors.colorWhite,
    builder: (context) => ScrollConfiguration(
      behavior: MyBehavior(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.sp,
              vertical: 15.sp,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Icon(
                    Icons.close_sharp,
                    size: 24.sp,
                    color: LoopsColors.tertiaryColor,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: child,
          )
        ],
      ),
    ),
  );
}
