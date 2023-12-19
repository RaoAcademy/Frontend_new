import 'package:curved_progress_bar/curved_progress_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rao_academy/application/other/other_provider.dart';
import 'package:rao_academy/application/test/test_provider.dart';
import 'package:rao_academy/core/theme/custom_scroll_behaviour.dart';
import 'package:rao_academy/core/theme/theme.dart';
import 'package:rao_academy/core/utli/loops_urls.dart';
import 'package:rao_academy/core/widgets/box_corner_time.dart';
import 'package:rao_academy/core/widgets/container_with_border.dart';
import 'package:rao_academy/core/widgets/rounded_corner_list.dart';
import 'package:rao_academy/domain/entities/analytics_data_entity.dart';
import 'package:rao_academy/domain/entities/subject_list_entity.dart';
import 'package:rao_academy/domain/entities/time_entity.dart';

import '../../application/home/home_provider.dart';
import '../core/custom_bar_charts.dart';

String? _selectedAnalytics = 'Good Behavior';

List<Time> _time = [];
List<SubjectList> _subjectsX = [];
List<String> _subjectsName = [];
List<AnalyticData> _activity = [];
List<AnalyticData> _progress = [];
List<AnalyticData> _performance = [];
List<List<AnalyticData>> _data = [];
List<double> _subjectwiseValueList = [];
final List<String> _subjectList = [
  'Biology',
  'Chemistry',
  'Economics',
  'General',
  'Geography',
  'History',
  'Maths',
  'Physics',
  'Political Science'
];
List<AnalyticData> activity = [];
List<AnalyticData> progress = [];
List<AnalyticData> performance = [];
int _selectedIndex03 = 7;
// String? _selectedAnalytics;

GlobalKey<ScaffoldState> scaffoldKey01 = GlobalKey<ScaffoldState>();
GlobalKey<ScaffoldState> scaffoldKey02 = GlobalKey<ScaffoldState>();
GlobalKey<ScaffoldState> scaffoldKey03 = GlobalKey<ScaffoldState>();
GlobalKey<ScaffoldState> scaffoldKey04 = GlobalKey<ScaffoldState>();
GlobalKey<ScaffoldState> scaffoldKey05 = GlobalKey<ScaffoldState>();

extension Ex on double {
  double toPrecision(int n) => double.parse(toStringAsFixed(n));
}

