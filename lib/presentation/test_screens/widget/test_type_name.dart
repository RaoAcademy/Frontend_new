import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rao_academy/core/utli/loops_urls.dart';
import 'package:rao_academy/core/widgets/container_with_border.dart';
import 'package:rao_academy/domain/entities/test_start_entity.dart';

Widget getTestName(Question question) {
  switch (question.format) {
    case 'MCQ':
      return ContainerWithBorder(
        width: 64.w,
        height: 24.h,
        borderRadius: 5.sp,
        borderColor: LoopsColors.textColor,
        child: Text(
          'MCQ',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    case 'MSQ':
      return ContainerWithBorder(
        width: 64.w,
        height: 24.h,
        borderRadius: 5.sp,
        borderColor: LoopsColors.textColor,
        child: Text(
          'MSQ',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    case 'Fill':
      return ContainerWithBorder(
        width: 130.w,
        height: 24.h,
        borderRadius: 5.sp,
        borderColor: LoopsColors.textColor,
        child: Text(
          'Fill In The Blanks',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    case 'True/False':
      return ContainerWithBorder(
        width: 110.w,
        height: 24.h,
        borderRadius: 5.sp,
        borderColor: LoopsColors.textColor,
        child: Text(
          'TRUE/FALSE',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    case 'Drag & Drop':
      return ContainerWithBorder(
        width: 110.w,
        height: 24.h,
        borderRadius: 5.sp,
        borderColor: LoopsColors.textColor,
        child: Text(
          'Drag & Drop',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    case 'Match':
      return ContainerWithBorder(
        width: 160.w,
        height: 24.h,
        borderRadius: 5.sp,
        borderColor: LoopsColors.textColor,
        child: Text(
          'Match The Following',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    case 'Sequence':
      return ContainerWithBorder(
        width: 110.w,
        height: 24.h,
        borderRadius: 5.sp,
        borderColor: LoopsColors.textColor,
        child: Text(
          'Sequence',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    default:
      return ContainerWithBorder(
        width: 130.w,
        height: 24.h,
        borderRadius: 5.sp,
        borderColor: LoopsColors.textColor,
        child: Text(
          'Fill In The Blanks',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
  }
}
