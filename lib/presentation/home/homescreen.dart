// import 'package:curved_progress_bar/curved_progress_bar.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:rao_academy/application/auth/auth_provider.dart';
import 'package:rao_academy/application/home/home_provider.dart';
import 'package:rao_academy/application/other/other_provider.dart';
import 'package:rao_academy/application/test/test_provider.dart';
import 'package:rao_academy/core/theme/custom_scroll_behaviour.dart';
import 'package:rao_academy/core/theme/theme.dart';
import 'package:rao_academy/core/utli/error_handle.dart';
import 'package:rao_academy/core/utli/get_image_path.dart';
import 'package:rao_academy/core/utli/goto_pages.dart';
import 'package:rao_academy/core/utli/loops_urls.dart';
import 'package:rao_academy/core/utli/to_map.dart';
import 'package:rao_academy/core/widgets/container_with_border.dart';
import 'package:rao_academy/domain/entities/analytics_data_entity.dart';
import 'package:rao_academy/main.dart';
import 'package:rao_academy/presentation/core/bottom_bar.dart';
import 'package:rao_academy/presentation/core/custom_bar_charts.dart';
import 'package:rao_academy/presentation/core/drawer.dart';
import 'package:rao_academy/presentation/core/test_card.dart';
import 'package:rao_academy/presentation/home/video_in_app_webview_screen.dart';
import 'package:rao_academy/presentation/home/widgets/funky_overlay.dart';
import 'package:rao_academy/presentation/other/widgets/cached_network_image.dart';
import 'package:rao_academy/presentation/test_screens/test_types/widgets/loops_popup.dart';

// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

// ignore: use_late_for_private_fields_and_variables
String? _selectedAnalytics;
int _selectedIndex03 = 0;

extension Ex on double {
  double toPrecision(int n) => double.parse(toStringAsFixed(n));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

List<AnalyticData> activity = [];
List<AnalyticData> progress = [];
List<AnalyticData> performance = [];

GlobalKey<ScaffoldState> scaffoldKey01 = GlobalKey<ScaffoldState>();
GlobalKey<ScaffoldState> scaffoldKey02 = GlobalKey<ScaffoldState>();
GlobalKey<ScaffoldState> scaffoldKey03 = GlobalKey<ScaffoldState>();
GlobalKey<ScaffoldState> scaffoldKey04 = GlobalKey<ScaffoldState>();
GlobalKey<ScaffoldState> scaffoldKey05 = GlobalKey<ScaffoldState>();

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  // Index of the currently displayed image
  int currentIndex = 0;

  // Timer to control the automatic scrolling
  Timer? timer;
  final List<String> _badges = [
    'assets/images/home/next_badge.svg',
    'assets/images/home/new_test.svg',
    'assets/images/home/recharge.svg',
    'assets/images/home/weekly_report.svg',
  ];

  String setBadgesList(int i) {
    if (Provider.of<HomeProvider>(context, listen: false)
            .homeEntity
            .notifyList?[i][1] ==
        "notifyForNewTest") {
      return _badges[0];
    } else if (Provider.of<HomeProvider>(context, listen: false)
            .homeEntity
            .notifyList?[i][1] ==
        "notifyForSubscription") {
      return _badges[2];
    } else if (Provider.of<HomeProvider>(context, listen: false)
            .homeEntity
            .notifyList?[i][1] ==
        "notifyForNewWeeklyReport") {
      return _badges[3];
    } else {
      return _badges[1];
    }
  }

  @override
  void initState() {
    isEnterHomeScreen = true;
    context.read<OtherProvider>().currentTab = 0;
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

    if (Provider.of<HomeProvider>(context, listen: false).homeReportsEntity !=
        null) {
      var list1 = Provider.of<HomeProvider>(context, listen: false)
          .homeReportsEntity
          .reports
          ?.activity
          ?.toJson()!
          .toList;
      if (kDebugMode) {
        print(list1);
      }

      // activity.add(AnalyticData(
      //     key, double.parse(value?.toString() ?? '0').abs().toPrecision(2)));
    }
    Provider.of<HomeProvider>(context, listen: false).fgettingStartedVideos();

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
            // progress.add(AnalyticData(
            //     key01, double.parse(value.toString()).abs().toPrecision(2)));
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

    if (Provider.of<HomeProvider>(context, listen: false)
        .homeEntity
        .banner!
        .isNotEmpty) {
      startTimer();
    }
    super.initState();
    getHomeReportsData();
  }

