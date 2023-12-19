import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rao_academy/core/utli/loops_urls.dart';

Widget showExpandablePanelWC(String headerText, Widget child) {
  // final ExpandableController _controller = ExpandableController();
  return DecoratedBox(
    decoration: BoxDecoration(
      color: LoopsColors.colorWhite.withOpacity(0.3),
      border: Border.all(
        width: 1.sp,
        color: LoopsColors.colorWhite,
      ),
      borderRadius: BorderRadius.all(Radius.circular(10.sp)),
    ),
    child: ExpandableNotifier(
      initialExpanded: false,
      child: ScrollOnExpand(
        child: ExpandablePanel(
          theme: const ExpandableThemeData(
            hasIcon: false,
            tapHeaderToExpand: true,
            tapBodyToCollapse: false,
            tapBodyToExpand: true,
          ),
          header: Builder(builder: (context) {
            final controller =
                ExpandableController.of(context, required: true)!;

            return Padding(
              padding: EdgeInsets.only(right: 1.w, top: 10.h, bottom: 2.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      headerText,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: LoopsColors.textColor,
                      ),
                    ),
                  ),
                  Icon(
                    controller.expanded
                        ? Icons.arrow_drop_down
                        : Icons.arrow_right,
                    size: 24.sp,
                    color: LoopsColors.textColor,
                  ),
                ],
              ),
            );
          }),
          collapsed: Container(),
          expanded: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            decoration: BoxDecoration(
              color: LoopsColors.whiteBkground,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.sp),
                  bottomRight: Radius.circular(10.sp)),
            ),
            child: child,
          ),
        ),
      ),
    ),
  );
}
