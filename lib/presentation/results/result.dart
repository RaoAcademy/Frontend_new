import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:EdTestz/application/test/test_provider.dart';
import 'package:EdTestz/core/theme/custom_scroll_behaviour.dart';
import 'package:EdTestz/core/theme/theme.dart';
import 'package:EdTestz/core/utli/bargraph.dart';
import 'package:EdTestz/core/utli/error_handle.dart';
import 'package:EdTestz/core/utli/goto_pages.dart';
import 'package:EdTestz/core/utli/loops_urls.dart';
import 'package:EdTestz/core/widgets/coin.dart';
// import 'package:EdTestz/core/utli/logger.dart';
import 'package:EdTestz/core/widgets/container_with_border.dart';
import 'package:EdTestz/domain/entities/analytics_data_entity.dart';
import 'package:EdTestz/domain/entities/recommendations_entity.dart';
import 'package:EdTestz/presentation/core/custom_bar_charts.dart';
import 'package:EdTestz/presentation/results/widgets/answer_keys.dart';
import 'package:EdTestz/presentation/results/widgets/item_with_text.dart';
import 'package:EdTestz/presentation/results/widgets/marks.dart';

class Results extends StatefulWidget {
  final int index;

  const Results({Key? key, required this.index}) : super(key: key);

  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  void initState() {
    final TestProvider provider = context.read<TestProvider>();
    provider.questionTypeAccuracy.clear();
    provider.difficultyTypeAccuracy.clear();
    if (kDebugMode) {
      print(provider.testResultsEntity.practiceTest);
    }

    if (provider.testResultsEntity.questionFormat != null) {
      provider.testResultsEntity.questionFormat!.forEach((element) {
        // ignore: no_leading_underscores_for_local_identifiers
        final List<AnalyticData> _temp = [];
        _temp.add(AnalyticData('Correct', element.correctTotal!.toDouble()));
        _temp
            .add(AnalyticData('Incorrect', element.incorrectTotal!.toDouble()));
        _temp.add(AnalyticData('P Correct', element.partialTotal!.toDouble()));
        _temp.add(AnalyticData('NA', element.notAnsweredTotal!.toDouble()));
        provider.questionTypeAccuracy.add(_temp);
        questionTypeTime[element.format.toString()] = element.time!;
      });
    }
    if (provider.testResultsEntity.difficultyLevel != null) {
      provider.testResultsEntity.difficultyLevel!.forEach((element) {
        // ignore: no_leading_underscores_for_local_identifiers
        final List<AnalyticData> _temp = [];
        _temp.add(AnalyticData('Correct', element.correctTotal!.toDouble()));
        _temp
            .add(AnalyticData('Incorrect', element.incorrectTotal!.toDouble()));
        _temp.add(AnalyticData('P Correct', element.partialTotal!.toDouble()));
        _temp.add(AnalyticData('NA', element.notAnsweredTotal!.toDouble()));
        provider.difficultyTypeAccuracy.add(_temp);
        difficultyTypeTime[element.level.toString()] = element.time!;
        if (kDebugMode) {
          print(element.level);
        }
      });
    }
    if (kDebugMode) {
      print("init State in Results");
    }
    // difficultyTypeTime = {
    //   'Easy': provider.testResultsEntity.difficultyLevel;
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    if (kDebugMode) {
      print("Result parameter");
      print(widget.index);
    }
    // final int parameterValue = arguments['index'];
    final TestProvider provider = context.watch<TestProvider>();
    //onWillPop: () => onWillPop(context),
    return WillPopScope(
      onWillPop: () async {
        goSpecificBack(context, widget.index);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              goSpecificBack(context, widget.index);
              // goBack(context);
              // Navigator.of(context, rootNavigator: true).pop(context);

              // Navigator.pushReplacementNamed(context, '/testHistory');

              // Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: LoopsColors.whiteBkground,
              size: 24.sp,
            ),
          ),
          backgroundColor: LoopsColors.primaryColor,
          title: Text(
            'Results',
            style: appTheme.textTheme.headlineMedium!
                .copyWith(color: LoopsColors.colorWhite),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ContainerWithBorder(
                boxColor: LoopsColors.whiteBkground,
                borderRadius: 4.sp,
                borderColor: LoopsColors.textColor,
                padding: EdgeInsets.all(10.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ItemWithText(
                      title: 'Accuracy',
                      info: Column(
                        children: [
                          Text(
                            '${provider.testResultsEntity.accuracy}%',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: LoopsColors.colorBlack,
                            ),
                          ),
                          SizedBox(
                            height: 4.h,
                          )
                        ],
                      ),
                      icon: Icons.add_circle_outline,
                    ),
                    ItemWithText(
                      title: 'Score',
                      info: Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                provider.testResultsEntity.score!
                                    .split('/')
                                    .first,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: LoopsColors.colorBlack,
                                ),
                              ),
                              SizedBox(
                                height: 4.h,
                              )
                            ],
                          ),
                          Text(
                            '/${provider.testResultsEntity.score!.split('/').last}',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: LoopsColors.colorGrey.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                      icon: Icons.speed,
                    ),
                    ItemWithText(
                      title: 'Performance',
                      info: Column(
                        children: [
                          Text(provider.testResultsEntity.performance ?? '',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: LoopsColors.colorBlack,
                                fontWeight: FontWeight.w600,
                              )),
                          Row(
                            children: [
                              for (int i = 1; i <= 4; i++)
                                Icon(
                                  Icons.star,
                                  size: 12.sp,
                                  color: ((provider.testResultsEntity
                                                          .performance ==
                                                      'Excellent'
                                                  ? 5
                                                  : provider.testResultsEntity
                                                              .performance ==
                                                          'Average'
                                                      ? 4
                                                      : provider.testResultsEntity
                                                                  .performance ==
                                                              'Good'
                                                          ? 3
                                                          : provider.testResultsEntity
                                                                      .performance ==
                                                                  'Bad'
                                                              ? 2
                                                              : 1) /
                                              i >
                                          1)
                                      ? LoopsColors.tertiaryColor
                                      : LoopsColors.colorGrey,
                                )
                            ],
                          ),
                        ],
                      ),
                      icon: Icons.add_chart_rounded,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: ListView(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 24.h,
                          ),
                          Text('Question Type',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16.sp,
                                color: LoopsColors.colorBlack,
                              )),
                          SizedBox(
                            height: 12.sp,
                          ),
                          DefaultTabController(
                            length: 2,
                            child: Column(
                              children: [
                                Container(
                                  height: 46.h,
                                  padding: EdgeInsets.zero,
                                  margin: EdgeInsets.zero,
                                  decoration: BoxDecoration(
                                    color: LoopsColors.primaryColor,
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(10.sp),
                                    ),
                                  ),
                                  child: TabBar(
                                      indicatorColor: LoopsColors.tertiaryColor,
                                      indicatorPadding: const EdgeInsets.only(
                                        left: 32.0,
                                        right: 32.0,
                                      ),
                                      tabs: <Tab>[
                                        Tab(
                                            icon: Text('Accuracy',
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w600,
                                                ))),
                                        Tab(
                                          icon: Text(
                                            'Time',
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ]),
                                ),
                                SizedBox(
                                  height: 390.h,
                                  width: 380.w,
                                  child: TabBarView(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    children: [
                                      ContainerWithBorder(
                                          borderColor: LoopsColors.colorGrey,
                                          boxColor: LoopsColors.lightGrey
                                              .withOpacity(0.5),
                                          margin: EdgeInsets.only(bottom: 2.h),
                                          borderR: BorderRadius.only(
                                            bottomLeft: Radius.circular(10.sp),
                                            bottomRight: Radius.circular(10.sp),
                                          ),
                                          height: 315.h,
                                          width: 275.w,
                                          child: ScrollConfiguration(
                                            behavior: MyBehavior(),
                                            child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: provider
                                                    .questionTypeAccuracy
                                                    .length,
                                                itemBuilder: (context, index) {
                                                  return ContainerWithBorder(
                                                      margin:
                                                          const EdgeInsets.all(
                                                              18.0),
                                                      height: 315.h,
                                                      width: 290.w,
                                                      boxColor: LoopsColors
                                                          .colorWhite,
                                                      borderRadius: 10.sp,
                                                      // borderColor: LoopsColors.textColor,
                                                      boxShadow: [
                                                        BoxShadow(
                                                            blurRadius: 10,
                                                            color: LoopsColors
                                                                .colorGrey
                                                                .withOpacity(
                                                                    0.2),
                                                            offset: Offset(
                                                                5.sp, 5.sp))
                                                      ],
                                                      child: Column(
                                                        children: [
                                                          ContainerWithBorder(
                                                            height: 55.h,
                                                            // borderColor: LoopsColors.textColor,
                                                            borderRadius: 10.sp,
                                                            padding:
                                                                EdgeInsets.only(
                                                              left: 10.sp,
                                                            ),
                                                            child: Row(
                                                              children: [
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                      provider
                                                                          .testResultsEntity
                                                                          .questionFormat![
                                                                              index]
                                                                          .format!,
                                                                      style: const TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          4.h,
                                                                    ),
                                                                    Text(
                                                                        '${provider.testResultsEntity.questionFormat![index].totalQuestions} Questions',
                                                                        style:
                                                                            TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontSize:
                                                                              12.sp,
                                                                        ))
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          ContainerWithBorder(
                                                            height: 1.sp,
                                                            boxColor:
                                                                LoopsColors
                                                                    .lightGrey,
                                                          ),
                                                          Expanded(
                                                            child: Center(
                                                              child: Stack(
                                                                children: [
                                                                  CustomBarChart(
                                                                    data: provider
                                                                            .questionTypeAccuracy[
                                                                        index],
                                                                  )
                                                                  /* SfCartesianChart(
                                                                    plotAreaBorderWidth:
                                                                        0,
                                                                    primaryXAxis:
                                                                        CategoryAxis(
                                                                      maximumLabelWidth:
                                                                          68.w,
                                                                      labelStyle:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12.sp,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                      ),
                                                                      majorTickLines:
                                                                          MajorTickLines(
                                                                              size:
                                                                                  0.sp),
                                                                      majorGridLines:
                                                                          const MajorGridLines(
                                                                              width:
                                                                                  0),
                                                                      axisLine: AxisLine(
                                                                          width: 1
                                                                              .sp),
                                                                    ),
                                                                    primaryYAxis:
                                                                        NumericAxis(
                                                                      minimum: 0,
                                                                      maximum: 12,
                                                                      interval: 2,
                                                                      majorGridLines:
                                                                          MajorGridLines(
                                                                        width: 0.0
                                                                            .sp,
                                                                        color: LoopsColors
                                                                            .lightGrey,
                                                                      ),
                                                                      majorTickLines:
                                                                          MajorTickLines(
                                                                              size:
                                                                                  0.sp),
                                                                      axisLine:
                                                                          const AxisLine(
                                                                              width:
                                                                                  0),
                                                                      labelStyle:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            0.sp,
                                                                      ),
                                                                    ),
                                                                    series: [
                                                                      ColumnSeries<
                                                                          AnalyticData,
                                                                          String>(
                                                                        pointColorMapper:
                                                                            (datum,
                                                                                indexx) {
                                                                          return LoopsColors.colorsList01[indexx %
                                                                              LoopsColors.colorsList01.length];
                                                                        },
                                                                        spacing:
                                                                            1.sp,
                                                                        /*    dataLabelMapper: (AnalyticData
                                                                                    data,
                                                                                _) =>
                                                                            data.tests
                                                                                .toString(),
                                                                        dataLabelSettings:
                                                                            DataLabelSettings(
                                                                                color:
                                                                                    LoopsColors.colorBlack), */
                                                                        dataSource:
                                                                            provider
                                                                                .questionTypeAccuracy[index],
                                                                        xValueMapper:
                                                                            (AnalyticData data,
                                                                                _) {
                                                                          return data
                                                                              .day;
                                                                        },
                                                                        yValueMapper:
                                                                            (AnalyticData data, _) =>
                                                                                data.tests,
                                                                        // color:
                                                                      )
                                                                    ],
                                                                  ), */
                                                                  ,
                                                                  /* for (var i = 1;
                                                                      i <=
                                                                          provider
                                                                              .questionTypeAccuracy
                                                                              .length;
                                                                      i++)
                                                                    Positioned(
                                                                      bottom: ((provider.questionTypeAccuracy[index][i - 1].tests +
                                                                                  1.h) *
                                                                              18.8.h)
                                                                          .h,
                                                                      left: i.w *
                                                                              35
                                                                                  .w +
                                                                          (i > 1
                                                                              ? (i - 1) *
                                                                                  27.5.w
                                                                              : 0),
                                                                      child: Text(
                                                                        provider
                                                                            .questionTypeAccuracy[
                                                                                index]
                                                                                [
                                                                                i -
                                                                                    1]
                                                                            .tests
                                                                            .toStringAsFixed(
                                                                                0),
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              10.sp,
                                                                          fontWeight:
                                                                              FontWeight.w800,
                                                                        ),
                                                                      ),
                                                                    ), */
                                                                  Positioned(
                                                                    top: 0,
                                                                    left: 10,
                                                                    child:
                                                                        SizedBox(
                                                                      width:
                                                                          269.w,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            EdgeInsets.all(10.sp),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Text(
                                                                              'Accuracy',
                                                                              style: TextStyle(
                                                                                fontWeight: FontWeight.w600,
                                                                                fontSize: 12.5.sp,
                                                                              ),
                                                                            ),
                                                                            Text(
                                                                              '${ provider
                                                                                  .testResultsEntity
                                                                                  .questionFormat![
                                                                              index].accuracy}%',
                                                                              style: TextStyle(
                                                                                fontWeight: FontWeight.w600,
                                                                                fontSize: 18.sp,
                                                                                color: LoopsColors.colorBlack,
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  /* Positioned(
                                                                      bottom: 20.h,
                                                                      child:
                                                                          ContainerWithBorder(
                                                                        height: 1.sp,
                                                                        boxColor:
                                                                            LoopsColors.colorGrey,
                                                                      )) */
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ));
                                                }),
                                          )),
                                      ContainerWithBorder(
                                        borderColor: LoopsColors.colorGrey,
                                        boxColor: LoopsColors.colorWhite,
                                        padding: EdgeInsets.all(
                                          12.h,
                                        ),
                                        borderR: BorderRadius.only(
                                          bottomLeft: Radius.circular(10.sp),
                                          bottomRight: Radius.circular(10.sp),
                                        ),
                                        height: 315.h,
                                        width: 275.w,
                                        child: BarGraph(

                                          maxProgressLength: 0.1,
                                          maxlableWidth: 80.w,
                                          padding: EdgeInsets.all(8.sp),
                                          bgColor: LoopsColors.lightGrey
                                              .withOpacity(0.5),
                                          keyValueMap: questionTypeTime,
                                          text:
                                              'Average time taken to answer each question.',
                                        ),
                                      )
                                      /*  ContainerWithBorder(
                                            borderColor: LoopsColors.colorGrey,
                                            boxColor: LoopsColors.lightGrey.withOpacity(0.5),
                                            margin: EdgeInsets.only(bottom: 2.h),
                                            borderR: BorderRadius.only(
                                              bottomLeft: Radius.circular(10.sp),
                                              bottomRight: Radius.circular(10.sp),
                                            ),
                                            height: 315.h,
                                            width: 275.w,
                                            child: ListView.builder(
                                                scrollDirection: Axis.horizontal,
                                                itemCount: 1,
                                                itemBuilder: (context, index) {
                                                  return ContainerWithBorder(
                                                      margin: const EdgeInsets.all(
                                                          18.0),
                                                      height: 315.h,
                                                      width: 290.w,
                                                      boxColor: LoopsColors.colorWhite,
                                                      borderRadius: 10.sp,
                                                      // borderColor: LoopsColors.textColor,
                                                      boxShadow: [
                                                        BoxShadow(
                                                            blurRadius: 10,
                                                            spreadRadius: 0,
                                                            color: LoopsColors.colorGrey
                                                                .withOpacity(0.2),
                                                            offset:
                                                                Offset(5.sp, 5.sp))
                                                      ],
                                                      child: Column(
                                                        children: [
                                                          ContainerWithBorder(
                                                            height: 1.sp,
                                                            boxColor: LoopsColors.lightGrey,
                                                          ),
                                                          Expanded(
                                                            child: Center(
                                                              child: Stack(
                                                                children: [
                                                                  SfCartesianChart(
                                                                    plotAreaBorderWidth:
                                                                        0,
                                                                    primaryXAxis:
                                                                        CategoryAxis(
                                                                      maximumLabelWidth:
                                                                          70,
                                                                      // multiLevelLabels: ,
                                                                      labelStyle:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                      ),
                                                                      majorTickLines:
                                                                          MajorTickLines(
                                                                              size:
                                                                                  0.sp),
                                                                      majorGridLines:
                                                                          const MajorGridLines(
                                                                              width:
                                                                                  0),
                                                                      axisLine: AxisLine(
                                                                          width: 0.2
                                                                              .sp),
                                                                    ),
                                                                    primaryYAxis:
                                                                        NumericAxis(
                                                                      minimum: 0,
                                                                      maximum: 12,
                                                                      maximumLabelWidth:
                                                                          0,
                                                                      interval: 2,
                                                                      majorGridLines:
                                                                          MajorGridLines(
                                                                        width:
                                                                            0.0.sp,
                                                                        color:
                                                                            LoopsColors.lightGrey,
                                                                      ),
                                                                      majorTickLines:
                                                                          MajorTickLines(
                                                                              size:
                                                                                  0.sp),
                                                                      axisLine:
                                                                          const AxisLine(
                                                                              width:
                                                                                  0),
                                                                      labelStyle:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            0.sp,
                                                                      ),
                                                                    ),
                                                                    series: <
                                                                        BarSeries<
                                                                            AnalyticData,
                                                                            String>>[
                                                                      BarSeries<
                                                                          AnalyticData,
                                                                          String>(
                                                                        spacing:
                                                                            1.sp,
                                                                        /*    dataLabelMapper: (AnalyticData
                                                                                  data,
                                                                              _) =>
                                                                          data.tests
                                                                              .toString(),
                                                                      dataLabelSettings:
                                                                          DataLabelSettings(
                                                                              color:
                                                                                  LoopsColors.colorBlack), */
                                                                        dataSource:
                                                                            data2,
                                                                        xValueMapper:
                                                                            (AnalyticData
                                                                                    data2,
                                                                                _) {
                                                                          _dataDay =
                                                                              data2
                                                                                  .day;
                                                                          return data2
                                                                              .day;
                                                                        },
                                                                        yValueMapper: (AnalyticData
                                                                                    data2,
                                                                                _) =>
                                                                            data2
                                                                                .tests,
                                                                        // color: i == 0
                                                                        //     ? LoopsColors.colorGreen
                                                                        //     : i == 1
                                                                        //         ? LoopsColors.colorRed
                                                                        //         : i == 2
                                                                        //             ? LoopsColors.tertiaryColor
                                                                        //             : LoopsColors.colorGrey,
                                                                      )
                                                                    ],
                                                                  ),
                                                                  for (var i = 1;
                                                                      i <=
                                                                          data2
                                                                              .length;
                                                                      i++)
                                                                    Positioned(
                                                                      // top: 100,
                                                                      left: (((data2[i - 1].tests + 1) * 20.8)
                                                                                  .w +
                                                                              32.w +
                                                                              (10 - data2[i - 1].tests)
                                                                                  .w) +
                                                                          12.w,
                                                                      bottom: i.h *
                                                                              40.h +
                                                                          (i > 1
                                                                              ? (i - 1) *
                                                                                  36.h
                                                                              : 0) -
                                                                          (5 - i).w,
                                                                      child: Text(
                                                                        '${data2[i - 1].tests.toStringAsFixed(0)} mins',
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              10.sp,
                                                                          fontWeight:
                                                                              FontWeight
                                                                                  .w800,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ));
                                                })), */
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      //////////////////////////////////////////////
                      ///
                      ///
                      /////////////////////////////////////////////
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 24.h,
                          ),
                          Text('Difficulty Levels',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16.sp,
                                color: LoopsColors.colorBlack,
                              )),
                          SizedBox(
                            height: 12.sp,
                          ),
                          DefaultTabController(
                            length: 2,
                            child: Column(
                              children: [
                                Container(
                                  height: 46.h,
                                  padding: EdgeInsets.zero,
                                  margin: EdgeInsets.zero,
                                  decoration: BoxDecoration(
                                    color: LoopsColors.primaryColor,
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(10.sp),
                                    ),
                                  ),
                                  child: TabBar(
                                      indicatorColor: LoopsColors.tertiaryColor,
                                      indicatorPadding: const EdgeInsets.only(
                                        left: 32.0,
                                        right: 32.0,
                                      ),
                                      tabs: <Tab>[
                                        Tab(
                                            icon: Text('Accuracy',
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w600,
                                                ))),
                                        Tab(
                                            icon: Text(
                                          'Time',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )),
                                      ]),
                                ),
                                SizedBox(
                                  height: 390.h,
                                  width: 380.w,
                                  child: TabBarView(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    children: [
                                      ContainerWithBorder(
                                          borderColor: LoopsColors.colorGrey,
                                          boxColor: LoopsColors.lightGrey
                                              .withOpacity(0.5),
                                          margin: EdgeInsets.only(bottom: 2.h),
                                          borderR: BorderRadius.only(
                                            bottomLeft: Radius.circular(10.sp),
                                            bottomRight: Radius.circular(10.sp),
                                          ),
                                          height: 315.h,
                                          width: 275.w,
                                          child: ScrollConfiguration(
                                            behavior: MyBehavior(),
                                            child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: provider
                                                    .testResultsEntity
                                                    .difficultyLevel
                                                    ?.length,
                                                itemBuilder: (context, index) {
                                                  return ContainerWithBorder(
                                                      margin:
                                                          const EdgeInsets.all(
                                                              18.0),
                                                      height: 315.h,
                                                      width: 290.w,
                                                      boxColor: LoopsColors
                                                          .colorWhite,
                                                      borderRadius: 10.sp,
                                                      // borderColor: LoopsColors.textColor,
                                                      boxShadow: [
                                                        BoxShadow(
                                                            blurRadius: 10,
                                                            color: LoopsColors
                                                                .colorGrey
                                                                .withOpacity(
                                                                    0.2),
                                                            offset: Offset(
                                                                5.sp, 5.sp))
                                                      ],
                                                      child: Column(
                                                        children: [
                                                          ContainerWithBorder(
                                                            height: 55.h,
                                                            // borderColor: LoopsColors.textColor,
                                                            borderRadius: 10.sp,
                                                            padding:
                                                                EdgeInsets.only(
                                                              left: 10.sp,
                                                            ),
                                                            child: Row(
                                                              children: [
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                      provider
                                                                          .testResultsEntity
                                                                          .difficultyLevel![
                                                                              index]
                                                                          .level!,
                                                                      style: const TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          4.h,
                                                                    ),
                                                                    Text(
                                                                      '${provider.testResultsEntity.difficultyLevel![index].totalQuestions} Questions',
                                                                      style:
                                                                          TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        fontSize:
                                                                            12.sp,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          ContainerWithBorder(
                                                            height: 1.sp,
                                                            boxColor:
                                                                LoopsColors
                                                                    .lightGrey,
                                                          ),
                                                          Expanded(
                                                            child: Center(
                                                              child: Stack(
                                                                children: [
                                                                  CustomBarChart(
                                                                    data: provider
                                                                            .difficultyTypeAccuracy[
                                                                        index],
                                                                  )
                                                                  /*  SfCartesianChart(
                                                                    plotAreaBorderWidth:
                                                                        0,
                                                                    primaryXAxis:
                                                                        CategoryAxis(
                                                                      maximumLabelWidth:
                                                                          68.w,
                                                                      labelStyle:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12.sp,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                      ),
                                                                      majorTickLines:
                                                                          MajorTickLines(
                                                                              size:
                                                                                  0.sp),
                                                                      majorGridLines:
                                                                          const MajorGridLines(
                                                                              width:
                                                                                  0),
                                                                      axisLine: AxisLine(
                                                                          width: 1
                                                                              .sp),
                                                                    ),
                                                                    primaryYAxis:
                                                                        NumericAxis(
                                                                      minimum:
                                                                          0.h,
                                                                      maximum:
                                                                          12.h,
                                                                      interval:
                                                                          2.h,
                                                                      majorGridLines:
                                                                          MajorGridLines(
                                                                        width: 0.0
                                                                            .sp,
                                                                        color: LoopsColors
                                                                            .lightGrey,
                                                                      ),
                                                                      majorTickLines:
                                                                          MajorTickLines(
                                                                              size:
                                                                                  0.sp),
                                                                      axisLine:
                                                                          const AxisLine(
                                                                              width:
                                                                                  0),
                                                                      labelStyle:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            0.sp,
                                                                      ),
                                                                    ),
                                                                    series: [
                                                                      ColumnSeries<
                                                                          AnalyticData,
                                                                          String>(
                                                                        pointColorMapper:
                                                                            (datum,
                                                                                indexx) {
                                                                          return LoopsColors.colorsList01[indexx %
                                                                              LoopsColors.colorsList01.length];
                                                                        },
                                                                        spacing:
                                                                            1.sp,
                                                                        /*    dataLabelMapper: (AnalyticData
                                                                                    data,
                                                                                _) =>
                                                                            data.tests
                                                                                .toString(),
                                                                        dataLabelSettings:
                                                                            DataLabelSettings(
                                                                                color:
                                                                                    LoopsColors.colorBlack), */
                                                                        dataSource:
                                                                            provider
                                                                                .difficultyTypeAccuracy[index],
                                                                        xValueMapper:
                                                                            (AnalyticData difficulty,
                                                                                _) {
                                                                          return difficulty
                                                                              .day;
                                                                        },
                                                                        yValueMapper: (AnalyticData difficulty,
                                                                                _) =>
                                                                            difficulty
                                                                                .tests,
                                                                        // color:
                                                                      )
                                                                    ],
                                                                  ),
                                                                  for (var i = 1;
                                                                      i <=
                                                                          provider
                                                                              .difficultyTypeAccuracy[index]
                                                                              .length;
                                                                      i++)
                                                                    Positioned(
                                                                      bottom: (((provider.difficultyTypeAccuracy[index][i - 1].tests + 1.h) * 18.8.h)
                                                                              .h) +
                                                                          (-10.h -
                                                                                  provider.difficultyTypeAccuracy[index][i - 1].tests)
                                                                              .h,
                                                                      left: i.w *
                                                                              35
                                                                                  .w +
                                                                          (i > 1
                                                                              ? (i - 1) *
                                                                                  27.5.w
                                                                              : 0),
                                                                      child: Text(
                                                                        provider
                                                                            .difficultyTypeAccuracy[
                                                                                index]
                                                                                [
                                                                                i -
                                                                                    1]
                                                                            .tests
                                                                            .toStringAsFixed(
                                                                                0),
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              10.sp,
                                                                          fontWeight:
                                                                              FontWeight.w800,
                                                                        ),
                                                                      ),
                                                                    ), */
                                                                  ,
                                                                  Positioned(
                                                                    top: 0,
                                                                    left: 10,
                                                                    child:
                                                                        SizedBox(
                                                                      width:
                                                                          269.w,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            EdgeInsets.all(10.sp),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Text(
                                                                              'Accuracy',
                                                                              style: TextStyle(
                                                                                fontWeight: FontWeight.w600,
                                                                                fontSize: 12.5.sp,
                                                                              ),
                                                                            ),
                                                                            Text(
                                                                              '${provider.testResultsEntity.difficultyLevel?[index].accuracy}%',
                                                                              style: TextStyle(
                                                                                fontWeight: FontWeight.w600,
                                                                                fontSize: 18.sp,
                                                                                color: LoopsColors.colorBlack,
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  /* Positioned(
                                                                      bottom: 20.h,
                                                                      child:
                                                                          ContainerWithBorder(
                                                                        height: 1.sp,
                                                                        boxColor:
                                                                            LoopsColors.colorGrey,
                                                                      )) */
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ));
                                                }),
                                          )),
                                      ContainerWithBorder(
                                        borderColor: LoopsColors.colorGrey,
                                        boxColor: LoopsColors.colorWhite,
                                        padding: EdgeInsets.all(
                                          12.h,
                                        ),
                                        borderR: BorderRadius.only(
                                          bottomLeft: Radius.circular(10.sp),
                                          bottomRight: Radius.circular(10.sp),
                                        ),
                                        height: 300.h,
                                        width: 275.w,
                                        child: BarGraph(
                                          // height: 200.h,
                                          maxProgressLength: 0.1,
                                          // maxlableWidth: 60,
                                          padding: EdgeInsets.all(8.sp),
                                          bgColor: LoopsColors.lightGrey
                                              .withOpacity(0.5),
                                          keyValueMap: difficultyTypeTime,
                                          text:
                                              'Average time taken to answer each question.',
                                        ),
                                        /* ListView.builder(
                                                scrollDirection: Axis.horizontal,
                                                itemCount: 1,
                                                itemBuilder: (context, index) {
                                                  return ContainerWithBorder(
                                                      margin: const EdgeInsets.all(
                                                          18.0),
                                                      height: 315.h,
                                                      width: 290.w,
                                                      boxColor: LoopsColors.colorWhite,
                                                      borderRadius: 10.sp,
                                                      // borderColor: LoopsColors.textColor,
                                                      boxShadow: [
                                                        BoxShadow(
                                                            blurRadius: 10,
                                                            spreadRadius: 0,
                                                            color: LoopsColors.colorGrey
                                                                .withOpacity(0.2),
                                                            offset:
                                                                Offset(5.sp, 5.sp))
                                                      ],
                                                      child: Column(
                                                        children: [
                                                          ContainerWithBorder(
                                                            height: 1.sp,
                                                            boxColor: LoopsColors.lightGrey,
                                                          ),
                                                          Expanded(
                                                            child: Center(
                                                              child: Stack(
                                                                children: [
                                                                  SfCartesianChart(
                                                                    plotAreaBorderWidth:
                                                                        0,
                                                                    primaryXAxis:
                                                                        CategoryAxis(
                                                                      maximumLabelWidth:
                                                                          70,
                                                                      // multiLevelLabels: ,
                                                                      labelStyle:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                      ),
                                                                      majorTickLines:
                                                                          MajorTickLines(
                                                                              size:
                                                                                  0.sp),
                                                                      majorGridLines:
                                                                          const MajorGridLines(
                                                                              width:
                                                                                  0),
                                                                      axisLine: AxisLine(
                                                                          width: 0.2
                                                                              .sp),
                                                                    ),
                                                                    primaryYAxis:
                                                                        NumericAxis(
                                                                      minimum: 0,
                                                                      maximum: 12,
                                                                      maximumLabelWidth:
                                                                          0,
                                                                      interval: 2,
                                                                      majorGridLines:
                                                                          MajorGridLines(
                                                                        width:
                                                                            0.0.sp,
                                                                        color:
                                                                            LoopsColors.lightGrey,
                                                                      ),
                                                                      majorTickLines:
                                                                          MajorTickLines(
                                                                              size:
                                                                                  0.sp),
                                                                      axisLine:
                                                                          const AxisLine(
                                                                              width:
                                                                                  0),
                                                                      labelStyle:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            0.sp,
                                                                      ),
                                                                    ),
                                                                    series: <
                                                                        BarSeries<
                                                                            AnalyticData,
                                                                            String>>[
                                                                      BarSeries<
                                                                          AnalyticData,
                                                                          String>(
                                                                        spacing:
                                                                            1.sp,
                                                                        /*    dataLabelMapper: (AnalyticData
                                                                                  data,
                                                                              _) =>
                                                                          data.tests
                                                                              .toString(),
                                                                      dataLabelSettings:
                                                                          DataLabelSettings(
                                                                              color:
                                                                                  LoopsColors.colorBlack), */
                                                                        dataSource: difficultyLevel
                                                                            .reversed
                                                                            .toList(),
                                                                        xValueMapper:
                                                                            (AnalyticData
                                                                                    data2,
                                                                                _) {
                                                                          return data2
                                                                              .day;
                                                                        },
                                                                        yValueMapper: (AnalyticData
                                                                                    data2,
                                                                                _) =>
                                                                            data2
                                                                                .tests,
                                                                        // color: i == 0
                                                                        //     ? LoopsColors.colorGreen
                                                                        //     : i == 1
                                                                        //         ? LoopsColors.colorRed
                                                                        //         : i == 2
                                                                        //             ? LoopsColors.tertiaryColor
                                                                        //             : LoopsColors.colorGrey,
                                                                      )
                                                                    ],
                                                                  ),
                                                                  for (var i = 1;
                                                                      i <=
                                                                          difficultyLevel
                                                                              .reversed
                                                                              .toList()
                                                                              .length;
                                                                      i++)
                                                                    Positioned(
                                                                      // top: 100,
                                                                      left: (((difficultyLevel.reversed.toList()[i - 1].tests + 1) * 20.8)
                                                                                  .w +
                                                                              32.w +
                                                                              (10 - difficultyLevel.reversed.toList()[i - 1].tests)
                                                                                  .w) +
                                                                          12.w,
                                                                      bottom: i.h *
                                                                              54.h +
                                                                          (i > 1
                                                                              ? (i - 1) *
                                                                                  47.h
                                                                              : 0) -
                                                                          (5 - i).w,
                                                                      child: Text(
                                                                        '${difficultyLevel.reversed.toList()[i - 1].tests.toStringAsFixed(0)} mins',
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              10.sp,
                                                                          fontWeight:
                                                                              FontWeight
                                                                                  .w800,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ));
                                                }) */
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 12.w,
                      ),
                      Container(
                        height: 57.h,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              LoopsColors.primaryColor,
                              LoopsColors.colorPink,
                            ],
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(12.sp),
                          ),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                color: LoopsColors.colorGrey.withOpacity(0.2),
                                offset: Offset(5.sp, 5.sp))
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: 12.w,
                            ),
                            SizedBox(
                              width: 140.w,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Coin(coinSize: 30.sp),
                                  Text(
                                    'Coins Earned',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: LoopsColors.colorWhite,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    width: 80.w,
                                  ),
                                  Text(
                                    provider
                                        .testResultsEntity.coinsEarned ?? "",
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      color: LoopsColors.colorWhite,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 14.h,
                      ),
                      Text(
                        'Concepts',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: LoopsColors.colorBlack,
                        ),
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      ContainerWithBorder(
                        borderRadius: 12.sp,
                        height: provider.testResultsEntity.concept!.length *
                            (260.h / 3),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              color: LoopsColors.colorGrey.withOpacity(0.2),
                              offset: Offset(5.sp, 5.sp))
                        ],
                        child: ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: provider.testResultsEntity.concept!.length,
                          itemBuilder: (context, index) {
                            return MarksGained(
                              title: provider.testResultsEntity.concept![index]
                                  .conceptName!,
                              correct: int.parse(provider.testResultsEntity
                                      .concept![index].correctTotal
                                      ?.toString() ??
                                  '0'),
                              incorrect: int.parse(provider.testResultsEntity
                                      .concept![index].incorrectTotal
                                      ?.toString() ??
                                  '0'),
                              partial: int.parse(provider.testResultsEntity
                                      .concept![index].partialTotal
                                      ?.toString() ??
                                  '0'),
                              na: int.parse(provider.testResultsEntity
                                      .concept![index].notAnsweredTotal
                                      ?.toString() ??
                                  '0'),
                              score: double.parse(provider.testResultsEntity
                                          .concept![index].score
                                          ?.toString() ??
                                      '0')
                                  .toInt(),
                              total: int.parse(provider.testResultsEntity
                                      .concept![index].scoreTotal
                                      ?.toString() ??
                                  '0'),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Container(
                              height: 1.sp,
                              width: MediaQuery.of(context).size.width,
                              color: LoopsColors.textColor.withOpacity(0.4),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      Text(
                        'Answer Keys',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: LoopsColors.colorBlack,
                        ),
                      ),

                      AnswerKeys(concepts: provider.testResultsEntity.concept!),
                      SizedBox(
                        height: 24.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          if (provider.testResultsEntity.practiceTest != null ??
                              false)
                            InkWell(
                              onTap: () {
                                provider.currentQuestionPageIndex = 0;
                                provider.testStart.resumeQuesId = null;

                                // if (Provider.of<TestProvider>(context,
                                //             listen: false)
                                //         .testHomeEntity
                                //         .recommendations
                                //         ?.isNotEmpty ??
                                //     false) {
                                if(provider.testResultsEntity.practiceTest != null){
                                  provider
                                      .testHomeEntity.recent?[widget.index].testId = null;
                                  provider
                                      .testHomeEntity.recent?[widget.index].userTestId = null;
                                }

                                  gotoTestInstructions(

                                    testType: provider.testResultsEntity.practiceTest != null ? "Practice" : "",
                                    context,
                                    testEntity: provider
                                        .testHomeEntity.recent?[widget.index],
                                    practiceId: provider.testResultsEntity.practiceTest.toString(),
                                    isPrecticeTest: provider.testResultsEntity.practiceTest != null ? true : false

                                  ).onError((error, stackTrace) async {
                                    await handleError(error);
                                  });
                              },
                              child: (provider.testResultsEntity.practiceTest !=
                                      null)
                                  ? ContainerWithBorder(
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 10,
                                            color: LoopsColors.colorGrey
                                                .withOpacity(0.2),
                                            offset: Offset(5.sp, 5.sp))
                                      ],
                                      width: 104.w,
                                      height: 38.h,
                                      borderRadius: 8.sp,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Icon(
                                            Icons.loop,
                                            size: 20.sp,
                                            color: LoopsColors.colorGreen,
                                          ),
                                          Text(
                                            'Practice',
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w600,
                                                color: LoopsColors.colorBlack),
                                          )
                                        ],
                                      ),
                                    )
                                  : Text(" "),
                            ),
                          InkWell(
                            onTap: () async {
                              await provider
                                  .ftestBookmark(null,
                                      provider.testEntity.userTestId!.toInt())
                                  .onError(
                                    (error, stackTrace) async =>
                                        handleError(error),
                                  )
                                  .then((_) {
                                handleError('Bookmarked');
                              });
                            },
                            child: ContainerWithBorder(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 10,
                                    color:
                                        LoopsColors.colorGrey.withOpacity(0.2),
                                    offset: Offset(5.sp, 5.sp))
                              ],
                              width: 104.w,
                              height: 38.h,
                              borderRadius: 8.sp,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.bookmark_add_outlined,
                                    size: 20.sp,
                                    color: LoopsColors.primaryColor,
                                  ),
                                  Text(
                                    'Bookmark',
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        color: LoopsColors.colorBlack),
                                  )
                                ],
                              ),
                            ),
                          ),
                          if (provider.testResultsEntity.testIdForRepeat !=
                                  null &&
                              provider.testResultsEntity.testIdForRepeat != 0)
                            InkWell(
                              onTap: () {
                                gotoTestInstructions(context,
                                    testType: "",
                                    testEntity: TestEntity(
                                        testId: provider.testResultsEntity
                                            .testIdForRepeat));
                              },
                              child: ContainerWithBorder(
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 10,
                                      color: LoopsColors.colorGrey
                                          .withOpacity(0.2),
                                      offset: Offset(5.sp, 5.sp))
                                ],
                                width: 104.w,
                                height: 38.h,
                                borderRadius: 8.sp,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.repeat_rounded,
                                      size: 20.sp,
                                      color: LoopsColors.colorGreen,
                                    ),
                                    Text(
                                      'Repeat',
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          color: LoopsColors.colorBlack),
                                    )
                                  ],
                                ),
                              ),
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
            ],
          ),
        ),
      ),
    );
  }
}

final Map<String, int> questionTypeTime = {
  'MCQ': 0,
  'True/False': 0,
  'Drag & Drop': 0,
  'Match the foloowing': 0,
};

Map<String, int> difficultyTypeTime = {
  'easy': 0,
  'medium': 0,
  'hard': 0,
};

//TODO: add overall and concepts.
//TODO: answer keys Concepts
