import 'package:curved_progress_bar/curved_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rao_academy/core/utli/loops_urls.dart';

import 'package:rao_academy/core/widgets/coin.dart';
import 'package:rao_academy/core/widgets/container_with_border.dart';

class ResultsCard extends StatelessWidget {
  const ResultsCard({
    Key? key,
    required this.title,
    required this.coins,
    required this.subTile,
    required this.titleMedium,
    required this.subtitle2,
    required this.subtitle3,
    required this.data1,
    required this.data2,
    required this.data3,
    required this.value1,
    required this.value2,
    required this.value3,
    required this.detailsFunction,
  }) : super(key: key);
  final String title;
  final int coins;
  final Widget subTile;
  final String titleMedium;
  final String subtitle2;
  final String subtitle3;
  final String data1;
  final String data2;
  final String data3;
  final double value1;
  final double value2;
  final double value3;
  final Function() detailsFunction;

  @override
  Widget build(BuildContext context) {
    return ContainerWithBorder(
      padding: EdgeInsets.all(10.sp),
      borderRadius: 12.sp,
      height: 134.h,
      boxShadow: [
        BoxShadow(
          blurRadius: 10.sp,
          color: LoopsColors.colorGrey,
          offset: Offset(0, 4.sp),
        )
      ],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ContainerWithBorder(
                        height: 27.h,
                        width: 65.w,
                        boxColor: LoopsColors.lightGrey,
                        borderRadius: 4.sp,
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: LoopsColors.colorBlue2,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Coin(coinSize: 20.sp),
                                SizedBox(
                                  width: 8.w,
                                ),
                                Text(
                                  coins.toString(),
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: LoopsColors.textColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          /*  Expanded(
                              child: 
                                  subTile) */
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            height: 60.sp,
                            width: 60.sp,
                            child: CurvedCircularProgressIndicator(
                              value: value1,
                              color: LoopsColors.colorsList03[0],
                              backgroundColor:
                                  LoopsColors.colorsList03[0].withOpacity(0.3),
                              strokeWidth: 9.sp,
                              animationDuration: const Duration(seconds: 3),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Text(
                                data1,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                  color: LoopsColors.colorsList03[0],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Text(
                        titleMedium,
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                          color: LoopsColors.textColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            height: 60.sp,
                            width: 60.sp,
                            child: CurvedCircularProgressIndicator(
                              value: value2,
                              color: LoopsColors.colorsList03[1],
                              backgroundColor:
                                  LoopsColors.colorsList03[1].withOpacity(0.3),
                              strokeWidth: 9.sp,
                              animationDuration: const Duration(seconds: 3),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Text(
                                data2,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                  color: LoopsColors.colorsList03[1],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Text(
                        subtitle2,
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                          color: LoopsColors.textColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            height: 60.sp,
                            width: 60.sp,
                            child: CurvedCircularProgressIndicator(
                              value: value3,
                              color: LoopsColors.colorsList03[2],
                              backgroundColor:
                                  LoopsColors.colorsList03[2].withOpacity(0.3),
                              strokeWidth: 9.sp,
                              animationDuration: const Duration(seconds: 3),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Text(
                                data3,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                  color: LoopsColors.colorsList03[2],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Text(
                        subtitle3,
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                          color: LoopsColors.textColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ContainerWithBorder(
            borderColor: LoopsColors.colorGrey,
            borderRadius: 12.sp,
            width: 90.w,
            height: 20.h,
            child: InkWell(
              onTap: detailsFunction,
              child: Text(
                'Detailed Results',
                style: TextStyle(
                  fontSize: 9.sp,
                  fontWeight: FontWeight.w600,
                  color: LoopsColors.primaryColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
