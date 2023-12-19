import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rao_academy/core/utli/loops_urls.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    this.onTapDown,
    this.onTapCancel,
    // this.onHighlightChanged,
    // this.onHover,
    // this.mouseCursor,
    this.lable,
    this.child,
    this.width,
    this.height,
    this.color,
    this.topCornor = true,
    this.roundButton = false,
    this.lableColor,
  }) : super(key: key);
  final GestureTapCallback? onTap;
  final GestureTapCallback? onDoubleTap;
  final GestureLongPressCallback? onLongPress;
  final GestureTapDownCallback? onTapDown;
  final GestureTapCancelCallback? onTapCancel;
  // final ValueChanged<bool>? onHighlightChanged;
  // final ValueChanged<bool>? onHover;
  // final MouseCursor? mouseCursor;
  final String? lable;
  final Widget? child;
  final num? width;
  final num? height;
  final Color? color;
  final bool? topCornor;
  final bool? roundButton;
  final Color? lableColor;

  @override
  Widget build(BuildContext context) {
    if (lable == null && child == null) {
      throw 'Either child or lable is required';
    }
    if (lable != null && child != null) {
      throw 'You can not add both child and lable, try removing one.';
    }
    return GestureDetector(
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      onTapDown: onTapDown,
      onTapCancel: onTapCancel,
      // onHighlightChanged: onHighlightChanged,
      // onHover: onHover,
      // mouseCursor: mouseCursor,
      child: Container(
        width: width?.toDouble() ?? MediaQuery.of(context).size.width,
        height: height?.toDouble() ?? 55,
        decoration: BoxDecoration(
          color: color ?? LoopsColors.tertiaryColor,
          borderRadius: roundButton!
              ? BorderRadius.circular(1000)
              : topCornor!
                  ? BorderRadius.circular(10.0)
                  : const BorderRadius.only(
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0)),
          border: Border.all(color: color ?? Colors.transparent),
        ),
        child: Center(
          child: lable != null
              ? Text(
                  lable!,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: lableColor ?? LoopsColors.primaryColor,
                    letterSpacing: 1.sp,
                  ),
                  textAlign: TextAlign.center,
                )
              : child,
        ),
      ),
    );
  }
}