class Reports extends StatefulWidget {
  const Reports({Key? key}) : super(key: key);

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {

  var progressJson;

  @override
  void initState() {


    context.read<OtherProvider>().currentTab = 0;
    changeTimeData();

    super.initState();
  }

  changeTimeData(){
    _time.clear();
    _subjectsX.clear();
    _subjectsName.clear();
    _activity.clear();
    _progress.clear();
    _performance.clear();
    _data.clear();
    _subjectwiseValueList.clear();
    final TestProvider provider = context.read<TestProvider>();
    final reports = provider.reportsEntity;
    reports.subjectList?.forEach((element) {
      _subjectsName.add(element.name!);
      _subjectsX.add(element);

      _subjectwiseValueList.add(element.confidence!.toDouble());
    });
    reports.time?.forEach((element) {
      _time.add(element);
    });
    reports.badge?.activity?.toJson().entries.forEach((element) {
      _activity.add(
          AnalyticData(element.key, double.parse(element.value.toString())));
    });
    reports.badge?.performance?.toJson().entries.forEach((element) {
      _performance.add(
          AnalyticData(element.key, double.parse(element.value.toString())));
    });
    // reports.badge?.progress?.monday?.toJson().entries.forEach((element) {
    //   _progress.add(
    //       AnalyticData(element.key, double.parse(element.value.toString())));
    // });
    progressJson = reports.badge?.progress;
    if(progressJson != null){
      _progress.add(AnalyticData(
          "Mon", double.parse(progressJson[_subjectList.first].mon.toString())));

      _progress.add(AnalyticData(
          "Tue", double.parse(progressJson[_subjectList.first].tue.toString())));
      _progress.add(AnalyticData(
          "Wed", double.parse(progressJson[_subjectList.first].wed.toString())));
      _progress.add(AnalyticData(
          "Thu", double.parse(progressJson[_subjectList.first].thu.toString())));
      _progress.add(AnalyticData(
          "Fri", double.parse(progressJson[_subjectList.first].fri.toString())));
      _progress.add(AnalyticData(
          "Sat", double.parse(progressJson[_subjectList.first].sat.toString())));
      _progress.add(AnalyticData(
          "Sun", double.parse(progressJson[_subjectList.first].sun.toString())));

    }
    _data.add(_activity);
    _data.add(_performance);
    _data.add(_progress);
    try {
      scaffoldKey01.currentState?.closeDrawer();
      // ignore: avoid_catches_without_on_clauses
    } catch (_) {}
    Provider.of<TestProvider>(context, listen: false).subjectId =
        Provider.of<HomeProvider>(context, listen: false)
            .homeEntity
            .defaultSubjectId!
            .toInt();
    activity.clear();
    if (Provider.of<HomeProvider>(context, listen: false)
        .homeEntity
        .reports
        ?.activity !=
        null) {
      Provider.of<HomeProvider>(context, listen: false)
          .homeEntity
          .reports!
          .activity!
          .toJson()
          .forEach((key, value) {
        activity.add(AnalyticData(
            key, double.parse(value?.toString() ?? '0').abs().toPrecision(2)));
      });
    }

    progress.clear();
    if (Provider.of<HomeProvider>(context, listen: false).homeEntity.reports !=
        null &&
        Provider.of<HomeProvider>(context, listen: false)
            .homeEntity
            .reports!
            .progress !=
            null) {
      Provider.of<HomeProvider>(context, listen: false)
          .homeEntity
          .reports!
          .progress!
          .toJson()
          .forEach((key01, value) {
        (value as Map<String, dynamic>).forEach((key02, value) {
          if (key02 == 'Biology') {
            progress.add(AnalyticData(
                key01, double.parse(value.toString()).abs().toPrecision(2)));
          }
        });
      });
    }

    performance.clear();
    if (Provider.of<HomeProvider>(context, listen: false).homeEntity.reports !=
        null &&
        Provider.of<HomeProvider>(context, listen: false)
            .homeEntity
            .reports!
            .performance !=
            null) {
      Provider.of<HomeProvider>(context, listen: false)
          .homeEntity
          .reports!
          .performance!
          .toJson()
          .forEach((key, value) {
        performance.add(AnalyticData(
            key, double.parse(value.toString()).abs().toPrecision(2)));
      });
    }
    if (Provider.of<HomeProvider>(context, listen: false)
        .homefaQsEntity
        .isNotEmpty) {
      _selectedAnalytics = Provider.of<HomeProvider>(context, listen: false)
          .homefaQsEntity
          .first
          .question;
    } else {
      _selectedAnalytics = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    // final provider = context.watch<OtherProvider>();
    final TestProvider provider = context.watch<TestProvider>();
    final homeProvider = context.watch<HomeProvider>();

    final List<String> analytics = [
      'Good Behavior',
      'Bad Behavior',
    ];

    if (_selectedAnalytics == null ||
        (_selectedAnalytics != analytics.first &&
            _selectedAnalytics != analytics.last)) {
      _selectedAnalytics = analytics.first;
    }
    return Scaffold(
      body: Column(
        children: [
          ContainerWithBorder(
            margin: EdgeInsets.all(8.sp),
            boxShadow: [
              BoxShadow(
                  blurRadius: 10,
                  color: LoopsColors.lightGrey.withOpacity(0.4),
                  offset: Offset(5.sp, 5.sp))
            ],
            height: 64.h,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Provider.of<OtherProvider>(context, listen: false)
                        .routeNames
                        .remove(
                            Provider.of<OtherProvider>(context, listen: false)
                                .routeNames
                                .last);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: LoopsColors.tertiaryColor,
                    size: 24.sp,
                  ),
                ),
                SizedBox(
                  width: 12.w,
                ),
                Text(
                  'Reports',
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: LoopsColors.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: ScrollConfiguration(
            behavior: MyBehavior(),
            child: Padding(
              padding: EdgeInsets.only(left: 8.sp, right: 8.sp),
              child: ListView(
                children: [
                  SizedBox(
                    height: 4.h,
                  ),
                  BoxCornerTime(textList: _time, getValue: (value) async{
                    await Provider.of<TestProvider>(context, listen: false)
                        .freports(value.values.toString().replaceAll("(", "").replaceAll(")", "")).then((value){
                      changeTimeData();
                          Navigator.pop(context);

                    });
                    if (kDebugMode) {
                      print(value);
                    }
                  }),
                  SizedBox(
                    height: 94.h,
                    child: ScrollConfiguration(
                      behavior: MyBehavior(),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: provider.subjectListx.length,
                        itemBuilder: (context, index) {
                          final double value = index == 0
                              ? (provider.reportsEntity.confidence?.toDouble() ?? 0)
                              : index == 1
                                  ? (provider.reportsEntity.score?.toDouble() ?? 0 )
                                  : index == 2
                                      ? (provider.reportsEntity.tests?.toDouble() ?? 0)
                                      : index == 3
                                          ? (provider.reportsEntity.performance
                                                  ?.toDouble() ??
                                              0)
                                          : (provider.reportsEntity.accuracy
                                                  ?.toDouble() ??
                                              0);
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.sp, vertical: 8.sp),
                            child: Container(
                              height: 76.h,
                              width: 184.w,
                              decoration: BoxDecoration(
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
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 0,
                                    bottom: 0,
                                    left: 0,
                                    child: Center(
                                      child: ContainerWithBorder(
                                        borderRadius: 12.sp,
                                        height: 70.h,
                                        width: 5.w,
                                        boxColor: LoopsColors.colorsList02[
                                            index %
                                                LoopsColors
                                                    .colorsList02.length],
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Center(
                                        child: Text(
                                          provider.subjectListx[index],
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                            color: LoopsColors.colorBlack,
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Stack(
                                          children: [
                                            SizedBox(
                                              height: 62.sp,
                                              width: 62.sp,
                                              child:
                                                  CurvedCircularProgressIndicator(
                                                strokeWidth: 6.sp,
                                                animationDuration:
                                                    const Duration(seconds: 3),
                                                value: value,
                                                color: LoopsColors.colorsList02[
                                                    index %
                                                        LoopsColors.colorsList02
                                                            .length],
                                                backgroundColor: LoopsColors
                                                    .colorsList02[index %
                                                        LoopsColors.colorsList02
                                                            .length]
                                                    .withOpacity(0.3),
                                              ),
                                            ),
                                            Positioned(
                                              top: 0,
                                              bottom: 0,
                                              right: 0,
                                              left: 0,
                                              child: Center(
                                                child: Text(
                                                  '${(value).toStringAsFixed(2)}%',
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color:
                                                        LoopsColors.colorBlack,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  ContainerWithBorder(
                    boxShadow: [
                      BoxShadow(blurRadius: 12.sp, color: LoopsColors.lightGrey)
                    ],
                    width: MediaQuery.of(context).size.width,
                    borderRadius: 12.sp,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: 24.w, right: 24.w, top: 20.h,
                            // vertical: 20.h,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Subject Wise',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      color: LoopsColors.colorBlack,
                                    ),
                                  ),
                                  /* Text(
                                    'Loops',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      color: LoopsColors.textColor.withOpacity(0.5),
                                    ),
                                  ), */
                                ],
                              ),
                              /* Row(
                                children: [
                                  Text(
                                    'Show data:',
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w600,
                                      color: LoopsColors.colorBlack
                                          .withOpacity(0.5),
                                      letterSpacing: 0.03.sp,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  SizedBox(
                                    width: 70.w,
                                    child: PopupMenuButton<int>(
                                      icon: Text(
                                        _subjectsX[_selectedIndex03].name ?? '',
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w600,
                                          color: LoopsColors.primaryColor,
                                          letterSpacing: 0.03.sp,
                                        ),
                                      ),
                                      onSelected: (index) {
                                        _selectedIndex03 = index;
                                        provider.setState();
                                      },
                                      itemBuilder: (context) {
                                        return <PopupMenuEntry<int>>[
                                          for (var i = 0;
                                              i < _subjectsX.length;
                                              i++)
                                            PopupMenuItem(
                                                value: i,
                                                child: Text(
                                                  _subjectsX[i].name ?? '',
                                                  style: TextStyle(
                                                    fontSize: 10.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color: LoopsColors
                                                        .primaryColor,
                                                    letterSpacing: 0.03.sp,
                                                  ),
                                                )),
                                        ];
                                      },
                                    ),
                                  ),
                                ],
                              ), */
                            ],
                          ),
                        ),
                        RoundedCornerList(
                          textList: provider.subjectListx,
                          getValue: (value) {
                            _subjectwiseValueList.clear();
                            switch (value.keys.first) {
                              case 0:
                                _subjectsX.forEach((element) {
                                  _subjectwiseValueList
                                      .add(element.confidence!.toDouble());
                                });
                                break;
                              case 1:
                                _subjectsX.forEach((element) {
                                  _subjectwiseValueList
                                      .add(element.score!.toDouble());
                                });
                                break;
                              case 2:
                                _subjectsX.forEach((element) {
                                  _subjectwiseValueList
                                      .add(element.tests!.toDouble());
                                });
                                break;
                              case 3:
                                _subjectsX.forEach((element) {
                                  _subjectwiseValueList.add(
                                      element.performance?.toDouble() ?? 0);
                                });
                                break;
                              default:
                                _subjectsX.forEach((element) {
                                  _subjectwiseValueList
                                      .add(element.accuracy!.toDouble());
                                });
                                break;
                            }
                            Provider.of<TestProvider>(context, listen: false)
                                .setState();
                          },
                        ),
                        SizedBox(
                          height: 172.h,
                          child: ListView.builder(
                              itemCount: _subjectsX.length,
                              itemBuilder: (context, index) => SizedBox(
                                    height: 33.h,
                                    width: MediaQuery.of(context).size.width,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 80.w,
                                          child: Center(
                                              child: Text(
                                                  _subjectsX[index].name ??
                                                      '')),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 24.w),
                                            child:
                                                CurvedLinearProgressIndicator(
                                              color: LoopsColors.colorsList01[
                                                  index %
                                                      LoopsColors
                                                          .colorsList01.length],
                                              value:
                                                  _subjectwiseValueList[index] /
                                                      100.0,
                                              backgroundColor: LoopsColors
                                                  .lightGrey
                                                  .withOpacity(0.5),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 46.sp,
                                          child: Row(
                                            children: [
                                              Text(
                                                  '${_subjectwiseValueList[index].toInt()}%'),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  SizedBox(
                    height: 320.h,
                    width: MediaQuery.of(context).size.width,
                    child: ScrollConfiguration(
                      behavior: MyBehavior(),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return ContainerWithBorder(
                            margin: EdgeInsets.only(right: 12.w),
                            borderColor: LoopsColors.colorGrey,
                            borderRadius: 10.sp,
                            width: 300.w,
                            child: Column(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 12.sp, left: 12.sp, right: 12.sp),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          index == 0
                                              ? 'Activity'
                                              : index == 1
                                                  ? 'Progress'
                                                  : 'Performance',
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,

                                            letterSpacing: 0.03.sp,
                                          ),
                                        ),
                                        if (index == 1 &&
                                            _subjectList.isNotEmpty)
                                          Row(
                                            children: [
                                              Text(
                                                'Show data:',
                                                style: TextStyle(
                                                  fontSize: 10.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: LoopsColors.colorBlack
                                                      .withOpacity(0.5),
                                                  letterSpacing: 0.03.sp,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 8.w,
                                              ),
                                              if (_subjectList.isNotEmpty)
                                                SizedBox(
                                                  width: 70.w,
                                                  child: PopupMenuButton<int>(
                                                    icon: Text(
                                                      _subjectList[
                                                          _selectedIndex03],
                                                      style: TextStyle(
                                                        fontSize: 10.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: LoopsColors
                                                            .primaryColor,
                                                        letterSpacing: 0.03.sp,
                                                      ),
                                                    ),
                                                    onSelected: (indexX) {
                                                      _selectedIndex03 = indexX;
                                                      _progress.clear();
                                                      _progress.add(AnalyticData("Mon", double.parse(progressJson['Mon'][_subjectList[
                                                          _selectedIndex03]].toString())));
                                                      _progress.add(AnalyticData("Tue", double.parse(progressJson['Tue'][_subjectList[
                                                          _selectedIndex03]].toString())));
                                                      _progress.add(AnalyticData("Wed", double.parse(progressJson['Wed'][_subjectList[
                                                          _selectedIndex03]].toString())));
                                                      _progress.add(AnalyticData("Thu", double.parse(progressJson['Thu'][_subjectList[
                                                          _selectedIndex03]].toString())));
                                                      _progress.add(AnalyticData("Fri", double.parse(progressJson['Fri'][_subjectList[
                                                          _selectedIndex03]].toString())));
                                                      _progress.add(AnalyticData("Sat", double.parse(progressJson['Sat'][_subjectList[
                                                          _selectedIndex03]].toString())));
                                                      _progress.add(AnalyticData("Sun", double.parse(progressJson['Sun'][_subjectList[
                                                          _selectedIndex03]].toString())));
                                                      setState(() {

                                                      });
                                                      // progress.clear();
                                                      // if (Provider.of<HomeProvider>(
                                                      //                 context,
                                                      //                 listen:
                                                      //                     false)
                                                      //             .homeEntity
                                                      //             .reports !=
                                                      //         null &&
                                                      //     Provider.of<HomeProvider>(
                                                      //                 context,
                                                      //                 listen:
                                                      //                     false)
                                                      //             .homeEntity
                                                      //             .reports!
                                                      //             .progress !=
                                                      //         null) {
                                                      //   Provider.of<HomeProvider>(
                                                      //           context,
                                                      //           listen: false)
                                                      //       .homeEntity
                                                      //       .reports!
                                                      //       .progress!
                                                      //       .toJson()
                                                      //       .forEach(
                                                      //           (key01, value) {
                                                      //     (value as Map<String,
                                                      //             dynamic>)
                                                      //         .forEach((key02,
                                                      //             value) {
                                                      //       if (key02 ==
                                                      //           _subjectList[
                                                      //               indexX]) {
                                                      //         progress.add(AnalyticData(
                                                      //             key01,
                                                      //             double.parse(value
                                                      //                     .toString())
                                                      //                 .abs()
                                                      //                 .toPrecision(
                                                      //                     2)));
                                                      //       }
                                                      //     });
                                                      //   });
                                                      // }
                                                      // homeProvider.setState();
                                                    },
                                                    itemBuilder: (context) {
                                                      return <PopupMenuEntry<
                                                          int>>[
                                                        for (var i = 0;
                                                            i <
                                                                _subjectList
                                                                    .length;
                                                            i++)
                                                          PopupMenuItem(
                                                              value: i,
                                                              child: Text(
                                                                _subjectList[i],
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      10.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: LoopsColors
                                                                      .primaryColor,
                                                                  letterSpacing:
                                                                      0.03.sp,
                                                                ),
                                                              )),
                                                      ];
                                                    },
                                                  ),
                                                ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                    flex: 5,
                                    child: /* SfCartesianChart(
                                  plotAreaBorderWidth: 0,
                                  primaryXAxis: CategoryAxis(
                                    majorTickLines: MajorTickLines(size: 0.sp),
                                    majorGridLines:
                                        const MajorGridLines(width: 0),
                                    axisLine: const AxisLine(width: 0),
                                  ),
                                  primaryYAxis: NumericAxis(
                                    majorTickLines: MajorTickLines(size: 0.sp),
                                    majorGridLines: MajorGridLines(
                                      width: 0.5.sp,
                                      color: LoopsColors.lightGrey,
                                    ),
                                    axisLine: const AxisLine(width: 0),
                                  ),
                                  title: ChartTitle(
                                    text: 'Tests',
                                    alignment: ChartAlignment.near,
                                    textStyle: TextStyle(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w400,
                                      color: LoopsColors.textColor,
                                      letterSpacing: 0.03.sp,
                                    ),
                                  ),
                                  series: <ChartSeries<AnalyticData, String>>[
                                    SplineSeries<AnalyticData, String>(
                                        dataSource: index == 0
                                            ? activity
                                            : index == 1
                                                ? progress
                                                : performance,
                                        xValueMapper: (AnalyticData tests, _) =>
                                            tests.day,
                                        yValueMapper: (AnalyticData tests, _) =>
                                            tests.tests,
                                        width: 2,
                                        color: LoopsColors
                                            .colorsList03[index % 3]),
                                  ],
                                ), */
                                        /* Scrollbar(
                              thumbVisibility: false,
                              radius: Radius.circular(12.sp),
                              child: ListView.builder(
                                  // scrollDirection: Axis.horizontal,
                                  physics: const NeverScrollableScrollPhysics(),
                                  controller: _scroll,
                                  itemCount: activity
                                      .length,
                                  itemBuilder: (context, index) => SizedBox(
                                        height: 32.h,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 80.w,
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(left: 8.sp),
                                                child: Text(
                                                  activity[index]
                                                      .day,
                                                  overflow: TextOverflow.fade,
                                                  maxLines: 1,
                                                  textAlign: TextAlign.start,
                                                  /* style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14.sp,
                                                color: LoopsColors.colorBlack,
                                                  ),
                                                  textAlign: TextAlign.end, */
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 24.w),
                                                child:
                                                    CurvedLinearProgressIndicator(
                                                  color:
                                                      LoopsColors.colorsList01[
                                                          index %
                                                              LoopsColors
                                                                  .colorsList01
                                                                  .length],
                                                  value: (activity[
                                                              index].tests %
                                                          100) /
                                                      100,
                                                  backgroundColor: LoopsColors
                                                      .lightGrey
                                                      .withOpacity(0.5),
                                                ),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  (activity[
                                                              index].tests %
                                                          100)
                                                      .toStringAsFixed(1),
                                                  overflow: TextOverflow.fade,
                                                  maxLines: 1,
                                                  textAlign: TextAlign.start,
                                                  /* style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14.sp,
                                                    color: LoopsColors.colorBlack,
                                                      ),
                                                      textAlign: TextAlign.end, */
                                                ),
                                                SizedBox(
                                                  width: 12.w,
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      )),
                            ), */
                                        CustomBarChart(
                                      data: index == 0
                                          ? _activity
                                          : index == 1
                                              ? _progress
                                              : _performance,
                                    )),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Text(
                    'Insights',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: LoopsColors.colorBlack,
                      letterSpacing: 0.03.sp,
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  /* BehaviourBox(
                    title: 'Good Behaviour',
                    color: LoopsColors.colorsList02[0],
                    dataList: chartDataType,
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  BehaviourBox(
                    title: 'Bad Behaviour',
                    color: LoopsColors.colorsList02[1],
                    dataList: chartDataType,
                  ), */
                  Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Wrap(
                          spacing: 12.sp,
                          runSpacing: 12.sp,
                          children: [
                            for (var item in analytics)
                              ContainerWithBorder(
                                height: 32.h,
                                borderRadius: 14.sp,
                                borderColor: _selectedAnalytics == item
                                    ? LoopsColors.secondaryColor.withOpacity(0)
                                    : LoopsColors.primaryColor,
                                width: item.characters.length * 8.7.w,
                                boxColor: _selectedAnalytics == item
                                    ? LoopsColors.secondaryColor
                                        .withOpacity(0.2)
                                    : LoopsColors.colorWhite,
                                child: InkWell(
                                  onTap: () {
                                    _selectedAnalytics = item;
                                    provider.setState();
                                  },
                                  child: Text(
                                    item,
                                    style:
                                        appTheme.textTheme.bodyLarge!.copyWith(
                                      // fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      color: LoopsColors.primaryColor,
                                      letterSpacing: 0.1.sp,
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
                      ContainerWithBorder(
                        // height: 205.h,
                        width: 364.w,
                        borderRadius: 10.sp,
                        // borderColor: LoopsColors.primaryColor,
                        boxColor: LoopsColors.secondaryColor.withOpacity(0.2),
                        child: Padding(
                          padding: EdgeInsets.all(12.sp),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  for (int i = 0;
                                      i <
                                          (_selectedAnalytics == analytics.first
                                              ? (provider.reportsEntity.insights
                                                      ?.goodBehaviour?.length ??
                                                  0)
                                              : (provider.reportsEntity.insights
                                                      ?.badBehaviour?.length ??
                                                  0));
                                      i++)
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ContainerWithBorder(
                                            height: 6.sp,
                                            width: 6.sp,
                                            boxColor: LoopsColors.primaryColor,
                                            borderRadius: 12.sp,
                                          ),
                                        ),
                                        Text(
                                          _selectedAnalytics == analytics.first
                                              ? (provider.reportsEntity.insights
                                                      ?.goodBehaviour?[i] ??
                                                  '')
                                              : provider.reportsEntity.insights
                                                      ?.badBehaviour?[i] ??
                                                  '',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                            color: LoopsColors.primaryColor,
                                            letterSpacing: 0.1.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}

List<String> chartDataType = [
  'Activity',
  'Progress',
  'Performance',
];

void openTheDrawer() {
  scaffoldKey01.currentState?.openDrawer();
  scaffoldKey02.currentState?.openDrawer();
  scaffoldKey03.currentState?.openDrawer();
  scaffoldKey04.currentState?.openDrawer();
  scaffoldKey05.currentState?.openDrawer();
}

void closeTheDrawer() {
  scaffoldKey01.currentState?.openEndDrawer();
  scaffoldKey02.currentState?.openEndDrawer();
  scaffoldKey03.currentState?.openEndDrawer();
  scaffoldKey04.currentState?.openEndDrawer();
  scaffoldKey05.currentState?.openEndDrawer();
}

bool get isDrawerOpen {
  if (scaffoldKey01.currentState == null &&
      scaffoldKey02.currentState == null &&
      scaffoldKey03.currentState == null &&
      scaffoldKey04.currentState == null &&
      scaffoldKey05.currentState == null) {
    // gotoHomePage(navigatorKey.currentContext!);
  }
  return scaffoldKey01.currentState?.isDrawerOpen ??
      scaffoldKey02.currentState?.isDrawerOpen ??
      scaffoldKey03.currentState?.isDrawerOpen ??
      scaffoldKey04.currentState?.isDrawerOpen ??
      scaffoldKey05.currentState?.isDrawerOpen ??
      false;
}
