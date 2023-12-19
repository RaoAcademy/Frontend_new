/* import 'package:curved_progress_bar/curved_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rao_academy/application/test/test_provider.dart';
import 'package:rao_academy/core/theme/theme.dart';
import 'package:rao_academy/core/utli/goto_pages.dart';
import 'package:rao_academy/core/utli/loops_urls.dart';
import 'package:rao_academy/core/widgets/coin.dart';
import 'package:rao_academy/core/widgets/container_with_border.dart';
import 'package:provider/provider.dart';

class SprintHistory extends StatelessWidget {
  const SprintHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TestProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LoopsColors.primaryColor,
        title: Text(
          'Sprint History',
          style: appTheme.textTheme.headlineMedium!
              .copyWith(color: LoopsColors.colorWhite),
        ),
        centerTitle: false,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ContainerWithBorder(
                  width: 169.w,
                  height: 37.h,
                  borderColor: LoopsColors.primaryColor,
                  borderRadius: 10.sp,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Target Score',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      ContainerWithBorder(
                        boxColor: LoopsColors.colorOrange1,
                        height: 27.sp,
                        width: 27.sp,
                        child: Text(
                          provider.sprintHistoryEntity.loopTarget?.toString() ??
                              '',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: LoopsColors.colorWhite,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ContainerWithBorder(
                  width: 169.w,
                  height: 37.h,
                  borderColor: LoopsColors.primaryColor,
                  borderRadius: 10.sp,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Your Score',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      ContainerWithBorder(
                        boxColor: LoopsColors.colorOrange1,
                        height: 27.sp,
                        width: 27.sp,
                        child: Text(
                          provider.sprintHistoryEntity.loopAchieved
                                  ?.toString() ??
                              '',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: LoopsColors.colorWhite,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: provider.sprintHistoryEntity.sprint?.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        gotoResults(context); //TODO: need testId from backend.
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 11.h),
                        child: ContainerWithBorder(
                          height: 134.h,
                          width: 362.w,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: LoopsColors.selectedColor,
                              width: 1.sp,
                            ),
                            color: LoopsColors.colorWhite,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.sp),
                            ),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 12.sp,
                                  color: LoopsColors.lightGrey)
                            ],
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          ContainerWithBorder(
                                            height: 27.h,
                                            width: 76.w,
                                            borderRadius: 2.sp,
                                            boxColor: LoopsColors.selectedColor,
                                            child: Text(
                                              'Sprint ${index + 1}',
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w600,
                                                color: LoopsColors.primaryColor,
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Row(
                                                children: [
                                                  Coin(coinSize: 12.sp),
                                                  Text(
                                                    provider
                                                            .sprintHistoryEntity
                                                            .sprint?[index]
                                                            .coins
                                                            ?.toString() ??
                                                        '0',
                                                    style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.timer_outlined,
                                                        size: 8.sp,
                                                      ),
                                                      Text(
                                                        '${provider.sprintHistoryEntity.sprint?[index].timetaken ?? 0} Min',
                                                        style: TextStyle(
                                                          fontSize: 8.sp,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    'Sprint Time',
                                                    style: TextStyle(
                                                      fontSize: 6.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 40.sp,
                                            height: 40.sp,
                                            child: Stack(
                                              children: [
                                                Transform.scale(
                                                  scaleX: -1,
                                                  child: RotatedBox(
                                                    quarterTurns: 1,
                                                    child:
                                                        CurvedCircularProgressIndicator(
                                                      value: (provider
                                                                  .sprintHistoryEntity
                                                                  .sprint?[
                                                                      index]
                                                                  .achieved ??
                                                              1) /
                                                          100,
                                                      color: LoopsColors
                                                          .colorsList03[0],
                                                    ),
                                                  ),
                                                ),
                                                Center(
                                                  child: Text(
                                                    '${provider.sprintHistoryEntity.sprint?[index].achieved}%',
                                                    style: TextStyle(
                                                      fontSize: 10.sp,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Text(
                                            'Achieved',
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 40.sp,
                                            height: 40.sp,
                                            child: Stack(
                                              children: [
                                                Transform.scale(
                                                  scaleX: -1,
                                                  child: RotatedBox(
                                                    quarterTurns: 1,
                                                    child:
                                                        CurvedCircularProgressIndicator(
                                                      value: (provider
                                                                  .sprintHistoryEntity
                                                                  .sprint?[
                                                                      index]
                                                                  .timetaken ??
                                                              1) /
                                                          100,
                                                      color: LoopsColors
                                                          .colorsList03[0],
                                                    ),
                                                  ),
                                                ),
                                                Center(
                                                  child: Text(
                                                    '${provider.sprintHistoryEntity.sprint?[index].timetaken}%',
                                                    style: TextStyle(
                                                      fontSize: 10.sp,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Text(
                                            'Avg Time',
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 40.sp,
                                            height: 40.sp,
                                            child: Stack(
                                              children: [
                                                Transform.scale(
                                                  scaleX: -1,
                                                  child: RotatedBox(
                                                    quarterTurns: 1,
                                                    child:
                                                        CurvedCircularProgressIndicator(
                                                      value: (provider
                                                                  .sprintHistoryEntity
                                                                  .sprint?[
                                                                      index]
                                                                  .target ??
                                                              1) /
                                                          100,
                                                      color: LoopsColors
                                                          .colorsList03[0],
                                                    ),
                                                  ),
                                                ),
                                                Center(
                                                  child: Text(
                                                    '${provider.sprintHistoryEntity.sprint?[index].target}%',
                                                    style: TextStyle(
                                                      fontSize: 10.sp,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Text(
                                            'Target',
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ContainerWithBorder(
                                height: 1.h,
                                borderRadius: 12.sp,
                                boxColor: LoopsColors.selectedColor,
                              ),
                              ContainerWithBorder(
                                height: 23.h,
                                borderRadius: 12.sp,
                                child: Center(
                                  child: Text(
                                    'View Results in detail →',
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
 */
