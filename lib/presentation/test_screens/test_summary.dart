import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:rao_academy/application/test/test_provider.dart';
import 'package:rao_academy/core/utli/goto_pages.dart';
import 'package:rao_academy/core/utli/loops_urls.dart';
import 'package:rao_academy/core/widgets/container_with_border.dart';
import 'package:rao_academy/core/widgets/custom_button.dart';
import 'package:rao_academy/core/widgets/pie_chart.dart';
import 'package:rao_academy/domain/entities/recommendations_entity.dart';

class TestSummary extends StatefulWidget {
 final bool isShowResumeButton;
 TestSummary({required this.isShowResumeButton});

  @override
  State<TestSummary> createState() => _TestSummaryState();
}

class _TestSummaryState extends State<TestSummary> {
  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      // print(index);

      // print(provider.userId);
      // print(provider.loopsHomeEntity.loops?[0]);
      // print(_loops.first.chapterId);
    }
    final provider = Provider.of<TestProvider>(context, listen: false);

    return WillPopScope(
      onWillPop: () async {
        if(provider.testStart.poorPerformanceMessage != null){
          await   provider
              .ftestSubmit(provider.testStart.userTestId!.toInt());
        }
        await gotoHomePage(context);
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              ContainerWithBorder(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: LoopsColors.lightGrey.withOpacity(0.4),
                    offset: Offset(5.sp, 5.sp),
                  )
                ],
                height: 64.h,
                child: Center(
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () async{
                          if (kDebugMode) {
                            print("GO_BACK");
                          }
                          if(provider.testStart.poorPerformanceMessage != null){
                          await   provider
                              .ftestSubmit(provider.testStart.userTestId!.toInt());
                          }
                          gotoHomePage(context);
                          // Navigator.pop(context);
                          // goBack(context);
                          // gotoStartTest(
                          //     context,
                          //     TestEntity(
                          //       // testId: provider.loopsBottomSheetEntity.id,
                          //       testId: provider.testEntity.testId,
                          //       userTestId: provider.testStart.userTestId,
                          //     ),
                          //     fromCustomTest: false);
                          // gotoLoops(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: LoopsColors.primaryColor,
                          size: 24.sp,
                        ),
                      ),
                      SizedBox(
                        width: 12.w,
                      ),
                      Text(
                        'Summary',
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: LoopsColors.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              Expanded(
                  child: PieChart(
                centerCircle: false,
                sameStroke: true,
                height: 100.h,
                colors: LoopsColors.questionColors,
                valueList: [
                  provider.testSummaryEntity.answered!.toDouble() + 0.00000001,
                  provider.testSummaryEntity.notAnswered!.toDouble() + 0.00000001,
                  provider.testSummaryEntity.markedForReview!.toDouble() +
                      0.00000001,
                  provider.testSummaryEntity.answeredAndMarkedForReview!
                          .toDouble() +
                      0.00000001,
                  provider.testSummaryEntity.notVisited!.toDouble() + 0.00000001,
                ],
              )),
              ContainerWithBorder(
                padding: EdgeInsets.all(12.sp),
                margin: EdgeInsets.all(12.sp),
                borderRadius: 12.sp,
                child: Column(
                  children: [
                    SizedBox(
                      height: 12.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset('assets/icons/tests_page/4dots.svg'),
                            SizedBox(
                              width: 12.w,
                            ),
                            Text(
                              'All Questions',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: LoopsColors.colorBlack,
                              ),
                            )
                          ],
                        ),
                        Text(
                          provider.testSummaryEntity.totalQuestions!.toString(),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: LoopsColors.colorBlack,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    Container(
                      color: LoopsColors.lightGrey,
                      height: 1,
                      width: MediaQuery.of(context).size.width / 1.2,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset('assets/icons/tests_page/green.svg'),
                            SizedBox(
                              width: 12.w,
                            ),
                            Text(
                              'Answered',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: LoopsColors.textColor,
                              ),
                            )
                          ],
                        ),
                        Text(
                          provider.testSummaryEntity.answered!.toString(),
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: LoopsColors.colorBlack,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset('assets/icons/tests_page/red.svg'),
                            SizedBox(
                              width: 12.w,
                            ),
                            Text(
                              'Not Answered',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: LoopsColors.textColor,
                              ),
                            )
                          ],
                        ),
                        Text(
                          provider.testSummaryEntity.notAnswered!.toString(),
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: LoopsColors.colorBlack,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset('assets/icons/tests_page/gray.svg'),
                            SizedBox(
                              width: 12.w,
                            ),
                            Text(
                              'Not Visited',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: LoopsColors.textColor,
                              ),
                            )
                          ],
                        ),
                        Text(
                          provider.testSummaryEntity.notVisited!.toString(),
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: LoopsColors.colorBlack,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset('assets/icons/tests_page/blue.svg'),
                            SizedBox(
                              width: 12.w,
                            ),
                            Text(
                              'Marked for Reviewed',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: LoopsColors.textColor,
                              ),
                            )
                          ],
                        ),
                        Text(
                          provider.testSummaryEntity.markedForReview!.toString(),
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: LoopsColors.colorBlack,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                                'assets/icons/tests_page/partialblue.svg'),
                            SizedBox(
                              width: 12.w,
                            ),
                            Text(
                              'Answered and To review',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: LoopsColors.textColor,
                              ),
                            )
                          ],
                        ),
                        Text(
                          provider.testSummaryEntity.answeredAndMarkedForReview!
                              .toString(),
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: LoopsColors.colorBlack,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              Row(
                mainAxisAlignment: !widget.isShowResumeButton ? MainAxisAlignment.center : MainAxisAlignment.spaceEvenly,
                children: [
                 !widget.isShowResumeButton ? Container() : CustomButton(
                    onTap: () {
                      // provider.ftestPaused(provider.testStart.userTestId!.toInt());
                      // goBack(context);
                      if (kDebugMode) {
                        print("TEST_SUBMIT");
                        print(provider.testEntity.testId);
                      }
                      // Navigator.pop(context);
                      gotoStartTest(
                          context,
                          TestEntity(
                            // testId: provider.loopsBottomSheetEntity.id,
                            testId: provider.testEntity.testId,
                            userTestId: provider.testStart.userTestId,
                          ),
                          fromCustomTest: false,
                      practiceId: provider.testStart.testType?.toUpperCase().trim() == 'PRACTICE' ? provider.testStart.userTestId.toString() : null);
                    },
                    width: 140.w,
                    lable: 'Resume',
                    color: LoopsColors.selectedColor,
                  ),
                  CustomButton(
                    onTap: () {
                      /*  Provider.of<TestProvider>(context, listen: false)
                          .fquestionNext()
                          .then(
                        (_) {
                          Provider.of<TestProvider>(context, listen: false)
                              .ftestSubmit()
                              .onError((error, stackTrace) async {
                            await handleError(error);
                          });
                        },
                      ).onError((error, stackTrace) async {
                        await handleError(error);
                      }); */
                      if (kDebugMode) {
                        print("TEST_SUBMIT_BEFORE");
                        print(provider.testStart.testType);
                      }
                      Provider.of<TestProvider>(context, listen: false).timeTake =
                          List.filled(1000, 0);
                      provider
                          .ftestSubmit(provider.testStart.userTestId!.toInt())
                          .then((_) async {
                        if (kDebugMode) {
                          print("TEST_SUBMIT_2");
                          // print(provider.loopsBottomSheetEntity.userTestId);
                          // print(provider.testStart.userTestId?.toInt());
                          // print(provider.testEntity.userTestId?.toInt());
                          // print(provider.testStart.testType);
                          // print((provider.sprintHistoryEntity.nextSprintUserTestId)!
                          //     .toInt());
                        }
                        // if (provider.testEntity.testId ==
                        //     provider.loopsBottomSheetEntity.id?.toInt()) {
                        //   if (kDebugMode) {
                        //     print("TEST_DEBUG_SUM");
                        //     print(provider.loopsBottomSheetEntity.id?.toInt());
                        //     // print(index);
                        //     // print(context.read<TestProvider>().loopsHomeEntity.loops?[0].chapterId);
                        //     // print(provider.userId);
                        //     // print(provider.loopsHomeEntity.loops?[0]);
                        //     // print(_loops.first.chapterId);
                        //   }
                        // int id_get_from_provider =
                        //     (provider.testStart.testId)!.toInt();
                        //
                        //
                        if (provider.testStart.testType == "Custom Test") {
                          await gotoResults(
                              context, provider.testStart.userTestId?.toInt(), 0);
                        }
                        if (kDebugMode) {
                          print("------${provider.testStart.testType}");
                        }
                        if (provider.testStart.testType == "Loops"
                            /* &&(provider.testEntity.userTestId !=
                                (provider.sprintHistoryEntity.nextSprintUserTestId)!
                                    .toInt()) */
                            ) {
                          // if ((provider.loopsBottomSheetEntity.target != 0) &&
                          //     (provider.loopsBottomSheetEntity.target != null)) {
                          await gotoSprintHistory(
                              context, (provider.testStart.userTestId)!.toInt(),provider.testEntity.text1 ?? "");
                        } else if (provider.testStart.testType ==
                            "Concept based") {
                          if (kDebugMode) {
                            print("RESULT_TEST_ID");
                            print(provider.testStart.userTestId?.toInt());
                          }
                          int? userTestId =
                              provider.testStart.userTestId?.toInt();

                          await gotoResults(context, userTestId, 0);
                        }
                        // await gotoSprintHistory(
                        //     context,
                        //     // (provider.loopsHomeEntity.loops?[id_get_from_provider]
                        //     //         .chapterId)!
                        //     //     .toInt(),
                        //     (provider.testStart.userTestId)!.toInt());
                        // (provider.testEntity.testId)!.toInt());
                        // } else {
                        //   await gotoResults(
                        //       context, provider.loopsBottomSheetEntity.userTestId?.toInt());
                        // }
                      });
                    },
                    width: 140.w,
                    lable: 'Submit',
                  )
                ],
              ),
              SizedBox(
                height: 24.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
