import 'dart:async';

import 'package:curved_progress_bar/curved_progress_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rao_academy/application/test/test_provider.dart';
import 'package:rao_academy/core/utli/error_handle.dart';
import 'package:rao_academy/core/utli/goto_pages.dart';
import 'package:rao_academy/core/utli/loops_urls.dart';
import 'package:rao_academy/core/widgets/container_with_border.dart';
import 'package:rao_academy/core/widgets/custom_button.dart';

class Bottombar extends StatefulWidget {
  const Bottombar({
    Key? key,
    required this.progress,
    required this.getValue,
    required this.hidePrevious,
    required this.practice,
  }) : super(key: key);
  final ValueChanged<bool> getValue;
  final double progress;
  final bool hidePrevious;
  final bool practice;

  @override
  State<Bottombar> createState() => _BottombarState();
}

class _BottombarState extends State<Bottombar> with WidgetsBindingObserver {

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        gotoTestSummary(
            context, Provider.of<TestProvider>(context, listen: false).testStart.userTestId!.toInt(),true)
            .onError((error, stackTrace) async {
          await handleError(error);
        });
        break;
      case AppLifecycleState.paused:
        Provider.of<TestProvider>(context, listen: false)
            .ftestPaused(
            Provider.of<TestProvider>(context, listen: false).testStart.userTestId!.toInt(),
            Provider.of<TestProvider>(context, listen: false)
                .testStart
                .question![Provider.of<TestProvider>(context, listen: false).currentQuestionPageIndex]
                .questionId!
                .toInt())
            .onError((error, stackTrace) async {
          await handleError(error);
        });

        break;
      case AppLifecycleState.inactive:
        Provider.of<TestProvider>(context, listen: false)
            .ftestPaused(
            Provider.of<TestProvider>(context, listen: false).testStart.userTestId!.toInt(),
            Provider.of<TestProvider>(context, listen: false)
                .testStart
                .question![Provider.of<TestProvider>(context, listen: false).currentQuestionPageIndex]
                .questionId!
                .toInt())
            .onError((error, stackTrace) async {
          await handleError(error);
        });
        break;

