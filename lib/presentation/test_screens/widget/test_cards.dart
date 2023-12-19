/* // ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:rao_academy/domain/entities/recommendations_entity.dart';
import 'package:rao_academy/presentation/core/test_card.dart';

class TestCard extends StatelessWidget {
  const TestCard({
    Key? key,
    required this.list,
    required this.index,
    this.vertical = false,
  }) : super(key: key);

  final List<TestEntity> list;
  final int index;
  final bool vertical;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130.h,
      width: 261.w,
      child: Container(
          // height: 144.h,
          width: 261.w,
          constraints: BoxConstraints(
            maxWidth: 261.w,
            maxHeight: 144.h,
          ),
          padding: EdgeInsets.all(4.w),
          child: TestCard01(
              ) /* Stack(
          fit: StackFit.expand,
          children: [
            ContainerWithBorder(
              boxShadow: [
                BoxShadow(
                    blurRadius: 10,
                    color: LoopsColors.colorGrey.withOpacity(0.8),
                    offset: Offset(5.sp, 5.sp))
              ],
              height: 112.h,
              width: 261.w,
              borderRadius: 12.sp,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 25.h,
                      ),
                      SizedBox(
                        width: 75.w,
                        height: 75.h,
                        child: LoopsImage(path: list[index].imagePath!),
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 130.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 18.h,
                        ),
                        Text(
                          list[index].text1!,
                          style: appTheme.textTheme.bodyLarge!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        if (list[index].text2 != null)
                          Text(
                            list[index].text2 ?? '',
                            style: appTheme.textTheme.bodyLarge!.copyWith(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                              color: LoopsColors.colorGrey,
                            ),
                          ),
                        /* SizedBox(
                                            width: 77.w,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                /* SvgPicture.asset(
                                                  'assets/icons/logos/line.svg',
                                                  height: 10.5.h,
                                                  width: 4.sp,
                                                  color:
                                                      LoopsColors.secondaryColor,
                                                ),
                                                Text(
                                                  'NCERT',
                                                  style: appTheme
                                                      .textTheme.bodyLarge!
                                                      .copyWith(
                                                    fontSize: 10.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color: LoopsColors.colorGrey,
                                                  ),
                                                ), */
                                              ],
                                            ),
                                          ), */
                        SizedBox(
                          height: 20.h,
                        ),
    
                        Expanded(
                          child: Row(
                            children: [
                              if (list[index].coins != null)
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Center(
                                              child: Coin(coinSize: 12.sp))),
                                      SizedBox(
                                        width: 6.w,
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Center(
                                          child: Text(
                                            list[index].coins.toString(),
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w600,
                                              color: LoopsColors.colorBlack,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              if (list[index].coins != null)
                                SizedBox(
                                  width: 10.w,
                                ),
                              if (list[index].text3 != null)
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    list[index].text3!,
                                    style: appTheme.textTheme.bodyLarge!.copyWith(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w600,
                                      color: LoopsColors.colorGrey,
                                    ),
                                  ),
                                )
                              else if (list[index].noOfQs != null)
                                Expanded(
                                  child: Row(
                                    children: [
                                      Text(
                                        'Q',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600,
                                          color: LoopsColors.colorBlack,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      SvgPicture.asset(
                                        'assets/icons/logos/line.svg',
                                        height: 10.5.h,
                                        width: 8.sp,
                                        color: LoopsColors.colorBlack,
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Text(
                                        list[index].noOfQs.toString(),
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600,
                                          color: LoopsColors.colorBlack,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                        // else
                        /* Column(
                                            children: [
                                              Text(
                                                '30% completed',
                                                style: appTheme
                                                    .textTheme.bodyLarge!
                                                    .copyWith(
                                                  fontSize: 10.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: LoopsColors.colorGrey,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 2.sp,
                                                width: 71.w,
                                                child: LinearProgressIndicator(
                                                  value: 0.3,
                                                  backgroundColor: LoopsColors
                                                      .colorGrey
                                                      .withOpacity(0.4),
                                                ),
                                              )
                                            ],
                                          ) */
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: ContainerWithBorder(
                height: 17.h,
                width: 56.w,
                borderRadius: 12.sp,
                boxColor: LoopsColors.primaryColor,
                borderR: BorderRadius.only(
                  topLeft: Radius.circular(12.sp),
                  bottomRight: Radius.circular(12.sp),
                ),
                child: Center(
                  child: Text(
                    list[index].leftTop!,
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      color: LoopsColors.tertiaryColor,
                    ),
                  ),
                ),
              ),
            ),
            if (list[index].rightTop != null)
              Positioned(
                right: 0,
                top: 0,
                child: ContainerWithBorder(
                  height: 17.h,
                  width: 56.w,
                  borderRadius: 12.sp,
                  boxColor: LoopsColors.colorRed,
                  borderR: BorderRadius.only(
                    topRight: Radius.circular(12.sp),
                    bottomLeft: Radius.circular(12.sp),
                  ),
                  child: Center(
                    child: Text(
                      list[index].rightTop!,
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                        color: LoopsColors.colorWhite,
                      ),
                    ),
                  ),
                ),
              )
          ],
        ), */
          ),
    );
  }
}
 */
