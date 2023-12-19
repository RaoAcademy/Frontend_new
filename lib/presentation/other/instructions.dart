/* import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rao_academy/application/test/test_provider.dart';
import 'package:rao_academy/core/theme/custom_scroll_behaviour.dart';
import 'package:rao_academy/core/utli/loops_urls.dart';
import 'package:rao_academy/core/widgets/custom_button.dart';
import 'package:rao_academy/presentation/other/widgets/custom_table.dart';
import 'package:provider/provider.dart';
// import 'package:rao_academy/core/widgets/container_with_border.dart';

List<String> _chapter = ['REFRACTION', 'LIGHT', 'PHYSICS'];
List<Color> _chapterColor = [
  LoopsColors.colorOrange2,
  LoopsColors.colorGreen2,
  LoopsColors.colorBlue2
];
List<String> _concepts = ['Refraction', 'Reflection', 'Concave Lens'];

class Instructions extends StatelessWidget {
  const Instructions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<TestProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LoopsColors.primaryColor,
        title: Text(
          'Instructions',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: LoopsColors.colorWhite,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(12.sp),
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Description',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: LoopsColors.colorBlack,
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              Text(
                'This Custom test will help you understand the concept deep level and help you to score more in your exams. We are very happy to see that you have showed intrest in taking custom test.',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: LoopsColors.textColor,
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              Container(
                height: 1.sp,
                width: MediaQuery.of(context).size.width,
                color: LoopsColors.colorGrey.withOpacity(0.6),
              ),
              SizedBox(
                height: 24.h,
              ),
              Text(
                'Syllabus',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: LoopsColors.colorBlack,
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              Wrap(
                children: [
                  for (int index = 0; index < _chapter.length; index++)
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: _chapterColor[index].withOpacity(0.2),
                          borderRadius: BorderRadius.all(
                            Radius.circular(4.sp),
                          ),
                          // border: Border.all(
                          //   color: _chapterColor[index].withOpacity(0.2),
                          // ),
                        ),
                        height: 24.h,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 4.h,
                            ),
                            Text(
                              _chapter[index],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: _chapterColor[index],
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                ],
              ),
              SizedBox(
                height: 12.h,
              ),
              Container(
                height: 1.sp,
                width: MediaQuery.of(context).size.width,
                color: LoopsColors.colorGrey.withOpacity(0.6),
              ),
              SizedBox(
                height: 12.h,
              ),
              Text(
                'Tags',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: LoopsColors.colorBlack,
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              Wrap(
                children: [
                  for (int index = 0; index < _concepts.length; index++)
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: LoopsColors.colorOrange2.withOpacity(0.2),
                          borderRadius: BorderRadius.all(
                            Radius.circular(4.sp),
                          ),
                          /* border: Border.all(
                            color: LoopsColors.colorOrange2,
                          ), */
                        ),
                        height: 24.h,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 4.h,
                            ),
                            Text(
                              _concepts[index].toUpperCase(),
                              style: TextStyle(
                                color: LoopsColors.colorOrange2,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                ],
              ),
              SizedBox(
                height: 12.h,
              ),
              Container(
                height: 1.sp,
                width: MediaQuery.of(context).size.width,
                color: LoopsColors.colorGrey.withOpacity(0.6),
              ),
              SizedBox(
                height: 12.h,
              ),
              Text(
                'Prepared By',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: LoopsColors.colorBlack,
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              Wrap(
                children: [
                  for (int index = 0; index < _chapter.length; index++)
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: _chapterColor[index].withOpacity(0.2),
                          borderRadius: BorderRadius.all(
                            Radius.circular(4.sp),
                          ),
                          // border: Border.all(
                          //   color: _chapterColor[index].withOpacity(0.2),
                          // ),
                        ),
                        height: 24.h,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 4.h,
                            ),
                            Text(
                              _chapter[index],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: _chapterColor[index],
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                ],
              ),
              SizedBox(
                height: 12.h,
              ),
              Container(
                height: 1.sp,
                width: MediaQuery.of(context).size.width,
                color: LoopsColors.colorGrey.withOpacity(0.6),
              ),
              SizedBox(
                height: 12.h,
              ),
              Text(
                'Marks',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: LoopsColors.colorBlack,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 160.h,
                child: CustomTable(columns: const [
                  'Type',
                  'Easy',
                  'Medium',
                  'Hard'
                ], rows: [
                  const ['Correct', 'Incorrect', 'Partial'],
                  Provider.of<TestProvider>(context, listen: false)
                      .testInstructionsEntity
                      .marksDistribution!
                      .easy!,
                  Provider.of<TestProvider>(context, listen: false)
                      .testInstructionsEntity
                      .marksDistribution!
                      .medium!,
                  Provider.of<TestProvider>(context, listen: false)
                      .testInstructionsEntity
                      .marksDistribution!
                      .hard!,
                ]),
              ),
              SizedBox(
                height: 12.h,
              ),
              Container(
                height: 1.sp,
                width: MediaQuery.of(context).size.width,
                color: LoopsColors.colorGrey.withOpacity(0.6),
              ),
              SizedBox(
                height: 12.h,
              ),
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
              SizedBox(
                height: 12.h,
              ),
              SizedBox(
                height: 12.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    width: MediaQuery.of(context).size.width / 1.1,
                    lable: 'Start',
                    onTap: () {},
                  ),
                  /* CustomButton(
                    width: 165.w,
                    lable: 'Combat',
                    onTap: () {},
                  ), */
                ],
              ),
              /*  PieChart(
                dataMap: dataMap,
                animationDuration: const Duration(milliseconds: 800),
                chartLegendSpacing: 32,
                chartRadius: MediaQuery.of(context).size.width / 3.2,
                // colorList: colorList,
                initialAngleInDegree: 0,
                chartType: ChartType.ring,
                ringStrokeWidth: 32,
                centerText: "",
        
                legendOptions: const LegendOptions(
                  legendTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                chartValuesOptions: const ChartValuesOptions(
                  showChartValueBackground: false,
                  showChartValues: false,
                ),
                // gradientList: ---To add gradient colors---
                // emptyColorGradient: ---Empty Color gradient---
              ), */
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
 */
