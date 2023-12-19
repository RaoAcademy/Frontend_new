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

class TestInstructions extends StatefulWidget {
 final bool isResume;
 final String testType;
  TestInstructions({this.isResume = false,required this.testType});

  @override
  State<TestInstructions> createState() => _TestInstructionsState();
}

class _TestInstructionsState extends State<TestInstructions> {

  @override
  void initState() {
    super.initState();
   context.read<TestProvider>().loopTarget = null;
    // gotoStartTest(context,  context.read<TestProvider>().testEntity,
    //     fromCustomTest:  context.read<TestProvider>().fromCustomTest!);
    // context.read<TestProvider>()
    //     .ftestStart(testEntity: context.read<TestProvider>().testEntity);
    // if(Provider.of<TestProvider>(context, listen: false).testEntity.leftTop != "Practice"){
    //   if(Provider.of<TestProvider>(context, listen: false).testEntity.rightTop != null){
    //     context.read<TestProvider>().testStart.resumeQuesId = null;
    //   }else{
    //     context.read<TestProvider>().testStart.resumeQuesId = 1;
    //
    //   }
    // }else{
    //   if(widget.isResume){
    //     context.read<TestProvider>().testStart.resumeQuesId = 1;
    //
    //   }else{
    //     context.read<TestProvider>().testStart.resumeQuesId = null;
    //
    //   }
    // }

  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TestProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LoopsColors.primaryColor,
        title: Text(
          'Instructions',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: LoopsColors.colorWhite,
          ),
        ),
      ),
      body: ContainerWithBorder(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(12.sp),
        child: Column(
          children: [
            if (provider.testInstructionsEntity.description != null)
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 16.sp,
                          letterSpacing: 0.8.sp,
                          fontWeight: FontWeight.w600,
                          color: LoopsColors.colorBlack,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          provider.testInstructionsEntity.description!,
                          style: TextStyle(
                            fontSize: 14.sp,
                            letterSpacing: 0.8.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            widget.testType == "Loops" ? SizedBox() :  ContainerWithBorder(
              margin: EdgeInsets.symmetric(vertical: 12.sp),
              height: 1.sp,
              width: MediaQuery.of(context).size.width,
              boxColor: LoopsColors.colorGrey,
            ),
            widget.testType == "Loops" ? Container() :   Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Syllabus',
                      style: TextStyle(
                        fontSize: 16.sp,
                        letterSpacing: 0.8.sp,
                        fontWeight: FontWeight.w600,
                        color: LoopsColors.colorBlack,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12.h,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Wrap(
                          alignment: WrapAlignment.start,crossAxisAlignment: WrapCrossAlignment.start,runAlignment: WrapAlignment.start,
                          children: [
                            for (var item in provider
                                .testInstructionsEntity.syllabus!
                                .split(','))
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.w, vertical: 2.h),
                                  decoration: BoxDecoration(
                                    color: LoopsColors.colorsList02[provider
                                                .testInstructionsEntity.syllabus!
                                                .split(',')
                                                .indexOf(item) %
                                            LoopsColors.colorsList02.length]
                                        .withOpacity(0.2),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(4.sp),
                                    ),
                                    // border: Border.all(
                                    //   color: _chapterColor[index].withOpacity(0.2),
                                    // ),
                                  ),
                                  // height: 20.h,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 4.h,
                                      ),
                                      Text(
                                        item,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: LoopsColors.colorsList02[provider
                                                  .testInstructionsEntity.syllabus!
                                                  .split(',')
                                                  .indexOf(item) %
                                              (LoopsColors.colorsList02.length)],
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                            /* ContainerWithBorder(
                                boxColor: LoopsColors.colorsList02[provider
                                            .testInstructionsEntity.syllabus!
                                            .split(',')
                                            .indexOf(item) %
                                        LoopsColors.colorsList02.length]
                                    .withOpacity(0.2),
                                height: 22.h,
                                width: item.length * 9.sp +
                                    (item.split(' ').length * 4.sp),
                                borderRadius: 0.sp,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 4.w, vertical: 2.h),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 2.sp,
                                    color: LoopsColors.lightGrey,
                                  )
                                ],
                                child: Text(
                                  item,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    letterSpacing: 0.8.sp,
                                    fontWeight: FontWeight.w600,
                                    color: LoopsColors.colorsList02[provider
                                            .testInstructionsEntity.syllabus!
                                            .split(',')
                                            .indexOf(item) %
                                        (LoopsColors.colorsList02.length)],
                                  ),
                                ),
                              ), */
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            ContainerWithBorder(
              margin: EdgeInsets.symmetric(vertical: 12.sp),
              height: 1.sp,
              width: MediaQuery.of(context).size.width,
              boxColor: LoopsColors.colorGrey,
            ),
            if (provider.testInstructionsEntity.tags != null)
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Tags',
                        style: TextStyle(
                          fontSize: 16.sp,
                          letterSpacing: 0.8.sp,
                          fontWeight: FontWeight.w600,
                          color: LoopsColors.colorBlack,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Row(
                    children: [
                      Wrap(
                        children: [
                          for (var item in provider.testInstructionsEntity.tags!
                              .split(','))
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.w, vertical: 2.h),
                                decoration: BoxDecoration(
                                  color: LoopsColors.colorsList02[provider
                                              .testInstructionsEntity.tags!
                                              .split(',')
                                              .indexOf(item) %
                                          LoopsColors.colorsList02.length]
                                      .withOpacity(0.2),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(4.sp),
                                  ),
                                  // border: Border.all(
                                  //   color: _chapterColor[index].withOpacity(0.2),
                                  // ),
                                ),
                                // height: 20.h,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 4.h,
                                    ),
                                    Text(
                                      item,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: LoopsColors.colorsList02[provider
                                                .testInstructionsEntity.tags!
                                                .split(',')
                                                .indexOf(item) %
                                            (LoopsColors.colorsList02.length)],
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          /* ContainerWithBorder(
                              boxColor: LoopsColors.colorsList02[provider
                                      .testInstructionsEntity.tags!
                                      .split(',')
                                      .indexOf(item)]
                                  .withOpacity(0.2),
                              height: 22.h,
                              width: item.characters.length * 9.sp +
                                  (item.split(' ').length * 4.sp),
                              borderRadius: 0.sp,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 4.w, vertical: 2.h),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 2.sp,
                                  color: LoopsColors.lightGrey,
                                )
                              ],
                              child: Text(
                                item,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  letterSpacing: 0.8.sp,
                                  fontWeight: FontWeight.w600,
                                  color: LoopsColors.colorsList02[provider
                                      .testInstructionsEntity.tags!
                                      .split(',')
                                      .indexOf(item)],
                                ),
                              ),
                            ), */
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ContainerWithBorder(
              margin: EdgeInsets.symmetric(vertical: 12.sp),
              height: 1.sp,
              width: MediaQuery.of(context).size.width,
              boxColor: LoopsColors.colorGrey,
            ),
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Marks',
                      style: TextStyle(
                        fontSize: 16.sp,
                        letterSpacing: 0.8.sp,
                        fontWeight: FontWeight.w600,
                        color: LoopsColors.colorBlack,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12.h,
                ),
                Table(
                  children: [
                    TableRow(children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.sp),
                        child: Text(
                          'Type',
                          style: TextStyle(
                            fontSize: 14.sp,
                            letterSpacing: 0.8.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.sp),
                        child: Text(
                          'Correct',
                          style: TextStyle(
                            fontSize: 14.sp,
                            letterSpacing: 0.8.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.sp),
                        child: Text(
                          'Incorrect',
                          style: TextStyle(
                            fontSize: 14.sp,
                            letterSpacing: 0.8.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.sp),
                        child: Text(
                          'Partial',
                          style: TextStyle(
                            fontSize: 14.sp,
                            letterSpacing: 0.8.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.sp),
                        child: Text(
                          'Easy',
                          style: TextStyle(
                            fontSize: 14.sp,
                            letterSpacing: 0.8.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.sp),
                        child: Text(
                          provider.testInstructionsEntity.marksDistribution!
                              .easy![0]
                              .toString(),
                          style: TextStyle(
                            fontSize: 14.sp,
                            letterSpacing: 0.8.sp,
                            fontWeight: FontWeight.w600,
                            color: LoopsColors.colorBlack,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.sp),
                        child: Text(
                          provider.testInstructionsEntity.marksDistribution!
                              .easy![1]
                              .toString(),
                          style: TextStyle(
                            fontSize: 14.sp,
                            letterSpacing: 0.8.sp,
                            fontWeight: FontWeight.w600,
                            color: LoopsColors.colorBlack,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.sp),
                        child: Text(
                          provider.testInstructionsEntity.marksDistribution!
                              .easy![2]
                              .toString(),
                          style: TextStyle(
                            fontSize: 14.sp,
                            letterSpacing: 0.8.sp,
                            fontWeight: FontWeight.w600,
                            color: LoopsColors.colorBlack,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.sp),
                        child: Text(
                          'Medium',
                          style: TextStyle(
                            fontSize: 14.sp,
                            letterSpacing: 0.8.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.sp),
                        child: Text(
                          provider.testInstructionsEntity.marksDistribution!
                              .medium![0]
                              .toString(),
                          style: TextStyle(
                            fontSize: 14.sp,
                            letterSpacing: 0.8.sp,
                            fontWeight: FontWeight.w600,
                            color: LoopsColors.colorBlack,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.sp),
                        child: Text(
                          provider.testInstructionsEntity.marksDistribution!
                              .medium![1]
                              .toString(),
                          style: TextStyle(
                            fontSize: 14.sp,
                            letterSpacing: 0.8.sp,
                            fontWeight: FontWeight.w600,
                            color: LoopsColors.colorBlack,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.sp),
                        child: Text(
                          provider.testInstructionsEntity.marksDistribution!
                              .medium![2]
                              .toString(),
                          style: TextStyle(
                            fontSize: 14.sp,
                            letterSpacing: 0.8.sp,
                            fontWeight: FontWeight.w600,
                            color: LoopsColors.colorBlack,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.sp),
                        child: Text(
                          'Hard',
                          style: TextStyle(
                            fontSize: 14.sp,
                            letterSpacing: 0.8.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.sp),
                        child: Text(
                          provider.testInstructionsEntity.marksDistribution!
                              .hard![0]
                              .toString(),
                          style: TextStyle(
                            fontSize: 14.sp,
                            letterSpacing: 0.8.sp,
                            fontWeight: FontWeight.w600,
                            color: LoopsColors.colorBlack,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.sp),
                        child: Text(
                          provider.testInstructionsEntity.marksDistribution!
                              .hard![1]
                              .toString(),
                          style: TextStyle(
                            fontSize: 14.sp,
                            letterSpacing: 0.8.sp,
                            fontWeight: FontWeight.w600,
                            color: LoopsColors.colorBlack,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          provider.testInstructionsEntity.marksDistribution!
                              .hard![2]
                              .toString(),
                          style: TextStyle(
                            fontSize: 14.sp,
                            letterSpacing: 0.8.sp,
                            fontWeight: FontWeight.w600,
                            color: LoopsColors.colorBlack,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ]),
                  ],
                )
              ],
            ),
            ContainerWithBorder(
              margin: EdgeInsets.symmetric(vertical: 12.sp),
              height: 1.sp,
              width: MediaQuery.of(context).size.width,
              boxColor: LoopsColors.colorGrey,
            ),
            Column(
              children: [
                Row(
                  children: [
                    SvgPicture.asset('assets/icons/tests_page/4dots.svg'),
                    SizedBox(
                      width: 12.w,
                    ),
                    Text(
                      'Review your question status',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: LoopsColors.colorBlack,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 24.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
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
                    ),
                    Expanded(
                      child: Row(
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
                    )
                  ],
                ),
                SizedBox(
                  height: 8.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
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
                    ),
                    Expanded(
                      child: Row(
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
                    )
                  ],
                ),
                SizedBox(
                  height: 8.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
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
                    )
                  ],
                ),
              ],
            ),
            ContainerWithBorder(
              margin: EdgeInsets.symmetric(vertical: 12.sp),
              height: 1.sp,
              width: MediaQuery.of(context).size.width,
              boxColor: LoopsColors.colorGrey,
            ),
            Expanded(child: Container()),
            Center(
              child: CustomButton(
                onTap: () async{
                  if (kDebugMode) {
                    print("_Instructions");
                    print(provider.fromCustomTest);
                    print(provider.testEntity);
                  }
                  // if(provider.testStart.resumeQuesId == null){
                  //   // provider.testEntity.userTestId = null;
                  //   // provider.testEntity.testId = null;
                  // }
                  if(widget.testType == "Practice"){
                    provider.practice = true;
                    // provider.testEntity.userTestId = null;
                  }

                  if(provider.testStart.resumeQuesId == null){
                    if(provider.testEntity.userTestId == null){

                      provider.testEntity.userTestId = provider.testResultsEntity.practiceTest;
                    }
                    if(widget.testType == "Custom Test"){
                      provider.testEntity.userTestId = null;
                      if(provider.testStart.resumeQuesId == null){
                        provider.testEntity.testId = null;
                      }
                    }

                    if(widget.testType == "Concept based"){
                      if(provider.testStart.resumeQuesId == null){
                        provider.testEntity.userTestId = null;
                      }
                    }

                    if(provider.testEntity.leftTop == "Test" && widget.testType != "Practice"){
                      provider.testEntity.userTestId = null;
                    }
                    provider.testResultsEntity.practiceTest = null;
                  }
                  //else{
                  //   provider.practice = false;
                  // }
                  provider.loopTarget = null;
                 await gotoStartTest(context, provider.testEntity,practiceId: widget.testType != "Practice" ? null : provider.testResultsEntity.practiceTest?.toString() ?? null,
                      fromCustomTest: provider.fromCustomTest!);
                },
                lable: (provider.testStart.resumeQuesId == null)
                    ? 'Start'
                    : 'Resume',
              ),
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}
