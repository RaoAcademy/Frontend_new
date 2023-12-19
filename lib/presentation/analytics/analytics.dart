import 'dart:io';

import 'package:curved_progress_bar/curved_progress_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rao_academy/application/other/other_provider.dart';
import 'package:rao_academy/application/test/test_provider.dart';
import 'package:rao_academy/core/theme/custom_scroll_behaviour.dart';
import 'package:rao_academy/core/utli/error_handle.dart';
import 'package:rao_academy/core/utli/loops_urls.dart';
import 'package:rao_academy/core/widgets/box_corner_list.dart';
import 'package:rao_academy/core/widgets/container_with_border.dart';
import 'package:rao_academy/core/widgets/test_rounded_coener_list.dart';
import 'package:rao_academy/domain/entities/subject_list_entity.dart';
import 'package:rao_academy/domain/entities/subjects_entity.dart';
import 'package:rao_academy/presentation/analytics/widgets/pie_chart.dart';
import 'package:rao_academy/presentation/analytics/widgets/strength.dart';
import 'package:rao_academy/presentation/core/bottom_bar.dart';
import 'package:rao_academy/presentation/core/drawer.dart';
import 'package:rao_academy/presentation/home/homescreen.dart';

import '../../core/widgets/rounded_corner_list.dart';

