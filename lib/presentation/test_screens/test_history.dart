import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rao_academy/application/test/test_provider.dart';
import 'package:rao_academy/application/other/other_provider.dart';
import 'package:rao_academy/core/theme/custom_scroll_behaviour.dart';
import 'package:rao_academy/core/utli/goto_pages.dart';
import 'package:rao_academy/core/utli/loops_urls.dart';
import 'package:rao_academy/core/widgets/container_with_border.dart';
import 'package:rao_academy/core/widgets/custom_text_field.dart';
import 'package:rao_academy/core/widgets/expandable_panel_with_child.dart';
import 'package:provider/provider.dart';
import 'package:rao_academy/domain/entities/recommendations_entity.dart';

class TestHistory extends StatefulWidget {
  TestHistory({Key? key}) : super(key: key);

  @override
  State<TestHistory> createState() => _TestHistoryState();
}

class _TestHistoryState extends State<TestHistory> {
  TextEditingController searchText = TextEditingController();
  bool isSearch = false;


  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TestProvider>();
    if (kDebugMode) {
      print("HISTORY");
      print(provider.testHistoryEntity.filter1?.length);
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            Provider
                .of<OtherProvider>(context, listen: false)
                .routeNames
                .remove(Provider
                .of<OtherProvider>(context, listen: false)
                .routeNames
                .last);
          },
          icon: Icon(
            Icons.arrow_back,
            color: LoopsColors.whiteBkground,
            size: 24.sp,
          ),
        ),
        backgroundColor: LoopsColors.primaryColor,
        title: Text(
          'Test History',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
        Row(
        children: [
        Expanded(
        child: CustomTextField(
          controller: searchText,
          borderAround: true,
          suffixIcon: IconButton(
            onPressed: () async {
              setState(() {
                isSearch = !isSearch;
              });
              if (!isSearch) {
                searchText.clear();
                await provider.ftestHistory(
                    null, null, null, "", null);
              } else {
                await provider.ftestHistory(
                    null, null, null, searchText.text, null);
              }
            },
            icon: Icon(
              isSearch ? Icons.close : Icons.search,
              size: 20.sp,
              color: LoopsColors.colorGrey,
            ),
          ),
          hintText: 'Search',
        ),
      ),
      // IconButton(
      //   onPressed: () {
      //     showDialog(
      //       context: context,
      //       builder: (BuildContext context) {
      //         return AlertDialog(
      //           title: Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               const Text(''),
      //               Icon(
      //                 Icons.filter_alt,
      //                 color: LoopsColors.colorGrey,
      //                 size: 24.sp,
      //               ),
      //             ],
      //           ),
      //           content: SizedBox(
      //             height:
      //                 (provider.testHistoryEntity.filter1?.length ??
      //                         0) *
      //                     40.h,
      //             width: 209.w,
      //             child: ScrollConfiguration(
      //               behavior: MyBehavior(),
      //               child: ListView.builder(
      //                 itemCount:
      //                     provider.testHistoryEntity.filter1?.length,
      //                 itemBuilder: (context, index) => Row(
      //                   children: [
      //                     ContainerWithBorder(
      //                       margin: EdgeInsets.symmetric(
      //                           horizontal: 24.sp),
      //                       height: 12.sp,
      //                       width: 12.sp,
      //                       borderRadius: 12.sp,
      //                       boxColor: LoopsColors.lightGrey,
      //                     ),
      //                     Text(
      //                       provider.testHistoryEntity
      //                               .filter1?[index] ??
      //                           '',
      //                       style: TextStyle(
      //                         fontSize: 14.sp,
      //                         fontWeight: FontWeight.w400,
      //                       ),
      //                     )
      //                   ],
      //                 ),
      //               ),
      //             ),
      //           ),
      //         );
      //       },
      //     );
      //   },
      //   icon: Column(
      //     children: [
      //       Icon(
      //         Icons.filter_alt,
      //         color: LoopsColors.colorGrey,
      //         size: 24.sp,
      //       ),
      //       SizedBox(
      //         height: 2.h,
      //       ),
      //     ],
      //   ),
      // )
      ],
    ),
    Expanded(
    child: ScrollConfiguration(
    behavior: MyBehavior(),
    child: ListView.builder(
    itemCount: provider.testHistoryEntity.test
        ?.length, //TODO: fix this from backend
    itemBuilder: (context, index1) {
    return Container(
    // height: 46.h,
    constraints: BoxConstraints(
    minHeight: 46.h,
    ),
    margin: EdgeInsets.symmetric(vertical: 4.sp),
    padding: EdgeInsets.symmetric(horizontal: 12.sp),
    decoration: BoxDecoration(
    borderRadius: BorderRadius.all(
    Radius.circular(4.sp),
    ),
    border: Border.all(
    width: 0.5.sp,
    color: LoopsColors.textColor.withOpacity(0.5),
    ),
    ),
    child: showExpandablePanelWC(
    provider.testHistoryEntity.test?[index1].month ?? '',
    SizedBox(
    height: 116.h *
    (provider.testHistoryEntity.test?[index1].tests
        ?.length ??
    0),
    child: ListView.builder(
    physics: const NeverScrollableScrollPhysics(),
    itemCount: provider.testHistoryEntity
        .test?[index1].tests?.length,
    itemBuilder: (context, indexx) {
    if (kDebugMode) {
    // print("CHECK");
    // print(provider.testHistoryEntity
    //     .test?[index1].tests?[0]);
    }
    return Row(
    children: [
    Expanded(
    flex: 3,
    child: Column(
    children: [
    Text(
    provider
        .testHistoryEntity
        .test[index1]
        ?.tests?[indexx]
        .date
        ?.split(',')
        .first ??
    '',
    style: TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: LoopsColors.colorBlack,
    ),
    ),
    Text(
    provider
        .testHistoryEntity
        .test?[index1]
        .tests?[indexx]
        .date
        ?.split(',')[1] ??
    '',
    style: TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    ),
    ),
    Text(
    provider
        .testHistoryEntity
        .test?[index1]
        .tests?[indexx]
        .date
        ?.split(',')
        .last ??
    '',
    style: TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    ),
    ),
    ],
    ),
    ),
    if (provider.testHistoryEntity
        .test![index1].tests!.length >
    1)
    Column(
    children: [
    if (indexx != 0)
    Container(
    color: LoopsColors.textColor,
    height: 22.h,
    width: 1.sp,
    )
    else
    Container(
    height: 22.h,
    ),
    ContainerWithBorder(
    height: 12.sp,
    width: 12.sp,
    borderRadius: 12.sp,
    boxColor: LoopsColors.textColor,
    ),
    if (indexx != 3)
    Container(
    color: LoopsColors.textColor,
    height: 80,
    width: 1.sp,
    )
    else
    Container(
    height: 58.h,
    ),
    ],
    )
    else
    ContainerWithBorder(
    height: 12.sp,
    width: 12.sp,
    borderRadius: 12.sp,
    boxColor: LoopsColors.textColor,
    ),
    Expanded(
    flex: 7,
    child: Padding(
    padding: EdgeInsets.only(left: 12.w),
    child: Column(
    crossAxisAlignment:
    CrossAxisAlignment.start,
    children: [
    Text(
    provider
        .testHistoryEntity
        .test[index1]
        ?.tests?[indexx]
        .text1 ??
    '',
    style: TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: LoopsColors.colorBlack,
    ),
    ),

    if (provider
        .testHistoryEntity
        .test?[index1]
        .tests?[indexx]
        .testType !=
    "Loops")
    Text(
    provider
        .testHistoryEntity
        .test?[index1]
        .tests?[indexx]
        .text2 ??
    '',
    style: TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    ),
    ),
    // if (provider
    //         .testHistoryEntity
    //         .test?[index1]
    //         .tests?[indexx]
    //         .testType ==
    //     "Loops")
    Text.rich(
    TextSpan(
    children: [
    TextSpan(
    text: provider
        .testHistoryEntity
        .test?[index1]
        .tests?[indexx]
        .testType ??
    '',
    style: TextStyle(
    fontSize: 12.sp,
    fontWeight:
    FontWeight.bold,
    ),
    ),
    TextSpan(
    text:
    ' | '), // Give a space
    TextSpan(
    text: provider
        .testHistoryEntity
        .test?[index1]
        .tests?[
    indexx]
        .practice ??
    false
    ? "Practice Test"
        : provider
        .testHistoryEntity
        .test?[index1]
        .tests?[
    indexx]
        .text3 ??
    '',
    style: TextStyle(
    fontSize: 12.sp,
    fontWeight:
    FontWeight.w400,
    color:
    Colors.black87),
    ),
    ],
    ),
    ),
    // Text(
    //   provider
    //           .testHistoryEntity
    //           .test?[index1]
    //           .tests?[indexx]
    //           .text3 ??
    //       '',
    //   style: TextStyle(
    //     fontSize: 12.sp,
    //     fontWeight: FontWeight.w400,
    //   ),
    // ),
    SizedBox(
    height: 4.h,
    ),
    SizedBox(
    height: 22.h,
    child: ScrollConfiguration(
    behavior: MyBehavior(),
    child: provider
        .testHistoryEntity
        .test?[index1]
        .tests?[indexx]
        .resume ==
    true
    ? Row(
    children: [
    Padding(
    padding: EdgeInsets
        .symmetric(
    horizontal:
    4.sp),
    child: Container(
    padding: EdgeInsets
        .symmetric(
    horizontal:
    6.sp),
    height: 19.h,
    decoration:
    BoxDecoration(
    color: LoopsColors
        .colorYellow1,
    borderRadius:
    BorderRadius
        .all(
    Radius.circular(
    2.sp),
    ),
    ),
    child: Center(
    child: Text(
    (provider.testHistoryEntity.test?[index1].tests?[indexx].resume ??
    false)
    ? 'Paused'
        : !(provider.testHistoryEntity.test?[index1].tests?[indexx].result ??
    false)
    ? 'No Idea'
        : 'Completed',
    style: TextStyle(
    fontSize: 11
        .sp,
    fontWeight:
    FontWeight
        .w400,
    color: LoopsColors
        .iconColor2),
    ),
    ),
    ),
    ),
    Padding(
    padding: EdgeInsets
        .symmetric(
    horizontal:
    4.sp),
    child: InkWell(
    onTap: () {
    // gotoTestInstructions(
    //     context,
    //     testEntity:
    //         TestEntity(
    //       testId: provider
    //           .testHistoryEntity
    //           .test?[index1]
    //           .tests?[indexx]
    //           .testId,
    //       userTestId: provider
    //           .testHistoryEntity
    //           .test?[index1]
    //           .tests?[indexx]
    //           .userTestId,
    //       text1: provider
    //           .testHistoryEntity
    //           .test?[index1]
    //           .tests?[indexx]
    //           .text1,
    //       text2: provider
    //           .testHistoryEntity
    //           .test?[index1]
    //           .tests?[indexx]
    //           .text2,
    //       text3: provider
    //           .testHistoryEntity
    //           .test?[index1]
    //           .tests?[indexx]
    //           .text3,
    //     ));
    provider
        .testStart
        .resumeQuesId = 1;
    if (kDebugMode) {
      print("------${provider.testHistoryEntity.test[index1].tests?[indexx].testType}");
    }
    provider.testStart.testType = provider.testHistoryEntity.test[index1].tests?[indexx].testType;
    if (provider
        .testHistoryEntity
        .test?[
    index1]
        .tests?[
    indexx]
        .practice ??
    false) {
    provider.practice =
    true;
    } else {
    provider.practice =
    false;
    }
    gotoTestInstructions(
    testType: provider.testHistoryEntity.test?[index1].tests?[indexx].practice ??
    false
    ? "Practice"
        : provider.testHistoryEntity.test?[index1].tests?[indexx].testType ??
    "",
    context,
    testEntity:
    TestEntity(
    testId: provider
        .testHistoryEntity
        .test?[index1]
        .tests?[indexx]
        .testId,
    userTestId: provider
        .testHistoryEntity
        .test?[index1]
        .tests?[indexx]
        .userTestId,
    text1: provider
        .testHistoryEntity
        .test?[index1]
        .tests?[indexx]
        .text1,
    text2: provider
        .testHistoryEntity
        .test?[index1]
        .tests?[indexx]
        .text2,
    text3: provider
        .testHistoryEntity
        .test?[index1]
        .tests?[indexx]
        .text3,
    ),
    customConceptIds: provider
        .testHistoryEntity
        .test?[
    index1]
        .tests?[
    indexx]
        .conceptIds,
    customFormats: provider
        .testHistoryEntity
        .test?[
    index1]
        .tests?[
    indexx]
        .formats,
    customLevels: provider
        .testHistoryEntity
        .test?[
    index1]
        .tests?[
    indexx]
        .levels,
    chaptersId: provider
        .testHistoryEntity
        .test?[
    index1]
        .tests?[
    indexx]
        .chapterIds,
    questionsId: provider
        .testHistoryEntity
        .test?[
    index1]
        .tests?[
    indexx]
        .questionIds,
    customName: provider
        .testHistoryEntity
        .test?[
    index1]
        .tests?[
    indexx]
        .text1,
    fromCustomTest: provider.testHistoryEntity.test?[index1].tests?[indexx].testType ==
    "Custom Test"
    ? true
        : false);
    },
    child:
    Container(
    padding: EdgeInsets
        .symmetric(
    horizontal:
    6.sp),
    height: 19.h,
    decoration:
    BoxDecoration(
    color: LoopsColors
        .colorsList02[1],
    borderRadius:
    BorderRadius
        .all(
    Radius.circular(
    2.sp),
    ),
    ),
    child: Center(
    child: Text(
    'Resume',
    style:
    TextStyle(
    fontSize:
    11.sp,
    fontWeight:
    FontWeight.w600,
    color: LoopsColors
        .colorWhite,
    ),
    ),
    ),
    ),
    ),
    ),
    ],
    )
        : Row(
    children: [
    Padding(
    padding: EdgeInsets
        .symmetric(
    horizontal:
    4.sp),
    child: Container(
    padding: EdgeInsets
        .symmetric(
    horizontal:
    6.sp),
    height: 19.h,
    decoration:
    BoxDecoration(
    color: LoopsColors
        .colorYellow1,
    borderRadius:
    BorderRadius
        .all(
    Radius.circular(
    2.sp),
    ),
    ),
    child: Center(
    child: Text(
    (provider.testHistoryEntity.test?[index1].tests?[indexx].resume ??
    false)
    ? 'Paused'
        : !(provider.testHistoryEntity.test?[index1].tests?[indexx].result ??
    false)
    ? 'No Idea'
        : 'Completed',
    style: TextStyle(
    fontSize: 11
        .sp,
    fontWeight:
    FontWeight
        .w400,
    color: LoopsColors
        .iconColor2),
    ),
    ),
    ),
    ),
    Padding(
    padding: EdgeInsets
        .symmetric(
    horizontal:
    4.sp),
    child: InkWell(
    onTap: () {
    provider.testEntity =
    TestEntity(
    testId: provider
        .testHistoryEntity
        .test?[
    index1]
        .tests?[
    indexx]
        .testId,
    userTestId: provider
        .testHistoryEntity
        .test?[
    index1]
        .tests?[
    indexx]
        .userTestId,
    text1: provider
        .testHistoryEntity
        .test?[
    index1]
        .tests?[
    indexx]
        .text1,
    text2: provider
        .testHistoryEntity
        .test?[
    index1]
        .tests?[
    indexx]
        .text2,
    text3: provider
        .testHistoryEntity
        .test?[
    index1]
        .tests?[
    indexx]
        .text3,
    );
    if (kDebugMode) {
    print(
    "STEP-1");
    }
    (provider
        .testHistoryEntity
        .test?[
    index1]
        .tests?[
    indexx]
        .userTestId)!
        .toInt();
    if (kDebugMode) {
    print(
    "STEP-2");
    print(provider
        .testHistoryEntity
        .test?[
    index1]
        .tests?[
    indexx]
        .userTestId
        ?.toInt());
    }
    if (provider
        .testHistoryEntity
        .test?[
    index1]
        .tests?[
    indexx]
        .testType ==
    "Loops") {
    gotoSprintHistory(
    context,
    // (provider
    //         .loopsHomeEntity
    //         .loops?[id_get_from_provider]
    //         .chapterId)!
    //     .toInt(),
    (provider.testHistoryEntity.test[index1].tests?[indexx].userTestId)!
        .toInt(),
    provider.testHistoryEntity.test?[index1].tests?[indexx].text1 ??
    "");
    } else {
    gotoResults(
    context,
    provider
        .testHistoryEntity
        .test?[index1]
        .tests?[indexx]
        .userTestId
        ?.toInt(),
    2);
    }
    },
    child: Row(
    children: [
    Container(
    padding: EdgeInsets.symmetric(
    horizontal:
    6.sp),
    height:
    19.h,
    decoration:
    BoxDecoration(
    color: LoopsColors
        .colorBlue4,
    borderRadius:
    BorderRadius.all(
    Radius.circular(
    2.sp),
    ),
    ),
    child:
    Center(
    child:
    Text(
    'Results',
    style:
    TextStyle(
    fontSize:
    11.sp,
    fontWeight:
    FontWeight.w600,
    color:
    LoopsColors.colorWhite,
    ),
    ),
    ),
    ),
    if (provider
        .testHistoryEntity
        .test?[index1]
        .tests?[indexx]
        .result ??
    false)
    Padding(
    padding:
    EdgeInsets.symmetric(horizontal: 4.sp),
    child:
    InkWell(
    onTap:
    () {
    provider.testStart.resumeQuesId =
    null;
    if (provider.testHistoryEntity.test[index1].tests?[indexx].practice ??
    false) {
    provider.practice = true;
    } else {
    provider.practice = false;
    provider.testHistoryEntity.test?[index1].tests?[indexx].userTestId = null;
    provider.testEntity.userTestId = null;
    }
    if (provider.testHistoryEntity.test?[index1].tests?[indexx].testType == "Custom Test") {
      Fluttertoast.showToast(
          msg: "Go to Test Home page and create a your own Custom Test");
    }
    else if (provider.testHistoryEntity.test?[index1].tests?[indexx].testType == "Loops") {
    Fluttertoast.showToast(msg: "Go to Loops page and Start a New Loop with New Target");
    } else {
    gotoTestInstructions(
    testType: provider.testHistoryEntity.test?[index1].tests?[indexx].testType ?? "",
    context,
    testEntity: TestEntity(
    testId: provider.testHistoryEntity.test?[index1].tests?[indexx].testId,
    userTestId: provider.testHistoryEntity.test?[index1].tests?[indexx].userTestId,
    text1: provider.testHistoryEntity.test?[index1].tests?[indexx].text1,
    text2: provider.testHistoryEntity.test?[index1].tests?[indexx].text2,
    text3: provider.testHistoryEntity.test?[index1].tests?[indexx].text3,
    ),
    customConceptIds: provider.testHistoryEntity.test?[index1].tests?[indexx].conceptIds,
    customFormats: provider.testHistoryEntity.test?[index1].tests?[indexx].formats,
    customLevels: provider.testHistoryEntity.test?[index1].tests?[indexx].levels,
    chaptersId: provider.testHistoryEntity.test?[index1].tests?[indexx].chapterIds,
    questionsId: provider.testHistoryEntity.test?[index1].tests?[indexx].questionIds,
    customName: provider.testHistoryEntity.test?[index1].tests?[indexx].text1,
    isPrecticeTest: provider.testHistoryEntity.test[index1].tests?[indexx].practice ?? false,
    fromCustomTest: provider.testHistoryEntity.test?[index1].tests?[indexx].testType == "Custom Test" ? true : false);
    }
    // gotoStartTest(
    //     context,
    //     TestEntity(
    //       testId: provider.testHistoryEntity.test?[index1].tests?[indexx].testId,
    //       userTestId: provider.testHistoryEntity.test?[index1].tests?[indexx].userTestId,
    //       text1: provider.testHistoryEntity.test?[index1].tests?[indexx].text1,
    //       text2: provider.testHistoryEntity.test?[index1].tests?[indexx].text2,
    //       text3: provider.testHistoryEntity.test?[index1].tests?[indexx].text3,
    //     ),
    //     fromCustomTest: false);
    },
    child:
    Container(
    padding:
    EdgeInsets.symmetric(horizontal: 6.sp),
    height:
    19.h,
    decoration:
    BoxDecoration(
    color: LoopsColors.colorBlue4,
    borderRadius: BorderRadius.all(
    Radius.circular(2.sp),
    ),
    ),
    child:
    Center(
    child: Text(
    'Retake',
    style: TextStyle(
    fontSize: 11.sp,
    fontWeight: FontWeight.w600,
    color: LoopsColors.colorWhite,
    ),
    ),
    ),
    ),
    ),
    )
    else
    Container()
    ],
    ),
    ),
    ),
    ],
    ),

    // ListView.builder(
    //     scrollDirection:
    //         Axis.horizontal,
    //     itemCount: provider
    //         .testHistoryEntity
    //         .test?[index1]
    //         .tests
    //         ?.length,
    //     itemBuilder:
    //         (context, index) {
    //
    //       var mVal = provider
    //           .testHistoryEntity
    //           .test?[index1]
    //           .tests![index];
    //
    //       if(mVal?.resume == true && mVal?.result == false)
    //         return Row(
    //           children: [
    //             Padding(
    //               padding: EdgeInsets
    //                   .symmetric(
    //                   horizontal:
    //                   4.sp),
    //               child: Container(
    //                 padding: EdgeInsets
    //                     .symmetric(
    //                     horizontal:
    //                     6.sp),
    //                 height: 19.h,
    //                 decoration:
    //                 BoxDecoration(
    //                   color: LoopsColors
    //                       .colorYellow1,
    //                   borderRadius:
    //                   BorderRadius
    //                       .all(
    //                     Radius
    //                         .circular(
    //                         2.sp),
    //                   ),
    //                 ),
    //                 child: Center(
    //                   child: Text(
    //                     (provider
    //                         .testHistoryEntity
    //                         .test?[index1]
    //                         .tests?[indexx]
    //                         .resume ??
    //                         false)
    //                         ? 'Paused'
    //                         : !(provider.testHistoryEntity.test?[index1].tests?[indexx].result ?? false)
    //                         ? 'No Idea'
    //                         : 'Completed',
    //                     style: TextStyle(
    //                         fontSize:
    //                         11.sp,
    //                         fontWeight:
    //                         FontWeight
    //                             .w400,
    //                         color: LoopsColors
    //                             .iconColor2),
    //                   ),
    //                 ),
    //               ),
    //             ),
    //             Padding(
    //               padding: EdgeInsets
    //                   .symmetric(
    //                   horizontal:
    //                   4.sp),
    //               child: InkWell(
    //                 onTap: () {
    //                   gotoTestInstructions(
    //                       context,
    //                       testEntity:
    //                       TestEntity(
    //                         testId: provider
    //                             .testHistoryEntity
    //                             .test?[
    //                         index1]
    //                             .tests?[
    //                         indexx]
    //                             .testId,
    //                         userTestId: provider
    //                             .testHistoryEntity
    //                             .test?[
    //                         index1]
    //                             .tests?[
    //                         indexx]
    //                             .userTestId,
    //                         text1: provider
    //                             .testHistoryEntity
    //                             .test?[
    //                         index1]
    //                             .tests?[
    //                         indexx]
    //                             .text1,
    //                         text2: provider
    //                             .testHistoryEntity
    //                             .test?[
    //                         index1]
    //                             .tests?[
    //                         indexx]
    //                             .text2,
    //                         text3: provider
    //                             .testHistoryEntity
    //                             .test?[
    //                         index1]
    //                             .tests?[
    //                         indexx]
    //                             .text3,
    //                       ));
    //                 },
    //                 child: Container(
    //                   padding: EdgeInsets
    //                       .symmetric(
    //                       horizontal:
    //                       6.sp),
    //                   height: 19.h,
    //                   decoration:
    //                   BoxDecoration(
    //                     color: LoopsColors
    //                         .colorsList02[1],
    //                     borderRadius:
    //                     BorderRadius
    //                         .all(
    //                       Radius.circular(
    //                           2.sp),
    //                     ),
    //                   ),
    //                   child: Center(
    //                     child: Text(
    //                       'Resume',
    //                       style:
    //                       TextStyle(
    //                         fontSize:
    //                         11.sp,
    //                         fontWeight:
    //                         FontWeight
    //                             .w600,
    //                         color: LoopsColors
    //                             .colorWhite,
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ],
    //         );
    //       else if(mVal?.resume == false && mVal?.result == true)
    //         return  Row(
    //           children: [
    //         Padding(
    //         padding: EdgeInsets
    //             .symmetric(
    //         horizontal:
    //             4.sp),
    //           child: InkWell(
    //           onTap: () {
    //           provider.testEntity =
    //           TestEntity(
    //           testId: provider
    //               .testHistoryEntity
    //               .test?[
    //           index1]
    //               .tests?[
    //           indexx]
    //               .testId,
    //           userTestId: provider
    //               .testHistoryEntity
    //               .test?[
    //           index1]
    //               .tests?[
    //           indexx]
    //               .userTestId,
    //           text1: provider
    //               .testHistoryEntity
    //               .test?[
    //           index1]
    //               .tests?[
    //           indexx]
    //               .text1,
    //           text2: provider
    //               .testHistoryEntity
    //               .test?[
    //           index1]
    //               .tests?[
    //           indexx]
    //               .text2,
    //           text3: provider
    //               .testHistoryEntity
    //               .test?[
    //           index1]
    //               .tests?[
    //           indexx]
    //               .text3,
    //           );
    //           if (kDebugMode) {
    //           print(
    //           "STEP-1");
    //           }
    //           (provider
    //               .testHistoryEntity
    //               .test?[
    //           index1]
    //               .tests?[
    //           indexx]
    //               .userTestId)!
    //               .toInt();
    //           if (kDebugMode) {
    //           print(
    //           "STEP-2");
    //           print(provider
    //               .testHistoryEntity
    //               .test?[
    //           index1]
    //               .tests?[
    //           indexx]
    //               .userTestId
    //               ?.toInt());
    //           }
    //           gotoResults(
    //           context,
    //           provider
    //               .testHistoryEntity
    //               .test?[
    //           index1]
    //               .tests?[
    //           indexx]
    //               .userTestId
    //               ?.toInt(),
    //           2);
    //           },
    //           child: Row(
    //           children: [
    //           Container(
    //           padding: EdgeInsets
    //               .symmetric(
    //           horizontal:
    //           6.sp),
    //           height: 19.h,
    //           decoration:
    //           BoxDecoration(
    //           color: LoopsColors
    //               .colorBlue4,
    //           borderRadius:
    //           BorderRadius
    //               .all(
    //           Radius.circular(
    //           2.sp),
    //           ),
    //           ),
    //           child: Center(
    //           child: Text(
    //           'Results',
    //           style:
    //           TextStyle(
    //           fontSize:
    //           11.sp,
    //           fontWeight:
    //           FontWeight
    //               .w600,
    //           color: LoopsColors
    //               .colorWhite,
    //           ),
    //           ),
    //           ),
    //           ),
    //           if(provider
    //               .testHistoryEntity
    //               .test?[
    //           index1]
    //               .tests?[
    //           indexx]
    //               .result ??
    //           false)
    //           Padding(
    //           padding: EdgeInsets
    //               .symmetric(
    //           horizontal:
    //           4.sp),
    //           child: InkWell(
    //           onTap: () {
    //           gotoStartTest(
    //           context,
    //           TestEntity(
    //           testId: provider
    //               .testHistoryEntity
    //               .test?[
    //           index1]
    //               .tests?[
    //           indexx]
    //               .testId,
    //           userTestId: provider
    //               .testHistoryEntity
    //               .test?[
    //           index1]
    //               .tests?[
    //           indexx]
    //               .userTestId,
    //           text1: provider
    //               .testHistoryEntity
    //               .test?[
    //           index1]
    //               .tests?[
    //           indexx]
    //               .text1,
    //           text2: provider
    //               .testHistoryEntity
    //               .test?[
    //           index1]
    //               .tests?[
    //           indexx]
    //               .text2,
    //           text3: provider
    //               .testHistoryEntity
    //               .test?[
    //           index1]
    //               .tests?[
    //           indexx]
    //               .text3,
    //           ),
    //           fromCustomTest:
    //           false);
    //           },
    //           child: Container(
    //           padding: EdgeInsets
    //               .symmetric(
    //           horizontal:
    //           6.sp),
    //           height: 19.h,
    //           decoration:
    //           BoxDecoration(
    //           color: LoopsColors
    //               .colorBlue4,
    //           borderRadius:
    //           BorderRadius
    //               .all(
    //           Radius.circular(
    //           2.sp),
    //           ),
    //           ),
    //           child: Center(
    //           child: Text(
    //           'Retake',
    //           style:
    //           TextStyle(
    //           fontSize:
    //           11.sp,
    //           fontWeight:
    //           FontWeight
    //               .w600,
    //           color: LoopsColors
    //               .colorWhite,
    //           ),
    //           ),
    //           ),
    //           ),
    //           ),
    //           )
    //           else
    //           Container()
    //
    //           ],
    //           ),
    //           ),
    //           ),
    //             Padding(
    //               padding: EdgeInsets
    //                   .symmetric(
    //                   horizontal:
    //                   4.sp),
    //               child: InkWell(
    //                 onTap: () {
    //                   gotoStartTest(
    //                       context,
    //                       TestEntity(
    //                         testId: provider
    //                             .testHistoryEntity
    //                             .test?[
    //                         index1]
    //                             .tests?[
    //                         indexx]
    //                             .testId,
    //                         userTestId: provider
    //                             .testHistoryEntity
    //                             .test?[
    //                         index1]
    //                             .tests?[
    //                         indexx]
    //                             .userTestId,
    //                         text1: provider
    //                             .testHistoryEntity
    //                             .test?[
    //                         index1]
    //                             .tests?[
    //                         indexx]
    //                             .text1,
    //                         text2: provider
    //                             .testHistoryEntity
    //                             .test?[
    //                         index1]
    //                             .tests?[
    //                         indexx]
    //                             .text2,
    //                         text3: provider
    //                             .testHistoryEntity
    //                             .test?[
    //                         index1]
    //                             .tests?[
    //                         indexx]
    //                             .text3,
    //                       ),
    //                       fromCustomTest:
    //                       false);
    //                 },
    //                 child: Container(
    //                   padding: EdgeInsets
    //                       .symmetric(
    //                       horizontal:
    //                       6.sp),
    //                   height: 19.h,
    //                   decoration:
    //                   BoxDecoration(
    //                     color: LoopsColors
    //                         .colorBlue4,
    //                     borderRadius:
    //                     BorderRadius
    //                         .all(
    //                       Radius.circular(
    //                           2.sp),
    //                     ),
    //                   ),
    //                   child: Center(
    //                     child: Text(
    //                       'Retake',
    //                       style:
    //                       TextStyle(
    //                         fontSize:
    //                         11.sp,
    //                         fontWeight:
    //                         FontWeight
    //                             .w600,
    //                         color: LoopsColors
    //                             .colorWhite,
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ],
    //         );
    //       else
    //         return Container();
    //       if (index ==
    //               0 /*  &&
    //           ((provider
    //                       .testHistoryEntity
    //                       .test
    //                       ?.tests?[
    //                           indexx]
    //                       .progress ??
    //                   false) ||
    //               (provider
    //                       .testHistoryEntity
    //                       .test
    //                       ?.tests?[
    //                           indexx]
    //                       .paused ??
    //                   false)) */
    //           ) {
    //         return Padding(
    //           padding: EdgeInsets
    //               .symmetric(
    //                   horizontal:
    //                       4.sp),
    //           child: Container(
    //             padding: EdgeInsets
    //                 .symmetric(
    //                     horizontal:
    //                         6.sp),
    //             height: 19.h,
    //             decoration:
    //                 BoxDecoration(
    //               color: LoopsColors
    //                   .colorYellow1,
    //               borderRadius:
    //                   BorderRadius
    //                       .all(
    //                 Radius
    //                     .circular(
    //                         2.sp),
    //               ),
    //             ),
    //             child: Center(
    //               child: Text(
    //                 (provider
    //                             .testHistoryEntity
    //                             .test?[index1]
    //                             .tests?[indexx]
    //                             .resume ??
    //                         false)
    //                     ? 'Paused'
    //                     : !(provider.testHistoryEntity.test?[index1].tests?[indexx].result ?? false)
    //                         ? 'No Idea'
    //                         : 'Completed',
    //                 style: TextStyle(
    //                     fontSize:
    //                         11.sp,
    //                     fontWeight:
    //                         FontWeight
    //                             .w400,
    //                     color: LoopsColors
    //                         .iconColor2),
    //               ),
    //             ),
    //           ),
    //         );
    //       }
    //       if (//index == 1 &&
    //           (provider
    //                   .testHistoryEntity
    //                   .test?[
    //                       index1]
    //                   .tests?[
    //                       indexx]
    //                   .resume ??
    //               false)) {
    //         return Padding(
    //           padding: EdgeInsets
    //               .symmetric(
    //                   horizontal:
    //                       4.sp),
    //           child: InkWell(
    //             onTap: () {
    //               gotoTestInstructions(
    //                   context,
    //                   testEntity:
    //                       TestEntity(
    //                     testId: provider
    //                         .testHistoryEntity
    //                         .test?[
    //                             index1]
    //                         .tests?[
    //                             indexx]
    //                         .testId,
    //                     userTestId: provider
    //                         .testHistoryEntity
    //                         .test?[
    //                             index1]
    //                         .tests?[
    //                             indexx]
    //                         .userTestId,
    //                     text1: provider
    //                         .testHistoryEntity
    //                         .test?[
    //                             index1]
    //                         .tests?[
    //                             indexx]
    //                         .text1,
    //                     text2: provider
    //                         .testHistoryEntity
    //                         .test?[
    //                             index1]
    //                         .tests?[
    //                             indexx]
    //                         .text2,
    //                     text3: provider
    //                         .testHistoryEntity
    //                         .test?[
    //                             index1]
    //                         .tests?[
    //                             indexx]
    //                         .text3,
    //                   ));
    //             },
    //             child: Container(
    //               padding: EdgeInsets
    //                   .symmetric(
    //                       horizontal:
    //                           6.sp),
    //               height: 19.h,
    //               decoration:
    //                   BoxDecoration(
    //                 color: LoopsColors
    //                     .colorsList02[1],
    //                 borderRadius:
    //                     BorderRadius
    //                         .all(
    //                   Radius.circular(
    //                       2.sp),
    //                 ),
    //               ),
    //               child: Center(
    //                 child: Text(
    //                   'Resume',
    //                   style:
    //                       TextStyle(
    //                     fontSize:
    //                         11.sp,
    //                     fontWeight:
    //                         FontWeight
    //                             .w600,
    //                     color: LoopsColors
    //                         .colorWhite,
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ),
    //         );
    //       }
    //       if (//index == 2 &&
    //           (provider
    //                   .testHistoryEntity
    //                   .test?[
    //                       index1]
    //                   .tests?[
    //                       indexx]
    //                   .result ??
    //               false) &&
    //           !(provider
    //                   .testHistoryEntity
    //                   .test?[
    //                       index1]
    //                   .tests?[
    //                       indexx]
    //                   .resume ??
    //               false)) {
    //         return Padding(
    //           padding: EdgeInsets
    //               .symmetric(
    //                   horizontal:
    //                       4.sp),
    //           child: InkWell(
    //             onTap: () {
    //               provider.testEntity =
    //                   TestEntity(
    //                 testId: provider
    //                     .testHistoryEntity
    //                     .test?[
    //                         index1]
    //                     .tests?[
    //                         indexx]
    //                     .testId,
    //                 userTestId: provider
    //                     .testHistoryEntity
    //                     .test?[
    //                         index1]
    //                     .tests?[
    //                         indexx]
    //                     .userTestId,
    //                 text1: provider
    //                     .testHistoryEntity
    //                     .test?[
    //                         index1]
    //                     .tests?[
    //                         indexx]
    //                     .text1,
    //                 text2: provider
    //                     .testHistoryEntity
    //                     .test?[
    //                         index1]
    //                     .tests?[
    //                         indexx]
    //                     .text2,
    //                 text3: provider
    //                     .testHistoryEntity
    //                     .test?[
    //                         index1]
    //                     .tests?[
    //                         indexx]
    //                     .text3,
    //               );
    //               if (kDebugMode) {
    //                 print(
    //                     "STEP-1");
    //               }
    //               (provider
    //                       .testHistoryEntity
    //                       .test?[
    //                           index1]
    //                       .tests?[
    //                           indexx]
    //                       .userTestId)!
    //                   .toInt();
    //               if (kDebugMode) {
    //                 print(
    //                     "STEP-2");
    //                 print(provider
    //                     .testHistoryEntity
    //                     .test?[
    //                         index1]
    //                     .tests?[
    //                         indexx]
    //                     .userTestId
    //                     ?.toInt());
    //               }
    //               gotoResults(
    //                   context,
    //                   provider
    //                       .testHistoryEntity
    //                       .test?[
    //                           index1]
    //                       .tests?[
    //                           indexx]
    //                       .userTestId
    //                       ?.toInt(),
    //                   2);
    //             },
    //             child: Row(
    //               children: [
    //                 Container(
    //                   padding: EdgeInsets
    //                       .symmetric(
    //                           horizontal:
    //                               6.sp),
    //                   height: 19.h,
    //                   decoration:
    //                       BoxDecoration(
    //                     color: LoopsColors
    //                         .colorBlue4,
    //                     borderRadius:
    //                         BorderRadius
    //                             .all(
    //                       Radius.circular(
    //                           2.sp),
    //                     ),
    //                   ),
    //                   child: Center(
    //                     child: Text(
    //                       'Results',
    //                       style:
    //                           TextStyle(
    //                         fontSize:
    //                             11.sp,
    //                         fontWeight:
    //                             FontWeight
    //                                 .w600,
    //                         color: LoopsColors
    //                             .colorWhite,
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //                 if(provider
    //             .testHistoryEntity
    //             .test?[
    //         index1]
    //                 .tests?[
    //             indexx]
    //                 .result ??
    //             false)
    //                    Padding(
    //                     padding: EdgeInsets
    //                         .symmetric(
    //                         horizontal:
    //                         4.sp),
    //                     child: InkWell(
    //                       onTap: () {
    //                         gotoStartTest(
    //                             context,
    //                             TestEntity(
    //                               testId: provider
    //                                   .testHistoryEntity
    //                                   .test?[
    //                               index1]
    //                                   .tests?[
    //                               indexx]
    //                                   .testId,
    //                               userTestId: provider
    //                                   .testHistoryEntity
    //                                   .test?[
    //                               index1]
    //                                   .tests?[
    //                               indexx]
    //                                   .userTestId,
    //                               text1: provider
    //                                   .testHistoryEntity
    //                                   .test?[
    //                               index1]
    //                                   .tests?[
    //                               indexx]
    //                                   .text1,
    //                               text2: provider
    //                                   .testHistoryEntity
    //                                   .test?[
    //                               index1]
    //                                   .tests?[
    //                               indexx]
    //                                   .text2,
    //                               text3: provider
    //                                   .testHistoryEntity
    //                                   .test?[
    //                               index1]
    //                                   .tests?[
    //                               indexx]
    //                                   .text3,
    //                             ),
    //                             fromCustomTest:
    //                             false);
    //                       },
    //                       child: Container(
    //                         padding: EdgeInsets
    //                             .symmetric(
    //                             horizontal:
    //                             6.sp),
    //                         height: 19.h,
    //                         decoration:
    //                         BoxDecoration(
    //                           color: LoopsColors
    //                               .colorBlue4,
    //                           borderRadius:
    //                           BorderRadius
    //                               .all(
    //                             Radius.circular(
    //                                 2.sp),
    //                           ),
    //                         ),
    //                         child: Center(
    //                           child: Text(
    //                             'Retake',
    //                             style:
    //                             TextStyle(
    //                               fontSize:
    //                               11.sp,
    //                               fontWeight:
    //                               FontWeight
    //                                   .w600,
    //                               color: LoopsColors
    //                                   .colorWhite,
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                   )
    //                 else
    //                    Container()
    //
    //               ],
    //             ),
    //           ),
    //         );
    //       }
    //       if (//index == 3 &&
    //           (provider
    //                   .testHistoryEntity
    //                   .test?[
    //                       index1]
    //                   .tests?[
    //                       indexx]
    //                   .result ??
    //               false)
    //
    //           // &&
    //           // !(provider
    //           //         .testHistoryEntity
    //           //         .test?[
    //           //             index1]
    //           //         .tests?[
    //           //             indexx]
    //           //         .resume ??
    //           //     false)
    //       ) {
    //         return Padding(
    //           padding: EdgeInsets
    //               .symmetric(
    //                   horizontal:
    //                       4.sp),
    //           child: InkWell(
    //             onTap: () {
    //               gotoStartTest(
    //                   context,
    //                   TestEntity(
    //                     testId: provider
    //                         .testHistoryEntity
    //                         .test?[
    //                             index1]
    //                         .tests?[
    //                             indexx]
    //                         .testId,
    //                     userTestId: provider
    //                         .testHistoryEntity
    //                         .test?[
    //                             index1]
    //                         .tests?[
    //                             indexx]
    //                         .userTestId,
    //                     text1: provider
    //                         .testHistoryEntity
    //                         .test?[
    //                             index1]
    //                         .tests?[
    //                             indexx]
    //                         .text1,
    //                     text2: provider
    //                         .testHistoryEntity
    //                         .test?[
    //                             index1]
    //                         .tests?[
    //                             indexx]
    //                         .text2,
    //                     text3: provider
    //                         .testHistoryEntity
    //                         .test?[
    //                             index1]
    //                         .tests?[
    //                             indexx]
    //                         .text3,
    //                   ),
    //                   fromCustomTest:
    //                       false);
    //             },
    //             child: Container(
    //               padding: EdgeInsets
    //                   .symmetric(
    //                       horizontal:
    //                           6.sp),
    //               height: 19.h,
    //               decoration:
    //                   BoxDecoration(
    //                 color: LoopsColors
    //                     .colorBlue4,
    //                 borderRadius:
    //                     BorderRadius
    //                         .all(
    //                   Radius.circular(
    //                       2.sp),
    //                 ),
    //               ),
    //               child: Center(
    //                 child: Text(
    //                   'Retake',
    //                   style:
    //                       TextStyle(
    //                     fontSize:
    //                         11.sp,
    //                     fontWeight:
    //                         FontWeight
    //                             .w600,
    //                     color: LoopsColors
    //                         .colorWhite,
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ),
    //         );
    //       }
    //       return Container();
    //     }),
    ),
    )
    ],
    ),
    ),
    ),
    ],
    );
    }),
    ),
    ),
    );
    }),
    ),
    ),
    ],
    ),
    ),
    );
    }
  }
