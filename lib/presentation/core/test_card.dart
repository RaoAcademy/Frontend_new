// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:curved_progress_bar/curved_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rao_academy/core/utli/goto_pages.dart';

import 'package:rao_academy/core/utli/loops_urls.dart';
import 'package:rao_academy/core/widgets/coin.dart';
import 'package:rao_academy/core/widgets/container_with_border.dart';
import 'package:rao_academy/domain/entities/recommendations_entity.dart';
import 'package:rao_academy/presentation/other/widgets/cached_network_image.dart';

import '../../application/test/test_provider.dart';

class TestCard01 extends StatelessWidget {
  const TestCard01({
    Key? key,
    
    required this.resume,
    required this.results,
    required this.repeat,
    required this.testEntity,
  }) : super(key: key);
  
  final Function()? resume;
  final Function()? results;
  final Function()? repeat;
  final TestEntity testEntity;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (testEntity.text3?.toUpperCase() != 'ONGOING' &&
            testEntity.text3?.toUpperCase() != 'FINISHED') {
          context.read<TestProvider>().testStart.resumeQuesId = null;
          context.read<TestProvider>().showAnswer = false;

          await gotoTestInstructions(
            context,
            testEntity: testEntity,
            testType: ""
          );
        } else {
          // repeat;
        }
      },
      child: Stack(
        children: [
          ContainerWithBorder(
            padding: EdgeInsets.all(8.sp),
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                color: LoopsColors.colorGrey.withOpacity(0.2),
                offset: Offset(5.sp, 5.sp),
              ),
              BoxShadow(
                  blurRadius: 10,
                  color: LoopsColors.colorGrey.withOpacity(0.2),
                  offset: Offset(-5.sp, 5.sp))
            ],
            height: 130.h,
            width: 261.w,
            borderRadius: 8.sp,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 12.h,
                      ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.all(4.sp),
                          child: SizedBox(
                              width: 75.sp,
                              height: 75.sp,
                              child: LoopsImage(
                                path: testEntity.imagePath??'',
                                fit: BoxFit.contain,
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 12.h,
                      ),
                      Expanded(
                        flex: 6,
                        child: Text(
                         testEntity.text1??'',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color: LoopsColors.colorBlack),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          testEntity.text2??'',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                            color: LoopsColors.colorGrey,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            if (testEntity.text3?.toUpperCase() == 'FINISHED')
                              Expanded(
                                child: Column(
                                  // mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      testEntity.text3 ?? '',
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w600,
                                        color: LoopsColors.colorGrey,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3.36.h,
                                      width: 70.w,
                                      child: CurvedLinearProgressIndicator(
                                        value: 1,
                                        color: LoopsColors.primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            else if (testEntity.text3?.toUpperCase() == 'ONGOING')
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Paused',
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w600,
                                              color: LoopsColors.colorGrey,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 2.h,
                                          ),
                                          SizedBox(
                                            height: 4.h,
                                            width: 120.w,
                                            child:
                                                CurvedLinearProgressIndicator(
                                              value: 0.5,
                                              color: LoopsColors.primaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            else
                              Expanded(
                                child: Text(
                                  testEntity.text3 ?? '',
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w600,
                                    color: LoopsColors.colorGrey,
                                  ),
                                ),
                              ),

                            /////////////////
                            if (testEntity.text3?.toUpperCase() == 'FINISHED')
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: results,
                                    child: Icon(
                                      Icons.note_alt_outlined,
                                      color: LoopsColors.primaryColor,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  InkWell(
                                    onTap: repeat,
                                    child: Icon(
                                      Icons.loop_outlined,
                                      color: LoopsColors.primaryColor,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                ],
                              )
                            else if (testEntity.text3?.toUpperCase() == 'ONGOING')
                              IconButton(
                                onPressed: resume,
                                icon: Icon(
                                  Icons.play_arrow,
                                  color: LoopsColors.primaryColor,
                                ),
                              )
                            else
                              Container(
                                height: 20.h,
                                width: 60.w,
                                padding: EdgeInsets.only(right: 8.w, top: 4.h),
                                child: Row(
                                  children: [
                                    Expanded(child: Container()),
                                    Coin(coinSize: 12.sp),
                                    SizedBox(
                                      width: 6.w,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          testEntity.coins?.toString() ?? '0',
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w600,
                                            color: LoopsColors.colorBlack,
                                          ),
                                        ),
                                        Container(
                                          height: 2.h,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ////////////////
                          ],
                        ),
                      ),
                      // if (coin != null)

                      /* SizedBox(
                                                    height: 2.sp,
                                                    width: 71.w,
                                                    child: LinearProgressIndicator(
                                                      value: 0.3,
                                                      backgroundColor: LoopsColors
                                                          .colorGrey
                                                          .withOpacity(0.4),
                                                    ),
                                                  ) */
                    ],
                  ),
                )
              ],
            ),
          ),
          if (testEntity.leftTop != null)
            Positioned(
              child: ContainerWithBorder(
                height: 17.h,
                width: 56.w,
                borderRadius: 12.sp,
                boxColor: LoopsColors.primaryColor,
                borderR: BorderRadius.only(
                  topLeft: Radius.circular(8.sp),
                  bottomRight: Radius.circular(8.sp),
                ),
                child: Center(
                  child: Text(
                    testEntity.leftTop!,
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      color: LoopsColors.tertiaryColor,
                    ),
                  ),
                ),
              ),
            ),
          if (testEntity.rightTop != null)
            Positioned(
              right: 0,
              top: 0,
              child: ContainerWithBorder(
                height: 17.h,
                width: 56.w,
                borderRadius: 8.sp,
                boxColor: LoopsColors.colorRed,
                borderR: BorderRadius.only(
                  topRight: Radius.circular(8.sp),
                  bottomLeft: Radius.circular(8.sp),
                ),
                child: Center(
                  child: Text(
                    testEntity.rightTop!,
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
      ),
    );
  }
}
