import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:EdTestz/core/utli/loops_urls.dart';

/// FILE NOT TO BE MODIFIED ////

ThemeData appTheme = ThemeData(
// Define the default brightness and colors.
    brightness: Brightness.light,
    primaryColor: LoopsColors.colorBlack,
    appBarTheme: AppBarTheme(
      backgroundColor: LoopsColors.whiteBkground,
      elevation: 0,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: LoopsColors.textColor,
      unselectedItemColor: LoopsColors.colorGrey,
      selectedLabelStyle: TextStyle(
          color: LoopsColors.colorWhite,
          fontWeight: FontWeight.w300,
          fontSize: 12),
      unselectedLabelStyle: TextStyle(
          color: LoopsColors.colorWhite,
          fontWeight: FontWeight.w300,
          fontSize: 12),
    ),
// Define the default font family.
    fontFamily: 'Hurme',
    scaffoldBackgroundColor: LoopsColors.whiteBkground,
    canvasColor: LoopsColors.whiteBkground,
    unselectedWidgetColor: LoopsColors.colorGrey,
    buttonTheme: ButtonThemeData(
      buttonColor: LoopsColors.secondaryColor,
      disabledColor: LoopsColors.colorGrey.withOpacity(0.2),
      splashColor: LoopsColors.secondaryColor.withOpacity(0.2),
      alignedDropdown: true,
    ),

// Define the default TextTheme. Use this to specify the default
// text styling for headlines, titles, bodies of text, and more.
    textTheme: TextTheme(
      displayLarge: TextStyle(
          fontSize: 48.sp,
          color: LoopsColors.textColor,
          fontWeight: FontWeight.w700,
          fontFamily: 'Hurme'),
      displayMedium: TextStyle(
          fontSize: 32.sp,
          color: LoopsColors.textColor,
          fontWeight: FontWeight.w600,
          fontFamily: 'Hurme'),
      displaySmall: TextStyle(
          fontSize: 22.sp,
          color: LoopsColors.textColor,
          fontWeight: FontWeight.w600,
          fontFamily: 'Hurme'),
      headlineMedium: TextStyle(
          fontSize: 20.sp,
          color: LoopsColors.textColor,
          fontWeight: FontWeight.w600,
          fontFamily: 'Hurme'),
      headlineSmall: TextStyle(
          fontSize: 18.sp,
          color: LoopsColors.textColor,
          fontWeight: FontWeight.w500,
          fontFamily: 'Hurme'),
      titleLarge: TextStyle(
          fontSize: 16.sp,
          color: LoopsColors.textColor,
          fontWeight: FontWeight.w600,
          fontFamily: 'Hurme'),
      titleMedium: TextStyle(
          fontSize: 16.sp,
          color: LoopsColors.colorBlack,
          fontWeight: FontWeight.w600,
          fontFamily: 'Hurme'),
      titleSmall: TextStyle(
          fontSize: 16.sp,
          color: LoopsColors.textColor,
          fontWeight: FontWeight.w400,
          fontFamily: 'Hurme'),
      bodyLarge: TextStyle(
          fontSize: 14.sp,
          color: LoopsColors.textColor,
          fontWeight: FontWeight.w500,
          fontFamily: 'Hurme'),
      bodyMedium: TextStyle(
          fontSize: 14.sp,
          color: LoopsColors.textColor,
          fontWeight: FontWeight.w400,
          fontFamily: 'Hurme'),
    ),
    colorScheme:
        ColorScheme.fromSwatch().copyWith(secondary: LoopsColors.textColor),
    sliderTheme: SliderThemeData(
      trackShape: CustomTrackShape(),
      activeTrackColor: LoopsColors.secondaryColor,
      thumbColor: LoopsColors.secondaryColor,
      // valueIndicatorShape: SliderComponentShape.noThumb,
      thumbShape: SliderComponentShape.noThumb,
    ));

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double? trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