  var progressJson;

  getHomeReportsData() async {
    await Provider.of<HomeProvider>(context, listen: false)
        .fhomeReports('This week')
        .then((value) {
      // if(activity.isEmpty){
      if (Provider.of<HomeProvider>(context, listen: false).homeReportsEntity !=
          null) {
        _subjectList = Provider.of<HomeProvider>(context, listen: false).homeReportsEntity.reports?.subjectList ?? [];
        _selectedIndex03 = 0;
        var activityJson = Provider.of<HomeProvider>(context, listen: false)
            .homeReportsEntity
            .reports
            ?.activity
            ?.toJson();
        var performanceJson = Provider.of<HomeProvider>(context, listen: false)
            .homeReportsEntity
            .reports
            ?.performance
            ?.toJson();
        progressJson = Provider.of<HomeProvider>(context, listen: false)
            .homeReportsEntity
            .reports
            ?.progress;
        // List<AnalyticData>.from(jsonDecode(activityJson)).map((e) => AnalyticData.new(e)));

        if (activityJson != null) {
          activity.add(AnalyticData(
              "Mon", double.parse(activityJson['Mon'].toString())));
          activity.add(AnalyticData(
              "Tue", double.parse(activityJson['Tue'].toString())));
          activity.add(AnalyticData(
              "Wed", double.parse(activityJson['Wed'].toString())));
          activity.add(AnalyticData(
              "Thu", double.parse(activityJson['Thu'].toString())));
          activity.add(AnalyticData(
              "Fri", double.parse(activityJson['Fri'].toString())));
          activity.add(AnalyticData(
              "Sat", double.parse(activityJson['Sat'].toString())));
          activity.add(AnalyticData(
              "Sun", double.parse(activityJson['Sun'].toString())));
        }
        if (performanceJson != null) {
          performance.add(AnalyticData(
              "Mon", double.parse(performanceJson['Mon'].toString())));
          performance.add(AnalyticData(
              "Tue", double.parse(performanceJson['Tue'].toString())));
          performance.add(AnalyticData(
              "Wed", double.parse(performanceJson['Wed'].toString())));
          performance.add(AnalyticData(
              "Thu", double.parse(performanceJson['Thu'].toString())));
          performance.add(AnalyticData(
              "Fri", double.parse(performanceJson['Fri'].toString())));
          performance.add(AnalyticData(
              "Sat", double.parse(performanceJson['Sat'].toString())));
          performance.add(AnalyticData(
              "Sun", double.parse(performanceJson['Sun'].toString())));
        }
        if (progressJson != null) {
          progress.add(AnalyticData(
              "Mon", double.parse(progressJson[_subjectList.first].mon.toString())));

          progress.add(AnalyticData(
              "Tue", double.parse(progressJson[_subjectList.first].tue.toString())));
          progress.add(AnalyticData(
              "Wed", double.parse(progressJson[_subjectList.first].wed.toString())));
          progress.add(AnalyticData(
              "Thu", double.parse(progressJson[_subjectList.first].thu.toString())));
          progress.add(AnalyticData(
              "Fri", double.parse(progressJson[_subjectList.first].fri.toString())));
          progress.add(AnalyticData(
              "Sat", double.parse(progressJson[_subjectList.first].sat.toString())));
          progress.add(AnalyticData(
              "Sun", double.parse(progressJson[_subjectList.first].sun.toString())));
        }

        setState(() {});
        // }
      }
    });
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    final int len = Provider.of<HomeProvider>(context, listen: false)
        .homeEntity
        .banner!
        .length;
    // Set the duration for each image display
    const duration = Duration(seconds: 5);
    // Create a timer that triggers every 3 seconds
    timer = Timer.periodic(duration, (Timer timer) {
      // Update the index to scroll to the next image
      setState(() {
        currentIndex = (currentIndex + 1) % len;
        _scrollToNextItem();
      });
    });
  }

