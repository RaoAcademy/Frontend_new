import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:EdTestz/core/theme/theme.dart';
// import 'package:EdTestz/core/widgets/container_with_border.dart';

Widget whitePopUp({
  required Widget icon,
  required Widget items,
  required BuildContext context,
}) {
  return PopupMenuButton(
    /* shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(
          10.sp,
        ),
      ),
    ), */
    itemBuilder: (context) {
      final List<PopupMenuItem> listItems = [
        PopupMenuItem(child: items),
      ];
      return listItems;
    },
    child: icon,
  );
}
