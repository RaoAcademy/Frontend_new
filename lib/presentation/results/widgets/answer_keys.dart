// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:EdTestz/core/utli/loops_urls.dart';
import 'package:EdTestz/core/widgets/container_with_border.dart';
import 'package:EdTestz/domain/entities/concept_entity.dart';

class AnswerKeys extends StatelessWidget {
  const AnswerKeys({
    Key? key,
    required this.concepts,
  }) : super(key: key);
  final List<Concept> concepts;
  @override
  Widget build(BuildContext context) {
    int correct = 0;
    int incoreect = 0;
    int partial = 0;
    int notAnswerd = 0;
    concepts.forEach((element) {
      correct += element.correctTotal!.toInt();
      incoreect += element.incorrectTotal!.toInt();
      partial += element.partialTotal!.toInt();
      notAnswerd += element.notAnsweredTotal!.toInt();
    });
    return ContainerWithBorder(
      borderRadius: 12.sp,
      height: 92.h,
      boxShadow: [
        BoxShadow(
            blurRadius: 10,
            color: LoopsColors.colorGrey.withOpacity(0.2),
            offset: Offset(5.sp, 5.sp))
      ],
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24.sp, horizontal: 12.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: LoopsColors.colorGreen,
                      size: 24.sp,
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    Text(
                      correct.toString(),
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 4.h,
                ),
                Expanded(
                  child: Text(
                    'Correct',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.cancel,
                      color: LoopsColors.colorRed,
                      size: 24.sp,
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    Text(
                      '$incoreect',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 4.h,
                ),
                Expanded(
                  child: Text(
                    'Incorrect',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/tests_page/partial.svg',
                      height: 21.sp,
                      width: 21.sp,
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    Text(
                      '$partial',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 4.h,
                ),
                Expanded(
                  child: Text(
                    'Partial',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/tests_page/not_answered.svg',
                      height: 21.sp,
                      width: 21.sp,
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    Text(
                      '$notAnswerd',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 4.h,
                ),
                Expanded(
                  child: Text(
                    'Not Answered',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