final ScrollController _scroll = ScrollController();

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({Key? key}) : super(key: key);

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {

  double testConfidence = 0.0;
  double testScore = 0.0;
  double testPerformar = 0.0;
  double testAccuracy = 0.0;

  @override
  void initState() {
    final TestProvider provider = context.read<TestProvider>();
    _subjects.clear();
    context.read<OtherProvider>().currentTab = 3;

    _subjectwiseValueList.clear();

    if (_subjects.contains(_subjects.firstWhere(
            (element) => element.name == 'Overall',
            orElse: () => Subjects())) ==
        false) {
      _subjects.add(Subjects(
        name: 'Overall',
        id: 0,
      ));
    }
    if (provider.analyticsEntity.subjectList?.contains(provider
            .analyticsEntity.subjectList
            ?.firstWhere((element) => element.name == 'Overall',
                orElse: () => SubjectList())) ==
        false) {
      provider.analyticsEntity.subjectList?.add(SubjectList(
        tests: provider.analyticsEntity.tests,
        accuracy: provider.analyticsEntity.accuracy,
        conceptBased: provider.analyticsEntity.conceptBased,
        confidence: provider.analyticsEntity.confidence,
        custom: provider.analyticsEntity.custom,
        id: 0,
        loop: provider.analyticsEntity.loop,
        name: 'Overall',
        other: provider.analyticsEntity.other,
        performance: provider.analyticsEntity.performance,
        score: provider.analyticsEntity.score,
      ));
    }

    provider.analyticsEntity.subjectList!.forEach((element) {
      if (element.id == provider.subjectId) {
        provider.updateSubjectMap(element, reload: false);
      }
      _subjects.add(Subjects.fromJson(element.toJson()));

      _subjectwiseValueList.add(element.confidence!.toDouble());
    });
    Provider.of<TestProvider>(context, listen: false)
        .subjectId = 1;

     Provider.of<TestProvider>(context, listen: false)
        .fanalyticsSubject().then((value) {
       _subjectwiseValueList.clear();
       Provider.of<TestProvider>(context, listen: false).subjectwisePerformanceValues.clear();
       Provider.of<TestProvider>(context, listen: false).subjectwisePerformanceValues.add( Provider.of<TestProvider>(context, listen: false).analyticsSubject.values?.loop?.toDouble() ?? 0);
       Provider.of<TestProvider>(context, listen: false).subjectwisePerformanceValues.add( Provider.of<TestProvider>(context, listen: false).analyticsSubject.values?.tests?.toDouble() ?? 0);
       Provider.of<TestProvider>(context, listen: false).subjectwisePerformanceValues.add( Provider.of<TestProvider>(context, listen: false).analyticsSubject.values?.custom?.toDouble() ?? 0);
       Provider.of<TestProvider>(context, listen: false).subjectwisePerformanceValues.add( Provider.of<TestProvider>(context, listen: false).analyticsSubject.values?.other?.toDouble() ?? 0);

     });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<OtherProvider>();
    context.read<OtherProvider>().currentTab = 3;
    // final TestProvider _providerWatch =
    //     Provider.of<TestProvider>(context, listen: false);
    int presscount = 0;

    return WillPopScope(
      onWillPop: () async {
        presscount++;

        if (presscount == 2) {
          exit(0);
        } else {
          const snackBar = SnackBar(
            content: Text('Press again to exit'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          return false;
        }
      },
      child: Scaffold(
        key: scaffoldKey04,
        bottomNavigationBar: bottomNavigationBar(context),
        drawer: const DrawerWidget(),
        body: Column(
          children: [
            ContainerWithBorder(
              boxColor: LoopsColors.primaryColor,
              height: 62.h,
              width: MediaQuery.of(context).size.width,
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 22.w),
                    child: Text(
                      'Analytics',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w600,
                        color: LoopsColors.colorWhite,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Filter by: ',
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                          color: LoopsColors.colorGrey,
                          letterSpacing: 0.03.sp,
                        ),
                      ),
                      SizedBox(
                        width: 70.w,
                        child: PopupMenuButton<int>(
                          icon: Text(
                            Provider.of<TestProvider>(context).selectedTime,
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                              color: LoopsColors.colorWhite,
                              letterSpacing: 0.03.sp,
                            ),
                          ),
                          onSelected: (index) {
                            Provider.of<TestProvider>(context, listen: false).selectedTime =
                                index == 0
                                    ? Provider.of<TestProvider>(context,
                                            listen: false)
                                        .analyticsSubject
                                        .dateFilter!
                                        .thisWeek!
                                    : index == 1
                                        ? Provider.of<TestProvider>(context,
                                                listen: false)
                                            .analyticsSubject
                                            .dateFilter!
                                            .thisMonth!
                                        : Provider.of<TestProvider>(context,
                                                listen: false)
                                            .analyticsSubject
                                            .dateFilter!
                                            .thisYear!;
                            Provider.of<TestProvider>(context, listen: false)
                                .fanalyticsSubject()
                                .onError((error, stackTrace) async {
                              await handleError(error);
                            });
                          },
                          itemBuilder: (context) {
                            return <PopupMenuEntry<int>>[
                              for (var i = 0; i < 3; i++)
                                PopupMenuItem(
                                    value: i,
                                    height: 24.h,
                                    child: Text(
                                      i == 0
                                          ? Provider.of<TestProvider>(context,
                                                  listen: false)
                                              .analyticsSubject
                                              .dateFilter!
                                              .thisWeek!
                                          : i == 1
                                              ? Provider.of<TestProvider>(
                                                      context,
                                                      listen: false)
                                                  .analyticsSubject
                                                  .dateFilter!
                                                  .thisMonth!
                                              : Provider.of<TestProvider>(
                                                      context,
                                                      listen: false)
                                                  .analyticsSubject
                                                  .dateFilter!
                                                  .thisYear!,
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w600,
                                        color: LoopsColors.primaryColor,
                                        letterSpacing: 0.03.sp,
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
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 8.sp, right: 8.sp),
                child: ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 4.h,
                      ),
                      BoxCornerList(
                          textList: _subjects,
                          selectedIndex: 1,
                          getValue: (value) async {
                            _subjectwiseValueList.clear();
                            Provider.of<TestProvider>(context, listen: false)
                                    .subjectId =
                                _subjects[value.keys.first].id!.toInt();
                            Provider.of<TestProvider>(context, listen: false)
                                .updateSubjectMap(
                                    Provider.of<TestProvider>(context,
                                            listen: false)
                                        .analyticsEntity
                                        .subjectList!
                                        .firstWhere((element) =>
                                            element.id ==
                                            _subjects[value.keys.first].id),
                                    reload: true);
                             Provider.of<TestProvider>(context, listen: false).analyticsEntity.subjectList!.forEach((element) {
                              if (element.id ==  Provider.of<TestProvider>(context, listen: false).subjectId) {
                                 Provider.of<TestProvider>(context, listen: false).updateSubjectMap(element, reload: false);
                              }
                              _subjects.add(Subjects.fromJson(element.toJson()));

                              _subjectwiseValueList.add(element.confidence!.toDouble());
                            });
                            if (_subjects[value.keys.first].id != 0) {
                             await Provider.of<TestProvider>(context, listen: false)
                                  .fanalyticsSubject();
                              _subjectwiseValueList.clear();
                              Provider.of<TestProvider>(context, listen: false).subjectwisePerformanceValues.clear();
                              Provider.of<TestProvider>(context, listen: false).subjectwisePerformanceValues.add( Provider.of<TestProvider>(context, listen: false).analyticsSubject.values?.loop?.toDouble() ?? 0);
                              Provider.of<TestProvider>(context, listen: false).subjectwisePerformanceValues.add( Provider.of<TestProvider>(context, listen: false).analyticsSubject.values?.tests?.toDouble() ?? 0);
                              Provider.of<TestProvider>(context, listen: false).subjectwisePerformanceValues.add( Provider.of<TestProvider>(context, listen: false).analyticsSubject.values?.custom?.toDouble() ?? 0);
                              Provider.of<TestProvider>(context, listen: false).subjectwisePerformanceValues.add( Provider.of<TestProvider>(context, listen: false).analyticsSubject.values?.other?.toDouble() ?? 0);
                            }
                          }),
                      SizedBox(
                        height: 94.h,
                        child: ScrollConfiguration(
                          behavior: MyBehavior(),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: Provider.of<TestProvider>(context,
                                    listen: false)
                                .subjectListx
                                .length,
                            itemBuilder: (context, index) {
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
                                              Provider.of<TestProvider>(context,
                                                      listen: false)
                                                  .subjectMap
                                                  .entries
                                                  .firstWhere((element) =>
                                                      element.key ==
                                                      Provider.of<TestProvider>(
                                                              context,
                                                              listen: false)
                                                          .subjectListx[index])
                                                  .key,
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
                                                  height: 60.sp,
                                                  width: 60.sp,
                                                  child:
                                                      CurvedCircularProgressIndicator(
                                                    strokeWidth: 6.sp,
                                                    animationDuration:
                                                        const Duration(
                                                            seconds: 3),
                                                    value: (double.parse(Provider.of<TestProvider>(context, listen: false)
                                                                        .subjectMap
                                                                        .entries
                                                                        .firstWhere((element) =>
                                                                            element.key ==
                                                                            Provider.of<TestProvider>(context, listen: false).subjectListx[
                                                                                index])
                                                                        .value
                                                                        .toString() !=
                                                                    'null'
                                                                ? Provider.of<TestProvider>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .subjectMap
                                                                    .entries
                                                                    .firstWhere(
                                                                        (element) => element.key == Provider.of<TestProvider>(context, listen: false).subjectListx[index])
                                                                    .value
                                                                    .toString()
                                                                : '0') %
                                                            100) /
                                                        100,
                                                    color: LoopsColors
                                                            .colorsList02[
                                                        index %
                                                            LoopsColors
                                                                .colorsList02
                                                                .length],
                                                    backgroundColor: LoopsColors
                                                        .colorsList02[index %
                                                            LoopsColors
                                                                .colorsList02
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
                                                      '${(double.parse(Provider.of<TestProvider>(context, listen: false).subjectMap.entries.firstWhere((element) => element.key == Provider.of<TestProvider>(context, listen: false).subjectListx[index]).value.toString() != "null" ? Provider.of<TestProvider>(context, listen: false).subjectMap.entries.firstWhere((element) => element.key == Provider.of<TestProvider>(context, listen: false).subjectListx[index]).value.toString() : "0") % 100).toInt()}%',
                                                      style: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: LoopsColors
                                                            .colorBlack,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                      /* SvgPicture.asset(
                                      index.isEven
                                          ? 'assets/images/other/bg_01.svg'
                                          : 'assets/images/other/bg_02.svg',
                                      width: MediaQuery.of(context).size.width,
                                      color: LoopsColors.colorWhite.withOpacity(0.9),
                                      fit: BoxFit.fill,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12.sp, vertical: 12.sp),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            _subjectList[index],
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w600,
                                              color: LoopsColors.colorWhite,
                                            ),
                                          ),
                                          Text(
                                            '18 Abc',
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w600,
                                              color: LoopsColors.colorWhite,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ), */
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
                          BoxShadow(
                              blurRadius: 12.sp, color: LoopsColors.lightGrey)
                        ],
                        width: MediaQuery.of(context).size.width,
                        borderRadius: 12.sp,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: 24.w, right: 24.w, top: 10.h,
                                // vertical: 20.h,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    Provider.of<TestProvider>(context, listen: false)
                                        .subjectId  == 0 ? 'Subject Wise' : 'Test Wise',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      color: LoopsColors.colorBlack,
                                    ),
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
                                        width: 0.w,
                                      ),
                                      SizedBox(
                                        width: 70.w,
                                        child: PopupMenuButton<int>(
                                          icon: Text(
                                            _selectedIndex01 == 0
                                                ? provider.analyticsSubject
                                                    .dateFilter!.thisWeek!
                                                : _selectedIndex01 == 1
                                                    ? provider.analyticsSubject
                                                        .dateFilter!.thisMonth!
                                                    : provider.analyticsSubject
                                                        .dateFilter!.thisYear!,
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w600,
                                              color: LoopsColors.primaryColor,
                                              letterSpacing: 0.03.sp,
                                            ),
                                          ),
                                          onSelected: (index) {
                                            _selectedIndex01 = index;
                                            provider.setState();
                                          },
                                          itemBuilder: (context) {
                                            return <PopupMenuEntry<int>>[
                                              for (var i = 0; i < 3; i++)
                                                PopupMenuItem(
                                                    value: i,
                                                    height: 24.h,
                                                    child: Text(
                                                      i == 0
                                                          ? provider
                                                              .analyticsSubject
                                                              .dateFilter!
                                                              .thisWeek!
                                                          : i == 1
                                                              ? provider
                                                                  .analyticsSubject
                                                                  .dateFilter!
                                                                  .thisMonth!
                                                              : provider
                                                                  .analyticsSubject
                                                                  .dateFilter!
                                                                  .thisYear!,
                                                      style: TextStyle(
                                                        fontSize: 10.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
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
                            Provider.of<TestProvider>(context, listen: false)
                                .subjectId  == 0 ? RoundedCornerList(
                              textList: Provider.of<TestProvider>(context,
                                      listen: false)
                                  .subjectListx,
                              getValue: (value) {
                                _subjectwiseValueList.clear();
                                switch (value.keys.first) {
                                  case 0:
                                    Provider.of<TestProvider>(context,
                                            listen: false)
                                        .analyticsEntity
                                        .subjectList!
                                        .forEach((element) {
                                      _subjectwiseValueList
                                          .add(element.confidence!.toDouble());
                                    });
                                    break;
                                  case 1:
                                    Provider.of<TestProvider>(context,
                                            listen: false)
                                        .analyticsEntity
                                        .subjectList!
                                        .forEach((element) {
                                      _subjectwiseValueList
                                          .add(element.score!.toDouble());
                                    });
                                    break;
                                  case 2:
                                    Provider.of<TestProvider>(context,
                                            listen: false)
                                        .analyticsEntity
                                        .subjectList!
                                        .forEach((element) {
                                      _subjectwiseValueList
                                          .add(element.tests!.toDouble());
                                    });
                                    break;
                                  case 3:
                                    Provider.of<TestProvider>(context,
                                            listen: false)
                                        .analyticsEntity
                                        .subjectList!
                                        .forEach((element) {
                                      _subjectwiseValueList.add(
                                          element.performance?.toDouble() ??
                                              0.0);
                                    });
                                    break;
                                  default:
                                    Provider.of<TestProvider>(context,
                                            listen: false)
                                        .analyticsEntity
                                        .subjectList!
                                        .forEach((element) {
                                      _subjectwiseValueList
                                          .add(element.accuracy!.toDouble());
                                    });
                                    break;
                                }
                                Provider.of<TestProvider>(context,
                                        listen: false)
                                    .setState();
                              },
                            ) :
                            Provider.of<TestProvider>(
                                context,
                                listen: false)
                                .analyticsSubject.values?.testList?.isEmpty ?? false ? Text("Test list will be displyed here") :  TestRoundedCornerList(textList: Provider.of<TestProvider>(
                                context,
                                listen: false)
                                .analyticsSubject.values?.testList, getValue: (value) {
                                  if(value != null){

                                    setState(() {
                                      testScore = double.parse(value.score.toString());
                                      testAccuracy = double.parse(value.accuracy.toString());
                                      testConfidence = double.parse(value.confidence.toString());
                                      testPerformar = double.parse(value.performance.toString());
                                    });
                                  }
                                },),
                            Provider.of<TestProvider>(context, listen: false)
                                .subjectId  == 0   ?
                    SizedBox(
                    height: 172.h,
                    child: Scrollbar(
                thumbVisibility: false,
                radius: Radius.circular(12.sp),
                child: ListView.builder(
                  // scrollDirection: Axis.horizontal,
                  // physics: const NeverScrollableScrollPhysics(),
                    controller: _scroll,
                    itemCount: Provider.of<TestProvider>(
                        context,
                        listen: false)
                        .analyticsSubject
                        .subjects!
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
                              padding: EdgeInsets.only(
                                  left: 8.sp),
                              child: Text(
                                Provider.of<TestProvider>(
                                    context,
                                    listen: false)
                                    .analyticsEntity
                                    .subjectList![index]
                                    .name!,
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
                                color: LoopsColors
                                    .colorsList01[
                                index %
                                    LoopsColors
                                        .colorsList01
                                        .length],
                                value:
                                (_subjectwiseValueList[
                                index] %
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
                                (_subjectwiseValueList[
                                index] %
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
              ),
            )
                        :  SizedBox(
                              height: 172.h,
                              child: Scrollbar(
                                thumbVisibility: false,
                                radius: Radius.circular(12.sp),
                                child: Scrollbar(
                                thumbVisibility: false,
                                radius: Radius.circular(12.sp),
                                child: ListView.builder(
                                  // scrollDirection: Axis.horizontal,
                                  // physics: const NeverScrollableScrollPhysics(),
                                    controller: _scroll,
                                    itemCount: Provider.of<TestProvider>(context,
                                        listen: false)
                                        .subjectTestListx
                                        .length,
                                    itemBuilder: (context, index) =>
                                   
                                        SizedBox(
                                      height: 32.h,
                                      width:
                                      MediaQuery.of(context).size.width,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 80.w,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 8.sp),
                                              child: Text(
                                                Provider.of<TestProvider>(context,
                                                    listen: false)
                                                    .subjectTestListx[index],
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
                                                color: LoopsColors
                                                    .colorsList01[
                                                index %
                                                    LoopsColors
                                                        .colorsList01
                                                        .length],
                                                value:
                                                (index == 0 ? testConfidence : index == 1? testScore : index == 2 ? testPerformar :  testAccuracy  %
                                                    100) /
                                                    100
                                                ,
                                                backgroundColor: LoopsColors
                                                    .lightGrey
                                                    .withOpacity(0.5),
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                ( index == 0 ? testConfidence : index == 1? testScore : index == 2 ? testPerformar :  testAccuracy %
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
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 12.sp, color: LoopsColors.lightGrey)
                        ],
                        width: MediaQuery.of(context).size.width,
                        height: 390.h,
                        borderRadius: 12.sp,
                        child: Column(
                          children: [
                            /* Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 24.w,
                                vertical: 20.h,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Tests Wise',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      color: LoopsColors.colorBlack,
                                    ),
                                  ),
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
                                      SizedBox(
                                        width: 70.w,
                                        child: PopupMenuButton<int>(
                                          icon: Text(
                                            _selectedIndex02 == 0
                                                ? provider.analyticsSubject
                                                    .dateFilter!.thisWeek!
                                                : _selectedIndex02 == 1
                                                    ? provider.analyticsSubject
                                                        .dateFilter!.thisMonth!
                                                    : provider.analyticsSubject
                                                        .dateFilter!.thisYear!,
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w600,
                                              color: LoopsColors.primaryColor,
                                              letterSpacing: 0.03.sp,
                                            ),
                                          ),
                                          onSelected: (index) {
                                            _selectedIndex02 = index;
                                            provider.setState();
                                          },
                                          itemBuilder: (context) {
                                            return <PopupMenuEntry<int>>[
                                              for (var i = 0; i < 3; i++)
                                                PopupMenuItem(
                                                    value: i,
                                                    child: Text(
                                                      i == 0
                                                          ? provider
                                                              .analyticsSubject
                                                              .dateFilter!
                                                              .thisWeek!
                                                          : i == 1
                                                              ? provider
                                                                  .analyticsSubject
                                                                  .dateFilter!
                                                                  .thisMonth!
                                                              : provider
                                                                  .analyticsSubject
                                                                  .dateFilter!
                                                                  .thisYear!,
                                                      style: TextStyle(
                                                        fontSize: 10.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
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
                                  ),
                                ],
                              ),
                            ), */
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(16.sp),
                                  child: Text(
                                    'Test wise',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      color: LoopsColors.colorBlack,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (Provider.of<TestProvider>(context)
                                .getEmptyChart())
                              PieChartWithImage(
                                values: Provider.of<TestProvider>(context)
                                    .subjectwisePerformanceValues,
                                colors: LoopsColors.colorsList01,
                              )
                            else
                              PieChartWithImage(
                                values: const [1, 1, 1],
                                colors: [LoopsColors.lightGrey],
                              ),
                            SizedBox(
                              height: 24.h,
                            ),
                            Expanded(
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  for (int i = 0;
                                      i <
                                          Provider.of<TestProvider>(context,
                                                  listen: false)
                                              .subjectwisePerformanceKeys
                                              .length;
                                      i++)
                                    SizedBox(
                                      width: (Provider.of<TestProvider>(context,
                                                              listen: false)
                                                          .subjectwisePerformanceKeys[
                                                              i]
                                                          .length *
                                                      9.w <
                                                  120.w
                                              ? Provider.of<TestProvider>(
                                                          context,
                                                          listen: false)
                                                      .subjectwisePerformanceKeys[
                                                          i]
                                                      .length *
                                                  9.w
                                              : 120.w) +
                                          20.w,
                                      height: 40.h,
                                      child: Row(
                                        children: [
                                          ContainerWithBorder(
                                            margin: EdgeInsets.only(right: 6.w),
                                            width: 12.sp,
                                            height: 12.sp,
                                            boxColor: LoopsColors.colorsList01[
                                                i %
                                                    LoopsColors
                                                        .colorsList01.length],
                                            borderRadius: 12.sp,
                                          ),
                                          Text(
                                            Provider.of<TestProvider>(context,
                                                    listen: false)
                                                .subjectwisePerformanceKeys[i],
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500,
                                              color: LoopsColors.textColor,
                                              letterSpacing: 0.3.w,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  /*  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      ContainerWithBorder(
                                        margin: EdgeInsets.only(right: 6.w),
                                        width: 12.sp,
                                        height: 12.sp,
                                        boxColor: LoopsColors.secondaryColor,
                                        borderRadius: 12.sp,
                                      ),
                                      Text(
                                        'Loops',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                          color: LoopsColors.textColor,
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      ContainerWithBorder(
                                        margin: EdgeInsets.only(right: 6.w),
                                        width: 12.sp,
                                        height: 12.sp,
                                        boxColor: LoopsColors.secondaryColor,
                                        borderRadius: 12.sp,
                                      ),
                                      Text(
                                        'Loops',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                          color: LoopsColors.textColor,
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      ContainerWithBorder(
                                        margin: EdgeInsets.only(right: 6.w),
                                        width: 12.sp,
                                        height: 12.sp,
                                        boxColor: LoopsColors.secondaryColor,
                                        borderRadius: 12.sp,
                                      ),
                                      Text(
                                        'Loops',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                          color: LoopsColors.textColor,
                                        ),
                                      )
                                    ],
                                  ), */
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      if (Provider.of<TestProvider>(context, listen: false)
                              .subjectId ==
                          0)
                        ContainerWithBorder(
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 12.sp, color: LoopsColors.lightGrey)
                          ],
                          width: MediaQuery.of(context).size.width,
                          borderRadius: 12.sp,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 24.w,
                                  vertical: 20.h,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'You v/s Your Friends',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: LoopsColors.colorBlack,
                                      ),
                                    ),
                                    /*  Row(
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
                                            _selectedIndex03 == 0
                                                ? provider.analyticsSubject
                                                    .dateFilter!.thisWeek!
                                                : _selectedIndex03 == 1
                                                    ? provider.analyticsSubject
                                                        .dateFilter!.thisMonth!
                                                    : provider.analyticsSubject
                                                        .dateFilter!.thisYear!,
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
                                              for (var i = 0; i < 3; i++)
                                                PopupMenuItem(
                                                    value: i,
                                                    child: Text(
                                                      i == 0
                                                          ? provider
                                                              .analyticsSubject
                                                              .dateFilter!
                                                              .thisWeek!
                                                          : i == 1
                                                              ? provider
                                                                  .analyticsSubject
                                                                  .dateFilter!
                                                                  .thisMonth!
                                                              : provider
                                                                  .analyticsSubject
                                                                  .dateFilter!
                                                                  .thisYear!,
                                                      style: TextStyle(
                                                        fontSize: 10.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
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
                              SizedBox(
                                height: 260.h,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      for (var i = 0;
                                          i <
                                              Provider.of<TestProvider>(context,
                                                      listen: false)
                                                  .subjectListx
                                                  .length;
                                          i++)
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12.sp),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 208.h,
                                                child: Row(
                                                  children: [
                                                    RotatedBox(
                                                      quarterTurns: -1,
                                                      child:
                                                          CurvedLinearProgressIndicator(
                                                        minHeight: 6.h,
                                                        value: (double.parse(Provider.of<
                                                                            TestProvider>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .subjectMapAll
                                                                    .entries
                                                                    .firstWhere((element) =>
                                                                        element
                                                                            .key ==
                                                                        Provider.of<TestProvider>(context,
                                                                                listen: false)
                                                                            .subjectListx[i])
                                                                    .value
                                                                    .toString()) %
                                                                100) /
                                                            100,
                                                        color: Colors.blue,
                                                        backgroundColor:
                                                            LoopsColors
                                                                .lightGrey
                                                                .withOpacity(
                                                                    0.5),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 6.w,
                                                    ),
                                                    RotatedBox(
                                                      quarterTurns: -1,
                                                      child:
                                                          CurvedLinearProgressIndicator(
                                                        minHeight: 6.h,
                                                        value: (double.parse(Provider.of<TestProvider>(context, listen: false)
                                                                            .subjectMap
                                                                            .entries
                                                                            .firstWhere((element) =>
                                                                                element.key ==
                                                                                Provider.of<TestProvider>(context, listen: false).subjectListx[
                                                                                    i])
                                                                            .value
                                                                            .toString() !=
                                                                        'null'
                                                                    ? Provider.of<TestProvider>(
                                                                            context,
                                                                            listen:
                                                                                false)
                                                                        .subjectMap
                                                                        .entries
                                                                        .firstWhere(
                                                                            (element) => element.key == Provider.of<TestProvider>(context, listen: false).subjectListx[i])
                                                                        .value
                                                                        .toString()
                                                                    : '0') %
                                                                100) /
                                                            100,
                                                        color: LoopsColors
                                                                .colorsList01[
                                                            i %
                                                                LoopsColors
                                                                    .colorsList01
                                                                    .length],
                                                        backgroundColor:
                                                            LoopsColors
                                                                .lightGrey
                                                                .withOpacity(
                                                                    0.5),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 8.sp,
                                              ),
                                              Center(
                                                child: Text(
                                                    Provider.of<TestProvider>(
                                                            context,
                                                            listen: false)
                                                        .subjectListx[i]),
                                              )
                                            ],
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      SizedBox(
                        height: 12.h,
                      ),
                      if (Provider.of<TestProvider>(context, listen: false)
                              .subjectId !=
                          0)
                        const Strength(),
                      SizedBox(
                        height: 24.h,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<double> _subjectwiseValueList = [];

List<Subjects> _subjects = [];