  void _scrollToNextItem() {
    if (currentIndex !=
        Provider.of<HomeProvider>(context, listen: false)
                .homeEntity
                .banner!
                .length -
            1) {
      _scrollController.animateTo(
        _scrollController.offset + MediaQuery.of(context).size.width * 0.8,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    } else {
      _scrollController.animateTo(0,
          duration: const Duration(milliseconds: 1000), curve: Curves.easeOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = context.watch<HomeProvider>();
    context.watch<OtherProvider>();
    int presscount = 0;
    final double screenWidth = MediaQuery.of(context).size.width;
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
        key: scaffoldKey01,
        bottomNavigationBar: bottomNavigationBar(context),
        drawerEdgeDragWidth: 120.sp,
        drawerDragStartBehavior: DragStartBehavior.down,
        drawer: const DrawerWidget(),
        appBar: AppBar(
          centerTitle: true,
          titleSpacing: 0.0,

          iconTheme: IconThemeData(
            color: Colors.black,
            //   size: 30.0,
          ),
          // drawerIconSize:
          title: PreferredSize(
            preferredSize: Size(MediaQuery.of(context).size.width, 50.h),
            child: ContainerWithBorder(
              boxColor: Colors.transparent,
              margin: EdgeInsets.only(right: 16.w, top: 5.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Hey ${Provider.of<AuthProvider>(context, listen: false).profileDetailsEntity.name}',
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: LoopsColors.colorBlack,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      /* IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.search,
                                color: LoopsColors.colorBlack,
                                size: 24.sp,
                              ),
                            ), */
                      InkWell(
                        onTap: () {
                          Provider.of<OtherProvider>(context, listen: false)
                              .routeNames
                              .add('/notification');
                          gotoNotification(context);
                          // Navigator.pushNamed(
                          //   context,
                          //   '/notification',
                          //   // (route) => false,
                          // );
                        },
                        child: Icon(
                          Icons.notifications_none_outlined,
                          color: LoopsColors.colorBlack,
                          size: 24.sp,
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        body: Container(
          margin: EdgeInsets.only(left: 16.w, right: 16.w, top: 12.h),
          child: ScrollConfiguration(
            behavior: MyBehavior(),
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10.w,
                ),
                if (Provider.of<HomeProvider>(context, listen: false)
                            .homeEntity
                            .banner !=
                        null &&
                    Provider.of<HomeProvider>(context, listen: false)
                        .homeEntity
                        .banner!
                        .isNotEmpty)
                  SizedBox(
                    height: 180.h,
                    child: ScrollConfiguration(
                      behavior: MyBehavior(),
                      child: ListView.builder(
                          controller: _scrollController,
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              Provider.of<HomeProvider>(context, listen: false)
                                  .homeEntity
                                  .banner!
                                  .length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(right: 24.w),
                              child: SizedBox(
                                width: screenWidth * 0.80,
                                child: Center(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12.sp),
                                    child: LoopsImage(
                                      height: 200,
                                      width: MediaQuery.of(context).size.width /
                                          1.1,
                                      path: /* index == 0
                                      ? 'assets/images/img/banner1.jpeg'
                                      : index == 1
                                          ? 'assets/images/img/banner2.png'
                                          : 'assets/images/img/banner3.jpeg' */
                                          Provider.of<HomeProvider>(context,
                                                  listen: false)
                                              .homeEntity
                                              .banner![index],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                SizedBox(
                  height: 36.h,
                ),
                if (Provider.of<HomeProvider>(context, listen: false)
                    .homeEntity
                    .recommendations!
                    .isNotEmpty)
                  Text(
                    'Recommendations',
                    style: appTheme.textTheme.titleMedium,
                  ),
                if (Provider.of<HomeProvider>(context, listen: false)
                    .homeEntity
                    .recommendations!
                    .isNotEmpty)
                  SizedBox(
                    height: 12.h,
                  ),
                if (Provider.of<HomeProvider>(context, listen: false)
                    .homeEntity
                    .recommendations!
                    .isNotEmpty)
                  SizedBox(
                    height: 160.h,
                    child: ScrollConfiguration(
                      behavior: MyBehavior(),
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              Provider.of<HomeProvider>(context, listen: false)
                                  .homeEntity
                                  .recommendations!
                                  .length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.all(4.w),
                              child: TestCard01(
                                testEntity: Provider.of<HomeProvider>(context,
                                        listen: false)
                                    .homeEntity
                                    .recommendations![index],
                                repeat: () {
                                  context
                                      .read<TestProvider>()
                                      .testStart
                                      .resumeQuesId = null;

                                  gotoTestInstructions(testType: "",
                                    context,
                                    testEntity: Provider.of<HomeProvider>(
                                            context,
                                            listen: false)
                                        .homeEntity
                                        .recommendations![index],
                                  );
                                },
                                results: () {
                                  if (Provider.of<HomeProvider>(context,
                                              listen: false)
                                          .homeEntity
                                          .recommendations![index]
                                          .text3
                                          ?.toUpperCase() ==
                                      'FINISHED') {
                                    gotoResults(
                                        context,
                                        Provider.of<HomeProvider>(context,
                                                listen: false)
                                            .homeEntity
                                            .recommendations![index]
                                            .testId
                                            ?.toInt(),
                                        1);
                                  }
                                },
                                resume: () {
                                  context
                                      .read<TestProvider>()
                                      .testStart
                                      .resumeQuesId = 1;

                                  if (Provider.of<HomeProvider>(context,
                                              listen: false)
                                          .homeEntity
                                          .recommendations![index]
                                          .text3
                                          ?.toUpperCase() ==
                                      'ONGOING') {
                                    gotoTestInstructions(
                                      testType: "",
                                      context,
                                      testEntity: Provider.of<HomeProvider>(
                                              context,
                                              listen: false)
                                          .homeEntity
                                          .recommendations![index],
                                    );
                                  }
                                },
                              ),
                            );
                          }),
                    ),
                  ),
                SizedBox(
                  height: 12.h,
                ),
                /* if ((Provider.of<HomeProvider>(context,
                                listen: false)
                            .homeEntity
                            .newBadge !=
                        null) ||
                    (Provider.of<HomeProvider>(context, listen: false)
                            .homeEntity
                            .newTests !=
                        null) ||
                    (Provider.of<HomeProvider>(context, listen: false)
                            .homeEntity
                            .newSubscription !=
                        null) ||
                    (Provider.of<HomeProvider>(context, listen: false)
                            .homeEntity
                            .newWeeklyReports !=
                        null)) */
                Text(
                  'Notice Board',
                  style: appTheme.textTheme.titleMedium,
                ),
                /* if ((Provider.of<HomeProvider>(context,
                                listen: false)
                            .homeEntity
                            .newBadge !=
                        null) ||
                    (Provider.of<HomeProvider>(context, listen: false)
                            .homeEntity
                            .newTests !=
                        null) ||
                    (Provider.of<HomeProvider>(context, listen: false)
                            .homeEntity
                            .newSubscription !=
                        null) ||
                    (Provider.of<HomeProvider>(context, listen: false)
                            .homeEntity
                            .newWeeklyReports !=
                        null)) */
                SizedBox(
                  height: 8.h,
                ),
                /* if ((Provider.of<HomeProvider>(context,
                                listen: false)
                            .homeEntity
                            .newBadge !=
                        null) ||
                    (Provider.of<HomeProvider>(context, listen: false)
                            .homeEntity
                            .newTests !=
                        null) ||
                    (Provider.of<HomeProvider>(context, listen: false)
                            .homeEntity
                            .newSubscription !=
                        null) ||
                    (Provider.of<HomeProvider>(context, listen: false)
                            .homeEntity
                            .newWeeklyReports !=
                        null)) */
                SizedBox(
                  height: 80.h,
                  child: ScrollConfiguration(
                    behavior: MyBehavior(),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            Provider.of<HomeProvider>(context, listen: false)
                                    .homeEntity
                                    .notifyList
                                    ?.length ??
                                0,
                        itemBuilder: (context, index) {
                          var data =
                              Provider.of<HomeProvider>(context, listen: false)
                                  .homeEntity
                                  .notifyList![index];
                          return Padding(
                            padding: EdgeInsets.all(6.sp),
                            child: InkWell(
                              onTap: () async {
                                if (data[1] == "notifyForNewTest") {
                                  await Provider.of<HomeProvider>(context,
                                          listen: false)
                                      .fnoticeClick(clicked: 'newTests')
                                      .onError((error, stackTrace) async {
                                    await handleError(error);
                                  });
                                } else if (data[1] == "notifyForSubscription") {
                                  Provider.of<HomeProvider>(context,
                                          listen: false)
                                      .fnoticeClick(clicked: 'newSubscription')
                                      .onError((error, stackTrace) async {
                                    await handleError(error);
                                  });
                                } else if (data[1] ==
                                    "notifyForNewWeeklyReport") {
                                  Provider.of<HomeProvider>(context,
                                          listen: false)
                                      .fnoticeClick(clicked: 'newWeeklyReports')
                                      .onError((error, stackTrace) async {
                                    await handleError(error);
                                  });
                                } else {
                                  Provider.of<HomeProvider>(context,
                                          listen: false)
                                      .fnoticeClick(clicked: 'newBadge')
                                      .onError((error, stackTrace) async {
                                    await handleError(error);
                                  });
                                }

                                showDialog(
                                  context: context,
                                  builder: (_) {
                                    return FunkyOverlay(
                                      index: index,
                                      name: setBadgesList(index),
                                      svg: true,
                                      text: data[1] == "notifyForNewTest"
                                          ? Provider.of<HomeProvider>(context,
                                                  listen: false)
                                              .homeEntity
                                              .newTests!
                                          : data[1] == "notifyForSubscription"
                                              ? Provider.of<HomeProvider>(
                                                      context,
                                                      listen: false)
                                                  .homeEntity
                                                  .newSubscription!
                                              : data[1] ==
                                                      "notifyForNewWeeklyReport"
                                                  ? Provider.of<HomeProvider>(
                                                          context,
                                                          listen: false)
                                                      .homeEntity
                                                      .newWeeklyReports!
                                                  : Provider.of<HomeProvider>(
                                                          context,
                                                          listen: false)
                                                      .homeEntity
                                                      .newBadge!,
                                    );
                                  },
                                );
                              },
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Hero(
                                    tag: index,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(color: Colors.grey,offset: Offset(0,4),spreadRadius: 0,blurRadius: 4)
                                        ]
                                      ),
                                      child: SvgPicture.asset(

                                        setBadgesList(index),
                                        height: 60.h,
                                      ),
                                    ),
                                  ),
                                  if (data[0] == true)
                                    Positioned(
                                      top: -5,
                                      right: -5,
                                      child: ContainerWithBorder(
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                LoopsColors.cardColors[index]
                                                    .withOpacity(0.3),
                                                LoopsColors.cardColors[index],
                                              ],
                                              begin:
                                                  AlignmentDirectional.topStart,
                                              end: AlignmentDirectional
                                                  .bottomEnd,
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(120.sp))),
                                        height: 16.sp,
                                        width: 16.sp,
                                        child: Text(
                                          '1',
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w600,
                                            color: LoopsColors.colorWhite,
                                          ),
                                        ),
                                      ),
                                    )
                                  else
                                    Container()
                                ],
                              ),
                            ),
                          );
                          /*  if ((index == 0 &&
                                    Provider.of<HomeProvider>(context,
                                                listen: false)
                                            .homeEntity
                                            .newBadge !=
                                        null) ||
                                (index == 1 &&
                                    Provider.of<HomeProvider>(context,
                                                listen: false)
                                            .homeEntity
                                            .newTests !=
                                        null) ||
                                (index == 2 &&
                                    Provider.of<HomeProvider>(context,
                                                listen: false)
                                            .homeEntity
                                            .newSubscription !=
                                        null) ||
                                (index == 3 &&
                                    Provider.of<HomeProvider>(context,
                                                listen: false)
                                            .homeEntity
                                            .newWeeklyReports !=
                                        null))  */
                          {
                            return Padding(
                              padding: EdgeInsets.only(right: 8.w),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(6.sp),
                                    child: InkWell(
                                      onTap: () async {
                                        switch (index) {
                                          case 0:
                                            Provider.of<HomeProvider>(context,
                                                    listen: false)
                                                .fnoticeClick(
                                                    clicked: 'newBadge')
                                                .onError(
                                                    (error, stackTrace) async {
                                              await handleError(error);
                                            });
                                            break;
                                          case 1:
                                            await Provider.of<HomeProvider>(
                                                    context,
                                                    listen: false)
                                                .fnoticeClick(
                                                    clicked: 'newTests')
                                                .onError(
                                                    (error, stackTrace) async {
                                              await handleError(error);
                                            });

                                            break;
                                          case 2:
                                            Provider.of<HomeProvider>(context,
                                                    listen: false)
                                                .fnoticeClick(
                                                    clicked: 'newSubscription')
                                                .onError(
                                                    (error, stackTrace) async {
                                              await handleError(error);
                                            });
                                            break;
                                          case 3:
                                            Provider.of<HomeProvider>(context,
                                                    listen: false)
                                                .fnoticeClick(
                                                    clicked: 'newWeeklyReports')
                                                .onError(
                                                    (error, stackTrace) async {
                                              await handleError(error);
                                            });
                                            break;

                                          default:
                                        }
                                        showDialog(
                                          context: context,
                                          builder: (_) {
                                            return FunkyOverlay(
                                              index: index,
                                              name: _badges[index],
                                              svg: true,
                                              text: index == 0
                                                  ? Provider.of<HomeProvider>(
                                                          context,
                                                          listen: false)
                                                      .homeEntity
                                                      .newBadge!
                                                  : index == 1
                                                      ? Provider.of<
                                                                  HomeProvider>(
                                                              context,
                                                              listen: false)
                                                          .homeEntity
                                                          .newTests!
                                                      : index == 2
                                                          ? Provider.of<
                                                                      HomeProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .homeEntity
                                                              .newSubscription!
                                                          : index == 3
                                                              ? Provider.of<
                                                                          HomeProvider>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .homeEntity
                                                                  .newWeeklyReports!
                                                              : '',
                                            );
                                          },
                                        );
                                      },
                                      child: Hero(
                                        tag: index,
                                        child: SvgPicture.asset(
                                          _badges[index],
                                          height: 60.h,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // if ((index == 0 &&
                                  //         (Provider.of<HomeProvider>(context,
                                  //                     listen: false)
                                  //                 .homeEntity
                                  //                 .notifyForNewBadge ??
                                  //             false)) ||
                                  //     (index == 1 &&
                                  //         (Provider.of<HomeProvider>(context,
                                  //                     listen: false)
                                  //                 .homeEntity
                                  //                 .notifyForNewTest ??
                                  //             false)) ||
                                  //     (index == 2 &&
                                  //         (Provider.of<HomeProvider>(context,
                                  //                     listen: false)
                                  //                 .homeEntity
                                  //                 .notifyForSubscription ??
                                  //             false)) ||
                                  //     (index == 3 &&
                                  //         (Provider.of<HomeProvider>(context,
                                  //                     listen: false)
                                  //                 .homeEntity
                                  //                 .notifyForNewWeeklyReport ??
                                  //             false)))

                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: ContainerWithBorder(
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              LoopsColors.cardColors[index]
                                                  .withOpacity(0.3),
                                              LoopsColors.cardColors[index],
                                            ],
                                            begin:
                                                AlignmentDirectional.topStart,
                                            end: AlignmentDirectional.bottomEnd,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(120.sp))),
                                      height: 16.sp,
                                      width: 16.sp,
                                      child: Text(
                                        '1',
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w600,
                                          color: LoopsColors.colorWhite,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          } /* else {
                              return Container();
                            } */
                        }),
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                if (Provider.of<HomeProvider>(context, listen: false)
                    .homeEntity
                    .loops!
                    .isNotEmpty)
                  Text(
                    'Recomended Loops',
                    style: appTheme.textTheme.titleMedium,
                  ),
                if (Provider.of<HomeProvider>(context, listen: false)
                    .homeEntity
                    .loops!
                    .isNotEmpty)
                  SizedBox(
                    height: 20.h,
                  ),
                if (Provider.of<HomeProvider>(context, listen: false)
                    .homeEntity
                    .loops!
                    .isNotEmpty)
                  SizedBox(
                    height: 155.h,
                    child: ScrollConfiguration(
                      behavior: MyBehavior(),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            Provider.of<HomeProvider>(context, listen: false)
                                .homeEntity
                                .loops!
                                .length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Provider.of<TestProvider>(context, listen: false)
                                  .floopsHome()
                                  .then((value) {
                                Provider.of<TestProvider>(context,
                                        listen: false)
                                    .floopsBottomSheet(
                                        Provider.of<HomeProvider>(context,
                                                listen: false)
                                            .homeEntity
                                            .loops![index])
                                    .then((_) {
                                  if (Provider.of<TestProvider>(context,
                                          listen: false)
                                      .loopsBottomSheetEntity
                                      .start!) {
                                    Provider.of<TestProvider>(context,
                                        listen: false).practice = false;
                                    num? testId = Provider.of<HomeProvider>(
                                            context,
                                            listen: false)
                                        .homeEntity
                                        .loops![index]
                                        .id as num?;
                                    showPopup01(
                                        context,
                                        context
                                            .read<TestProvider>()
                                            .loopsHomeEntity
                                            .subjects!,
                                        Provider.of<TestProvider>(context,
                                            listen: false),
                                        testId!,Provider.of<HomeProvider>(context,
                                        listen: false)
                                        .homeEntity
                                        .loops![index]
                                        .imagePath!);
                                  } else if (Provider.of<TestProvider>(context,
                                          listen: false)
                                      .loopsBottomSheetEntity
                                      .resume!) {
                                    num? testId = Provider.of<HomeProvider>(
                                            context,
                                            listen: false)
                                        .homeEntity
                                        .loops![index] as num?;

                                    showPopup02(
                                        context,
                                        context
                                            .read<TestProvider>()
                                            .loopsHomeEntity
                                            .subjects!,
                                        Provider.of<TestProvider>(context,
                                            listen: false),
                                        testId!,Provider.of<HomeProvider>(context,
                                        listen: false)
                                        .homeEntity
                                        .loops![index]
                                        .imagePath!);
                                  } else if (Provider.of<TestProvider>(context,
                                              listen: false)
                                          .loopsBottomSheetEntity
                                          .retake! ||
                                      Provider.of<TestProvider>(context,
                                              listen: false)
                                          .loopsBottomSheetEntity
                                          .results!) {
                                    Provider.of<TestProvider>(context,
                                        listen: false).practice = false;
                                    showPopup03(
                                      context,
                                      context
                                          .read<TestProvider>()
                                          .loopsHomeEntity
                                          .subjects!,
                                      Provider.of<TestProvider>(context,
                                          listen: false),Provider.of<HomeProvider>(context,
                                        listen: false)
                                        .homeEntity
                                        .loops![index]
                                        .imagePath!
                                    );
                                  }
                                });
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.only(right: 14.w),
                              child: Column(
                                children: [
                                  LoopsImage(
                                    path: Provider.of<HomeProvider>(context,
                                            listen: false)
                                        .homeEntity
                                        .loops![index]
                                        .imagePath!,
                                  ),
                                  /* ContainerWithBorder(
                                    boxColor:
                                        const Color.fromARGB(168, 245, 73, 125),
                                    borderRadius: 100.sp,
                                    height: 65.sp,
                                    width: 65.sp,
                                    child: const Center(
                                      child: Icon(Icons.bubble_chart),
                                    ),
                                  ), */
                                  SizedBox(
                                    height: 6.h,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    height: 40.h,
                                    child: Text(
                                      Provider.of<HomeProvider>(context,
                                              listen: false)
                                          .homeEntity
                                          .loops![index]
                                          .name!,
                                      textAlign: TextAlign.center,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        color: LoopsColors.colorGrey,
                                      ),
                                    ),
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
                  height: 12.h,
                ),
                Row(
                  children: [
                    Text(
                      'Analytics',
                      style: appTheme.textTheme.titleMedium,
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    // Container(
                    //   height: 26.h,
                    //   decoration: BoxDecoration(
                    //       color: LoopsColors.tertiaryColor,
                    //       borderRadius:
                    //           BorderRadius.all(Radius.circular(12.sp))),
                    //   child: Row(
                    //     children: [
                    //       Padding(
                    //         padding: EdgeInsets.symmetric(horizontal: 8.w),
                    //         child: Icon(
                    //           Icons.circle,
                    //           size: 6.sp,
                    //           color: LoopsColors.colorGreen,
                    //         ),
                    //       ),
                    //       Text(
                    //         'Your Activity is improved over last week',
                    //         style: appTheme.textTheme.bodyLarge!.copyWith(
                    //           fontSize: 10.sp,
                    //           fontWeight: FontWeight.w600,
                    //           color: LoopsColors.primaryColor,
                    //         ),
                    //       ),
                    //       Padding(
                    //         padding: EdgeInsets.symmetric(horizontal: 8.w),
                    //       ),
                    //     ],
                    //   ),
                    // )
                  ],
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
                                      if (index == 1 && _subjectList.isNotEmpty)
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
                                                width: 70.w,height:40.h,
                                                child: PopupMenuButton<int>(
                                                      offset: Offset(40, 100),
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
                                                    progress.clear();
                                                    progress.add(AnalyticData(
                                                        "Mon", double.parse(progressJson[_subjectList[
                                                        _selectedIndex03]].mon.toString())));

                                                    progress.add(AnalyticData(
                                                        "Tue", double.parse(progressJson[_subjectList[
                                                        _selectedIndex03]].tue.toString())));
                                                    progress.add(AnalyticData(
                                                        "Wed", double.parse(progressJson[_subjectList[
                                                        _selectedIndex03]].wed.toString())));
                                                    progress.add(AnalyticData(
                                                        "Thu", double.parse(progressJson[_subjectList[
                                                        _selectedIndex03]].thu.toString())));
                                                    progress.add(AnalyticData(
                                                        "Fri", double.parse(progressJson[_subjectList[
                                                        _selectedIndex03]].fri.toString())));
                                                    progress.add(AnalyticData(
                                                        "Sat", double.parse(progressJson[_subjectList[
                                                        _selectedIndex03]].sat.toString())));
                                                    progress.add(AnalyticData(
                                                        "Sun", double.parse(progressJson[_subjectList[
                                                        _selectedIndex03]].sun.toString())));
                                                    setState(() {});

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
                                                    //         .forEach(
                                                    //             (key02, value) {
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
                                                  },
                                                  itemBuilder: (context) {
                                                    return <
                                                        PopupMenuEntry<int>>[
                                                      for (var i = 0;
                                                          i <
                                                              _subjectList
                                                                  .length;
                                                          i++)
                                                        PopupMenuItem(
                                                            value: i,
                                                            child: Text(
                                                              _subjectList[i],
                                                              style: TextStyle(
                                                                fontSize: 10.sp,
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
                                  child:
                                  /* SfCartesianChart(
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
                                        ? activity
                                        : index == 1
                                            ? progress
                                            : performance,
                                  )),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 32.h,
                ),
                Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Wrap(
                        spacing: 12.sp,
                        runSpacing: 12.sp,
                        children: [
                          for (var item in Provider.of<HomeProvider>(context,
                                  listen: false)
                              .homefaQsEntity)
                            ContainerWithBorder(
                              height: 32.h,
                              borderRadius: 14.sp,
                              // borderColor: LoopsColors.primaryColor,
                              width: item.question!.length * 8.7.w,
                              boxColor: _selectedAnalytics == item.question
                                  ? LoopsColors.secondaryColor.withOpacity(0.2)
                                  : LoopsColors.whiteBkground,
                              borderColor: _selectedAnalytics == item.question
                                  ? LoopsColors.secondaryColor.withOpacity(0.2)
                                  : LoopsColors.primaryColor,
                              child: InkWell(
                                onTap: () {
                                  /* if (analytics.indexWhere(
                                          (element) => element == item) ==
                                      2) {
                                    _firstTime = false;
                                  } */
                                  _selectedAnalytics = item.question;
                                  homeProvider.setState();
                                },
                                child: Text(
                                  item.question!,
                                  style: appTheme.textTheme.bodyLarge!.copyWith(
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
                            Text(
                              _selectedAnalytics ??
                                  Provider.of<HomeProvider>(context,
                                          listen: false)
                                      .homefaQsEntity
                                      .first
                                      .question!,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: LoopsColors.primaryColor,
                                letterSpacing: 0.03.sp,
                              ),
                            ),
                            SizedBox(
                              height: 12.h,
                            ),
                            if (Provider.of<HomeProvider>(context,
                                    listen: false)
                                .homefaQsEntity
                                .isNotEmpty)
                              Text(
                                Provider.of<HomeProvider>(context,
                                        listen: false)
                                    .homefaQsEntity
                                    .firstWhere((element) =>
                                        element.question == _selectedAnalytics)
                                    .answer!,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: LoopsColors.primaryColor,
                                  letterSpacing: 0.1.sp,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  'Getting Started',
                  style: appTheme.textTheme.titleMedium,
                ),
                SizedBox(
                  height: 12.h,
                ),
                Container(
                  height: 120,
                  width: 100,
                  child: ListView.builder(
                    itemCount: homeProvider.videoEntity.videos?.length ?? 0,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return FutureBuilder<String>(
                        future: getImagePath(homeProvider.videoEntity.videos?[index].imagePath ?? ""),
                        builder: (context, snapshot) {
                        return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => VideoInAppWebViewScreen(
                                        videoUrl:
                                        homeProvider.videoEntity.videos?[index].url ?? ""),
                                  ));
                            },
                            child: snapshot.hasData ? SvgPicture.network(
                                snapshot.data!,
                                height: 120) : Container());
                      },);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

 List<String> _subjectList = [
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
    gotoHomePage(navigatorKey.currentContext!);
  }
  return scaffoldKey01.currentState?.isDrawerOpen ??
      scaffoldKey02.currentState?.isDrawerOpen ??
      scaffoldKey03.currentState?.isDrawerOpen ??
      scaffoldKey04.currentState?.isDrawerOpen ??
      scaffoldKey05.currentState?.isDrawerOpen ??
      false;
}
