import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:EdTestz/core/utli/loops_urls.dart';

class MarksGained extends StatelessWidget {
  const MarksGained({
    Key? key,
    required this.title,
    required this.correct,
    required this.incorrect,
    required this.partial,
    required this.na,
    required this.score,
    required this.total,
  }) : super(key: key);
  final String title;
  final int correct;
  final int incorrect;
  final int partial;
  final int na;
  final int score;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 200.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          '$correct',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
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
                          '$incorrect',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
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
                          '$na',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 90.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Score',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: LoopsColors.textColor.withOpacity(0.5),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '$score/',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '$total',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: LoopsColors.textColor.withOpacity(0.5),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