      default:
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TestProvider>(
      builder: (contest, provider, _) {
        return ContainerWithBorder(
          boxColor: LoopsColors.whiteBkground,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 12.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (widget.hidePrevious || widget.practice)
                Container()
              else
                TextButton(
                  onPressed: () {
                    if (kDebugMode) {
                      print("TEST_DEBUG");
                    }
                    context.read<TestProvider>().pageController.previousPage(
                      curve: Curves.decelerate,
                      duration: const Duration(milliseconds: 300),
                    );
                    /*  Navigator.pop(context);
                  Provider.of<OtherProvider>(context, listen: false)
                      .routeNames
                      .remove(Provider.of<OtherProvider>(context, listen: false)
                          .routeNames
                          .last); */
                    // getValue.call(false); removed this line because previous does not work
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.arrow_back_ios,
                        color: LoopsColors.primaryColor.withOpacity(0.5),
                        size: 14.sp,
                      ),
                      Text(
                        'Previous',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: LoopsColors.primaryColor,
                        ),
                      )
                    ],
                  ),
                ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Provider.of<TestProvider>(context, listen: false)
                          .ftestPaused(
                          provider.testStart.userTestId!.toInt(),
                          provider
                              .testStart
                              .question![provider.currentQuestionPageIndex]
                              .questionId!
                              .toInt())
                          .onError((error, stackTrace) async {
                        await handleError(error);
                      });
                      gotoTestSummary(
                          context, provider.testStart.userTestId!.toInt(),true)
                          .onError((error, stackTrace) async {
                        await handleError(error);
                      });
                    },
                    icon: Icon(
                      Icons.pause_circle_outline,
                      size: 24.sp,
                      color: LoopsColors.tertiaryColor,
                    ),
                  ),
                  CustomButton(
                    onTap: () {
                      if (widget.practice) {
                        provider.showAnswer = true;
                        provider.setState();
                      } else {
                        if (kDebugMode) {
                          print("TEST_SUBMIT");
                          print(provider.testStart.userTestId?.toInt());
                          print(provider.testEntity.userTestId?.toInt());
                          print(provider.loopsBottomSheetEntity.resume);
                          print(provider.loopsBottomSheetEntity.start);
                        }
                        // provider.testStart.userTestId;
                        // if (provider.loopsBottomSheetEntity.resume!) {
                        //   gotoTestSummary(
                        //           context,
                        //           provider.testEntity.userTestId?.toInt() ??
                        //               provider.testEntity.testId!.toInt())
                        //       .onError((error, stackTrace) async {
                        //     await handleError(error);
                        //   });
                        // } else if (provider.loopsBottomSheetEntity.start!) {
                        //   gotoTestSummary(
                        //           context,
                        //           provider.testStart.userTestId?.toInt() ??
                        //               provider.testEntity.testId!.toInt())
                        //       .onError((error, stackTrace) async {
                        //     await handleError(error);
                        //   });
                        // } else
                        Provider.of<TestProvider>(context, listen: false)
                            .ftestPaused(
                            provider.testStart.userTestId!.toInt(),
                            provider
                                .testStart
                                .question![
                            provider.currentQuestionPageIndex]
                                .questionId!
                                .toInt())
                            .onError((error, stackTrace) async {
                          await handleError(error);
                        });
                        gotoTestSummary(
                            context, provider.testStart.userTestId!.toInt(), true)
                            .onError((error, stackTrace) async {
                          await handleError(error);
                        });
                        // {
                        //   gotoTestSummary(
                        //           context,
                        //           provider.testStart.userTestId?.toInt() ??
                        //               provider.testEntity.testId!.toInt())
                        //       .onError((error, stackTrace) async {
                        //     await handleError(error);
                        //   });
                        // }
                      }
                    },
                    width: 80.w,
                    height: 30.h,
                    lable: widget.practice ? 'Check' : 'Submit',
                  ),
                ],
              ),

              // TextButton(
              //   onPressed: () {
              //     if (kDebugMode) {
              //       print("TEST_DEBUG");
              //     }
              //     context.read<TestProvider>().pageController.nextPage(
              //           curve: Curves.decelerate,
              //           duration: const Duration(milliseconds: 300),
              //         );
              //     /*  Navigator.pop(context);
              //     Provider.of<OtherProvider>(context, listen: false)
              //         .routeNames
              //         .remove(Provider.of<OtherProvider>(context, listen: false)
              //             .routeNames
              //             .last); */
              //     // getValue.call(false); removed this line because previous does not work
              //   },
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Icon(
              //         Icons.arrow_forward_ios,
              //         color: LoopsColors.primaryColor.withOpacity(0.5),
              //         size: 14.sp,
              //       ),
              //       Text(
              //         'Next',
              //         style: TextStyle(
              //           fontSize: 14.sp,
              //           fontWeight: FontWeight.w600,
              //           color: LoopsColors.primaryColor,
              //         ),
              //       )
              //     ],
              //   ),
              // ),
              if (widget.practice && provider.showAnswer)
                TextButton(
                  onPressed: () async {
                    provider.showAnswer = false;
                    unawaited(showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) => const Center(
                        child: CurvedCircularProgressIndicator(),
                      ),
                    ));
                    await Future.delayed(Duration.zero).then((value) async {
                      await Provider.of<TestProvider>(context, listen: false)
                          .fquestionNext(
                          provider.testEntity.userTestId?.toInt())
                          .then(
                            (_) {
                          widget.getValue.call(true);
                          Navigator.pop(context);
                        },
                      ).onError((error, stackTrace) async {
                        await handleError(error);
                      });
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Next',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: LoopsColors.primaryColor,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: LoopsColors.primaryColor.withOpacity(0.5),
                        size: 14.sp,
                      ),
                    ],
                  ),
                )
              else if (!widget.practice)
                TextButton(
                  onPressed: () async {
                    provider.showAnswer = false;
                    unawaited(showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) => const Center(
                        child: CurvedCircularProgressIndicator(),
                      ),
                    ));
                    await Future.delayed(Duration.zero).then((value) async {
                      await Provider.of<TestProvider>(context, listen: false)
                          .fquestionNext(provider.testStart.userTestId?.toInt())
                          .then(
                            (_) {
                          widget.getValue.call(true);
                          Navigator.pop(context);
                        },
                      ).onError((error, stackTrace) async {
                        await handleError(error);
                      });
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Next',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: LoopsColors.primaryColor,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: LoopsColors.primaryColor.withOpacity(0.5),
                        size: 14.sp,
                      ),
                    ],
                  ),
                )
              else
                Container()
              // if (true)
              //   TextButton(
              //     onPressed: () async {
              //       provider.showAnswer = false;
              //       unawaited(showDialog(
              //         context: context,
              //         barrierDismissible: false,
              //         builder: (_) => const Center(
              //           child: CurvedCircularProgressIndicator(),
              //         ),
              //       ));
              //       if (kDebugMode) {
              //         // print("");
              //         // // print(testId);
              //         // print(provider.testEntity.userTestId);
              //         // print(provider.testStart.userTestId);
              //         print("TEST_NEXT");
              //
              //         print(provider.testStart.userTestId?.toInt());
              //         print(provider.testEntity.userTestId?.toInt());
              //       }
              //       // provider.testStart.userTestId;
              //       // if (provider.loopsBottomSheetEntity.resume!) {
              //       //   await Future.delayed(Duration.zero).then((value) async {
              //       //     await Provider.of<TestProvider>(context, listen: false)
              //       //         .fquestionNext(
              //       //             provider.testStart.userTestId?.toInt() ??
              //       //                 provider.testEntity.testId!.toInt())
              //       //         .then(
              //       //       (_) {
              //       //         getValue.call(true);
              //       //         Navigator.pop(context);
              //       //       },
              //       //     ).onError((error, stackTrace) async {
              //       //       await handleError(error);
              //       //     });
              //       //   });
              //       // } else if (provider.loopsBottomSheetEntity.start!) {
              //       //   await Future.delayed(Duration.zero).then((value) async {
              //       //     await Provider.of<TestProvider>(context, listen: false)
              //       //         .fquestionNext(
              //       //             provider.testStart.userTestId?.toInt() ??
              //       //                 provider.testEntity.testId!.toInt())
              //       //         .then(
              //       //       (_) {
              //       //         getValue.call(true);
              //       //         Navigator.pop(context);
              //       //       },
              //       //     ).onError((error, stackTrace) async {
              //       //       await handleError(error);
              //       //     });
              //       //   });
              //       // } else {
              //       if (kDebugMode) {
              //         print("I'M in the Test");
              //         // print(testId);
              //         print(provider.testStart.userTestId);
              //         // print(provider.testEntity.testId!.toInt());
              //       }
              //       await Future.delayed(Duration.zero).then((value) async {
              //         await Provider.of<TestProvider>(context, listen: false)
              //             .fquestionNext(provider.testStart.userTestId?.toInt())
              //             .then(
              //           (_) {
              //             getValue.call(true);
              //             Navigator.pop(context);
              //           },
              //         ).onError((error, stackTrace) async {
              //           await handleError(error);
              //         });
              //       });
              //       // }
              //     },
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Text(
              //           'Next',
              //           style: TextStyle(
              //             fontSize: 14.sp,
              //             fontWeight: FontWeight.w600,
              //             color: LoopsColors.primaryColor,
              //           ),
              //         ),
              //         Icon(
              //           Icons.arrow_forward_ios,
              //           color: LoopsColors.primaryColor.withOpacity(0.5),
              //           size: 14.sp,
              //         ),
              //       ],
              //     ),
              //   )
              // else
              //   Container()
            ],
          ),
        );
      },
    );
  }
}
