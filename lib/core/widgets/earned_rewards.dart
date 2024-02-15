import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:EdTestz/core/utli/loops_urls.dart';
import 'package:EdTestz/core/widgets/container_with_border.dart';
import 'package:EdTestz/core/widgets/custom_button.dart';

void earnedRewards(BuildContext context, num? rewards,
    num? numberOfPeopleSubscribed, num? numberOfSignedPeople) {
  // context.watch<>();

  showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                12.sp,
              ),
            ),
            content: ContainerWithBorder(
              height: 180.h,
              // borderColor: LoopsColors.primaryColor,
              borderRadius: 10.sp,
              // padding: EdgeInsets.all(4.sp),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // SizedBox(
                  //   height: 21.h,
                  // ),
                  ContainerWithBorder(
                    // borderColor: LoopsColors.primaryColor,
                    boxColor: LoopsColors.secondaryColor.withOpacity(0.2),
                    borderRadius: 4.sp,
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                    ),
                    height: 37.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Rewards Received',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: LoopsColors.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          rewards.toString() ?? "",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: LoopsColors.textColor,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Friends Subscribed',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 4,
                            height: 1.4.sp,
                            color: LoopsColors.tertiaryColor,
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Text(
                            numberOfPeopleSubscribed.toString() ?? '',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'Friends Signed up',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 4,
                            height: 1.4.sp,
                            color: LoopsColors.tertiaryColor,
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Text(
                            numberOfSignedPeople.toString() ?? '',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomButton(
                      width: 100.w,
                      height: 35.h,
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Close',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: LoopsColors.primaryColor,
                          letterSpacing: 1.sp,
                        ),
                      )),
                  SizedBox(
                    height: 2.h,
                  ),
                ],
              ),
            ));
      });
}
