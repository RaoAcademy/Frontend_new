import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:EdTestz/application/test/test_provider.dart';
import 'package:EdTestz/core/theme/custom_scroll_behaviour.dart';
import 'package:EdTestz/core/utli/goto_pages.dart';
import 'package:EdTestz/core/utli/loops_urls.dart';
import 'package:EdTestz/core/widgets/container_with_border.dart';
import 'package:EdTestz/presentation/test_screens/widget/results_card.dart';

import '../../../domain/entities/recommendations_entity.dart';

class SprintHome extends StatefulWidget {
  final String testName;
  SprintHome({required this.testName});

  @override
  State<SprintHome> createState() => _SprintHomeState();
}

class _SprintHomeState extends State<SprintHome> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TestProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: () async{
          gotoHomePage(context);
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              ContainerWithBorder(
                boxColor: LoopsColors.primaryColor,
                height: 64.h,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        // goSpecificBack(context, 1);
                        // if (kDebugMode) {
                        //   print("GO_BACK");
                        // }
                        // gotoLoops(context);
                          gotoHomePage(context);
                        // goBack(context);
                        // gotoLoops(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: LoopsColors.whiteBkground,
                        size: 24.sp,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: Text(
                          widget.testName,
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                            color: LoopsColors.colorWhite,
                            overflow: TextOverflow.ellipsis
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ContainerWithBorder(
                    borderColor: LoopsColors.secondaryColor,
                    height: 37.h,
                    width: 170.w,
                    borderRadius: 4.sp,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4.sp,
                        color: LoopsColors.lightGrey,
                        offset: Offset(0, 4.sp),
                      )
                    ],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Target score',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        ContainerWithBorder(
                          width: 48.sp,
                          height: 26.sp,
                          borderRadius: 4.sp,
                          boxColor: LoopsColors.colorOrange1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                provider.sprintHistoryEntity.loopTarget
                                        ?.toString() ??
                                    '',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: LoopsColors.colorWhite,
                                ),
                              ),
                              Text(
                                '%',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: LoopsColors.colorWhite,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 0.w,
                  ),
                  ContainerWithBorder(
                    borderColor: LoopsColors.secondaryColor,
                    height: 37.h,
                    width: 170.w,
                    borderRadius: 4.sp,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4.sp,
                        color: LoopsColors.lightGrey,
                        offset: Offset(0, 4.sp),
                      )
                    ],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Your score',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        ContainerWithBorder(
                          width: 48.sp,
                          height: 26.sp,
                          borderRadius: 4.sp,
                          boxColor: LoopsColors.colorOrange1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                provider.sprintHistoryEntity.loopAchieved
                                        ?.toStringAsFixed(1) ??
                                    '',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: LoopsColors.colorWhite,
                                ),
                              ),
                              Text(
                                '%',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: LoopsColors.colorWhite,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 8.w,
              ),
              Expanded(
                child: ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: ListView.builder(
                      itemCount: provider.sprintHistoryEntity.sprint?.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.sp, vertical: 8.sp),
                          child: Column(
                            children: [
                              ResultsCard(
                                title: 'Sprint ${index + 1}',
                                coins: provider
                                        .sprintHistoryEntity.sprint?[index].coins
                                        ?.toInt() ??
                                    0,
                                subTile: Text(
                                  'Good',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                titleMedium: 'Score',
                                subtitle2: 'Time',
                                subtitle3: 'Pending Target',
                                data1: provider
                                        .sprintHistoryEntity.sprint?[index].achieved
                                        ?.toStringAsFixed(2) ??
                                    '',
                                data2:
                                    '${provider.sprintHistoryEntity.sprint?[index].timetaken?.toInt() ?? 0}s',
                                data3:
                                    '${provider.sprintHistoryEntity.sprint?[index].target?.toStringAsFixed(2)}%',
                                value1: (provider.sprintHistoryEntity.sprint?[index]
                                            .achieved
                                            ?.toDouble() ??
                                        0) /
                                    100,
                                value2: (provider.sprintHistoryEntity.sprint?[index]
                                            .timetaken
                                            ?.toDouble() ??
                                        0) /
                                    100,
                                value3: (provider.sprintHistoryEntity.sprint?[index]
                                            .target
                                            ?.toDouble() ??
                                        0) /
                                    100,
                                detailsFunction: () {
                                  if (kDebugMode) {
                                    print("START_TEST_RESULTS");
                                    print(provider.sprintHistoryEntity
                                        .sprint?[index].userTestId
                                        ?.toInt());
                                    // print(index);
                                    // print(context.read<TestProvider>().loopsHomeEntity.loops?[0].chapterId);
                                    // print(provider.userId);
                                    // print(provider.loopsHomeEntity.loops?[0]);
                                    // print(_loops.first.chapterId);
                                  }
                                  gotoResults(
                                      context,
                                      provider.sprintHistoryEntity.sprint?[index]
                                          .userTestId
                                          ?.toInt(),
                                      1);
                                },
                              ),
                            ],
                          ),
                        );
                      }),
                ),
              ),
              if (provider.sprintHistoryEntity.loopAchieved! <
                  provider.sprintHistoryEntity.loopTarget!)
                ContainerWithBorder(
                  boxColor: LoopsColors.primaryColor,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4.sp,
                      color: LoopsColors.lightGrey,
                      offset: Offset(0, 4.sp),
                    )
                  ],
                  margin: EdgeInsets.only(top: 12.sp),
                  height: 34.h,
                  width: 178.w,
                  borderRadius: 12.sp,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        /*  Icon(
                          Icons.add_circle_outline_rounded,
                          color: LoopsColors.colorGreen,
                        ), */
                        InkWell(
                          onTap: () {
                            gotoStartTest(
                                context,
                                TestEntity(
                                  // testId: provider.loopsBottomSheetEntity.id,
                                  // testId: testId,
                                  userTestId: provider.sprintHistoryEntity
                                      .nextSprintUserTestId, //TODO: This parameter change with testId getting from the backend still waiting.
                                ),
                                fromCustomTest: false,
                            practiceId: null);
                          },
                          child: Text(
                            'Start Sprint ${(provider.sprintHistoryEntity.sprint?.length ?? 0) + 1}',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: LoopsColors.colorWhite,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              SizedBox(
                height: 32.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
