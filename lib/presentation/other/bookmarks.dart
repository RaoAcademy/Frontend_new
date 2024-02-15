import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:EdTestz/application/auth/auth_provider.dart';
import 'package:EdTestz/application/other/other_provider.dart';
import 'package:EdTestz/application/test/test_provider.dart';
import 'package:EdTestz/core/theme/custom_scroll_behaviour.dart';
import 'package:EdTestz/core/theme/theme.dart';
import 'package:EdTestz/core/utli/error_handle.dart';
import 'package:EdTestz/core/utli/loops_urls.dart';
import 'package:EdTestz/core/widgets/box_corner_list.dart';
import 'package:EdTestz/core/widgets/container_with_border.dart';
import 'package:EdTestz/core/widgets/rounded_corner_list.dart';
import 'package:EdTestz/domain/entities/subject_list_entity.dart';
import 'package:EdTestz/presentation/core/subjectlist_to_subjects.dart';
import 'package:EdTestz/presentation/other/widgets/cached_network_image.dart';

import '../../core/widgets/coin.dart';

class Bookmarks extends StatefulWidget {
  const Bookmarks({Key? key}) : super(key: key);

  @override
  State<Bookmarks> createState() => _BookmarksState();
}

bool _showTest = true;

class _BookmarksState extends State<Bookmarks> {
  @override
  void initState() {
    _subjectList.clear();
    Provider.of<AuthAppProvider>(context, listen: false)
        .bookmarkTestEntity
        .subjects
        ?.forEach((element) {
      _subjectList.add(element);
    });
    Provider.of<AuthAppProvider>(context, listen: false).fbookmarkTest(
        subjectId: Provider.of<TestProvider>(context, listen: false).subjectId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<AuthAppProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ContainerWithBorder(
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
                    'Bookmarks',
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: LoopsColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            ContainerWithBorder(
              width: MediaQuery.of(context).size.width,
              borderRadius: 10.sp,
              // margin: EdgeInsets.symmetric(horizontal: 1.w),

              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  color: LoopsColors.lightGrey.withOpacity(0.4),
                  // offset: Offset(5.sp, 5.sp),
                )
              ],
              child: Column(
                children: [
                  BoxCornerList(
                      textList: subjectListToSubjects(_subjectList),
                      selectedIndex: _subjectList.indexOf(
                          _subjectList.firstWhere((element) =>
                              element.id ==
                              Provider.of<TestProvider>(context, listen: false)
                                  .subjectId)),
                      getValue: (value) {
                        Provider.of<TestProvider>(context, listen: false)
                                .subjectId =
                            _subjectList[value.keys.first].id!.toInt();
                        Provider.of<TestProvider>(context, listen: false)
                            .updateSubjectMap(
                                _subjectList.firstWhere((element) =>
                                    element.id ==
                                    _subjectList[value.keys.first].id),
                                reload: true);
                        if (_subjectList[value.keys.first].id != 0) {
                          if (_showTest) {
                            Provider.of<AuthAppProvider>(context, listen: false)
                                .fbookmarkTest(
                                    subjectId:
                                        _subjectList[value.keys.first].id);
                          } else {
                            Provider.of<AuthAppProvider>(context, listen: false)
                                .fbookmarkQuestion(
                                    subjectId:
                                        _subjectList[value.keys.first].id);
                          }
                        }
                      }),
                  /* BoxCornerList(
                    textList: _subjectList,
                    selectedIndex: _subjectList.indexOf(
                      _subjectList.firstWhere((element) =>
                          element.id ==
                          Provider.of<TestProvider>(context, listen: false)
                              .subjectId),
                    ),
                    getValue: (val) {
                      Provider.of<TestProvider>(context, listen: false)
                          .subjectId = _subjectList[val.keys.first].id!.toInt();
                      if (Provider.of<AuthProvider>(context, listen: false)
                          .showTest) {
                        Provider.of<AuthProvider>(context, listen: false)
                            .fbookmarkTest(
                                subjectId: Provider.of<AuthProvider>(context,
                                        listen: false)
                                    .bookmarkTestEntity
                                    .subjects!
                                    .firstWhere((element) =>
                                        element ==
                                        _subjectList.firstWhere((elementx) =>
                                            elementx.name == val.values.first))
                                    .id)
                            .onError((error, stackTrace) async {
                          await handleError(error);
                        });
                      } else {
                        if (Provider.of<AuthProvider>(context, listen: false)
                                    .bookmarkQuestionsEntity
                                    .subjects !=
                                null &&
                            Provider.of<AuthProvider>(context, listen: false)
                                .bookmarkQuestionsEntity
                                .subjects!
                                .isNotEmpty) {
                          if (Provider.of<AuthProvider>(context, listen: false)
                                      .bookmarkQuestionsEntity
                                      .subjects !=
                                  null &&
                              Provider.of<AuthProvider>(context, listen: false)
                                  .bookmarkQuestionsEntity
                                  .subjects!
                                  .isNotEmpty) {
                            Provider.of<AuthProvider>(context, listen: false)
                                .fbookmarkQuestion(
                                    subjectId: Provider.of<AuthProvider>(
                                            context,
                                            listen: false)
                                        .bookmarkQuestionsEntity
                                        .subjects!
                                        .firstWhere(
                              (element) =>
                                  element ==
                                  _subjectList.firstWhere((elementx) =>
                                      elementx.name == val.values.first),
                              orElse: () {
                                return Subjects(
                                    id: Provider.of<TestProvider>(context,
                                            listen: false)
                                        .subjectId);
                              },
                            ).id)
                                .onError((error, stackTrace) {
                              handleError(error);
                            }).onError((error, stackTrace) async {
                              await handleError(error);
                            });
                          }
                        }
                      }
                      Provider.of<AuthProvider>(context, listen: false)
                          .setState();
                    },
                  ), */
                  SizedBox(
                    height: 8.h,
                  ),
                  Container(
                    height: 1.h,
                    width: MediaQuery.of(context).size.width / 1.2,
                    color: LoopsColors.lightGrey,
                  ),
                  RoundedCornerList(
                      textList: const ['Tests', 'Questions'],
                      getValue: (val) {
                        switch (val.keys.first) {
                          case 0:
                            _showTest = true;
                            Provider.of<AuthAppProvider>(context, listen: false)
                                .fbookmarkTest(
                                    subjectId: Provider.of<TestProvider>(
                                            context,
                                            listen: false)
                                        .subjectId)
                                .then((value) {
                              _subjectList.clear();
                              Provider.of<AuthAppProvider>(context, listen: false)
                                  .bookmarkTestEntity
                                  .subjects
                                  ?.forEach((element) {
                                _subjectList.add(element);
                              });
                            }).onError((error, stackTrace) async {
                              await handleError(error);
                            });
                            break;
                          default:
                            _showTest = false;
                            Provider.of<AuthAppProvider>(context, listen: false)
                                .fbookmarkQuestion(
                                    subjectId: Provider.of<TestProvider>(
                                            context,
                                            listen: false)
                                        .subjectId)
                                .then((value) {
                              _subjectList.clear();
                              Provider.of<AuthAppProvider>(context, listen: false)
                                  .bookmarkQuestionsEntity
                                  .subjects
                                  ?.forEach((element) {
                                _subjectList.add(element);
                              });
                            }).onError((error, stackTrace) async {
                              await handleError(error);
                            });
                        }
                      }),
                ],
              ),
            ),
            Expanded(
              // height: 130.h,
              child: ContainerWithBorder(
                padding: EdgeInsets.only(top: 24.h),
                child: ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: _showTest ? Provider.of<AuthAppProvider>(context, listen: false)
                      .bookmarkTestEntity
                      .userTests!.isEmpty ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Image.asset("assets/images/other/ribbon.png",height: 60,width: 60,color: Colors.black54,),
                        ),
                        Text("No bookmark yet",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black38,fontSize: 22),),
                        RichText(text: TextSpan(
                            text: 'Top the bookmark if icon on your favorite test from ',style: TextStyle(fontWeight: FontWeight.w400,color: Colors.black38,fontSize: 14),
                            children: [
                              TextSpan(text: 'result page',style: TextStyle(fontWeight: FontWeight.w400,color: Colors.black87,fontSize: 14)),
                              TextSpan(text: ' to add it.',style: TextStyle(fontWeight: FontWeight.w400,color: Colors.black38,fontSize: 14)),
                            ]
                        ),textAlign: TextAlign.center),
                        SizedBox(height: 100,),
                      ],
                    ),
                  )  : ListView.builder(
                    itemCount: _showTest
                        ? Provider.of<AuthAppProvider>(context, listen: false)
                            .bookmarkTestEntity
                            .userTests
                            ?.length
                        : Provider.of<AuthAppProvider>(context, listen: false)
                            .bookmarkQuestionsEntity
                            .questions
                            ?.length,
                    itemBuilder: (context, index) {
                      if (kDebugMode) {
                        print("Book");
                        print(_showTest);
                        print(index);
                      }
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 2.sp,
                          ),
                          // Container(
                          //   width: 1.sp,
                          //   height: 62.h,
                          //   color: LoopsColors.colorGrey,
                          // ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 14.h, left: 10.w),
                            child: Stack(
                              children: [
                                ContainerWithBorder(
                                  boxShadow: _showTest
                                      ? [
                                          BoxShadow(
                                              blurRadius: 10,
                                              color: LoopsColors.colorGrey
                                                  .withOpacity(0.8),
                                              offset: Offset(5.sp, 5.sp))
                                        ]
                                      : [
                                          BoxShadow(
                                              blurRadius: 10,
                                              color: LoopsColors.lightGrey
                                                  .withOpacity(0.4),
                                              offset: Offset(4.sp, 4.sp))
                                        ],
                                  // width: MediaQuery.of(context).size.width,
                                  // borderRadius: 10.sp,

                                  height: 120.h,
                                  borderColor: _showTest
                                      ? Colors.white
                                      : LoopsColors.textColor,

                                  width: _showTest
                                      ? MediaQuery.of(context).size.width / 1.5
                                      : MediaQuery.of(context).size.width / 1.1,
                                  borderRadius: 12.sp,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if (_showTest)
                                        Expanded(
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 25.h,
                                              ),
                                              if (_showTest)
                                                LoopsImage(
                                                    path: (Provider.of<
                                                                    AuthAppProvider>(
                                                                context,
                                                                listen: false)
                                                            .bookmarkTestEntity
                                                            .userTests![index]
                                                            .imagePath ??
                                                        '')),
                                            ],
                                          ),
                                        ),
                                      Expanded(
                                        flex: 2,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15.w),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              Expanded(
                                                flex: 8,
                                                child: Text(
                                                  _showTest
                                                      ? Provider.of<AuthAppProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .bookmarkTestEntity
                                                              .userTests![index]
                                                              .text1 ??
                                                          ''
                                                      : (Provider.of<AuthAppProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .bookmarkQuestionsEntity
                                                              .questions?[index]
                                                              .question ??
                                                          ''),
                                                  maxLines: 10,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: LoopsColors
                                                          .colorBlack),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: _showTest
                                                    ? Text(
                                                        Provider.of<AuthAppProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .bookmarkTestEntity
                                                                .userTests![
                                                                    index]
                                                                .text2 ??
                                                            '',
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                          fontSize: 10.sp,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: LoopsColors
                                                              .colorGrey,
                                                        ),
                                                      )
                                                    : Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        10.0),

                                                            // height: 40.0,
                                                            width: 200.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: LoopsColors
                                                                  .colorPink2,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20.0),
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                Provider.of<AuthAppProvider>(
                                                                            context,
                                                                            listen:
                                                                                false)
                                                                        .bookmarkQuestionsEntity
                                                                        .questions?[
                                                                            index]
                                                                        .conceptName ??
                                                                    '',
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize:
                                                                      10.0,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 16.0,
                                                          ),
                                                          Container(
                                                            // height: 40.0,
                                                            width: 50,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: LoopsColors
                                                                  .secondaryColor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20.0),
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                (Provider.of<AuthAppProvider>(
                                                                            context,
                                                                            listen:
                                                                                false)
                                                                        .bookmarkQuestionsEntity
                                                                        .questions?[
                                                                            index]
                                                                        .format ??
                                                                    ''),
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                              ),
                                              Expanded(
                                                flex: 4,
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          _showTest
                                                              ? Text(
                                                                  _showTest
                                                                      ? Provider.of<AuthAppProvider>(context, listen: false)
                                                                              .bookmarkTestEntity
                                                                              .userTests![
                                                                                  index]
                                                                              .text3 ??
                                                                          ''
                                                                      : (Provider.of<AuthAppProvider>(context, listen: false)
                                                                              .bookmarkQuestionsEntity
                                                                              .questions?[index]
                                                                              .format ??
                                                                          ''),
                                                                  style: appTheme
                                                                      .textTheme
                                                                      .bodyLarge!
                                                                      .copyWith(
                                                                    fontSize:
                                                                        10.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: LoopsColors
                                                                        .colorGrey,
                                                                  ),
                                                                )
                                                              : Container(),
                                                          // Expanded(child: Container()),
                                                          if (_showTest)
                                                            Row(children: [
                                                              Coin(
                                                                  coinSize:
                                                                      12.sp),
                                                              SizedBox(
                                                                width: 5.w,
                                                              ),
                                                              Text(
                                                                Provider.of<AuthAppProvider>(
                                                                            context,
                                                                            listen:
                                                                                false)
                                                                        .bookmarkTestEntity
                                                                        .userTests![
                                                                            index]
                                                                        .coins
                                                                        .toString() ??
                                                                    '0',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      10.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: LoopsColors
                                                                      .colorBlack,
                                                                ),
                                                              ),
                                                            ]),
                                                        ],
                                                      ),
                                                      if (_showTest)
                                                        SizedBox(
                                                          height: 2.sp,
                                                          width: 50.w,
                                                          child:
                                                              LinearProgressIndicator(
                                                            value: _showTest
                                                                ? (Provider.of<AuthAppProvider>(context,
                                                                                listen: false)
                                                                            .bookmarkTestEntity
                                                                            .userTests![index]
                                                                            .text3 ==
                                                                        'Finished'
                                                                    ? 1
                                                                    : 0.5)
                                                                : 0,
                                                            backgroundColor:
                                                                LoopsColors
                                                                    .colorGrey
                                                                    .withOpacity(
                                                                        0.4),
                                                          ),
                                                        ),
                                                    ]),
                                              ),

                                              // SizedBox(
                                              //   width: 6.w,
                                              // ),

                                              // SizedBox(
                                              //   height: 10.h,
                                              // ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                if (_showTest &&
                                    Provider.of<AuthAppProvider>(context,
                                                listen: false)
                                            .bookmarkTestEntity
                                            .userTests![index]
                                            .leftTop !=
                                        null)
                                  Positioned(
                                    child: ContainerWithBorder(
                                      height: 17.h,
                                      width: 56.w,
                                      borderRadius: 12.sp,
                                      boxColor: LoopsColors.primaryColor,
                                      borderR: BorderRadius.only(
                                        topLeft: Radius.circular(12.sp),
                                        bottomRight: Radius.circular(12.sp),
                                      ),
                                      child: Center(
                                        child: Text(
                                          Provider.of<AuthAppProvider>(context,
                                                  listen: false)
                                              .bookmarkTestEntity
                                              .userTests![index]
                                              .leftTop!,
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w600,
                                            color: LoopsColors.tertiaryColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                if (_showTest &&
                                    Provider.of<AuthAppProvider>(context,
                                                listen: false)
                                            .bookmarkTestEntity
                                            .userTests![index]
                                            .rightTop !=
                                        null)
                                  Positioned(
                                    right: 0,
                                    child: ContainerWithBorder(
                                      height: 17.h,
                                      width: 56.w,
                                      borderRadius: 12.sp,
                                      boxColor: LoopsColors.primaryColor,
                                      borderR: BorderRadius.only(
                                        topLeft: Radius.circular(12.sp),
                                        bottomRight: Radius.circular(12.sp),
                                      ),
                                      child: Center(
                                        child: Text(
                                          Provider.of<AuthAppProvider>(context,
                                                  listen: false)
                                              .bookmarkTestEntity
                                              .userTests![index]
                                              .rightTop!,
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w600,
                                            color: LoopsColors.tertiaryColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ) : Provider.of<AuthAppProvider>(context, listen: false)
                      .bookmarkQuestionsEntity
                      .questions!.isEmpty ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Image.asset("assets/images/other/ribbon.png",height: 60,width: 60,color: Colors.black54,),
                        ),
                        Text("No bookmarks yet",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black38,fontSize: 22),),
                        RichText(text: TextSpan(
                          text: 'Top the bookmark icon on your favorite question from ',style: TextStyle(fontWeight: FontWeight.w400,color: Colors.black38,fontSize: 14),
                          children: [
                            TextSpan(text: 'test page',style: TextStyle(fontWeight: FontWeight.w400,color: Colors.black87,fontSize: 14)),
                            TextSpan(text: ' to add it.',style: TextStyle(fontWeight: FontWeight.w400,color: Colors.black38,fontSize: 14)),
                          ]
                        ),textAlign: TextAlign.center),
                        SizedBox(height: 100,),
                      ],
                    ),
                  ): ListView.builder(
                    itemCount: _showTest
                        ? Provider.of<AuthAppProvider>(context, listen: false)
                        .bookmarkTestEntity
                        .userTests
                        ?.length
                        : Provider.of<AuthAppProvider>(context, listen: false)
                        .bookmarkQuestionsEntity
                        .questions
                        ?.length,
                    itemBuilder: (context, index) {
                      if (kDebugMode) {
                        print("Book");
                        print(_showTest);
                        print(index);
                      }
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 2.sp,
                          ),
                          // Container(
                          //   width: 1.sp,
                          //   height: 62.h,
                          //   color: LoopsColors.colorGrey,
                          // ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 14.h, left: 10.w),
                            child: Stack(
                              children: [
                                ContainerWithBorder(
                                  boxShadow: _showTest
                                      ? [
                                    BoxShadow(
                                        blurRadius: 10,
                                        color: LoopsColors.colorGrey
                                            .withOpacity(0.8),
                                        offset: Offset(5.sp, 5.sp))
                                  ]
                                      : [
                                    BoxShadow(
                                        blurRadius: 10,
                                        color: LoopsColors.lightGrey
                                            .withOpacity(0.4),
                                        offset: Offset(4.sp, 4.sp))
                                  ],
                                  // width: MediaQuery.of(context).size.width,
                                  // borderRadius: 10.sp,

                                  height: 120.h,
                                  borderColor: _showTest
                                      ? Colors.white
                                      : LoopsColors.textColor,

                                  width: _showTest
                                      ? MediaQuery.of(context).size.width / 1.5
                                      : MediaQuery.of(context).size.width / 1.1,
                                  borderRadius: 12.sp,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if (_showTest)
                                        Expanded(
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 25.h,
                                              ),
                                              if (_showTest)
                                                LoopsImage(
                                                    path: (Provider.of<
                                                        AuthAppProvider>(
                                                        context,
                                                        listen: false)
                                                        .bookmarkTestEntity
                                                        .userTests![index]
                                                        .imagePath ??
                                                        '')),
                                            ],
                                          ),
                                        ),
                                      Expanded(
                                        flex: 2,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15.w),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              Expanded(
                                                flex: 8,
                                                child: Text(
                                                  _showTest
                                                      ? Provider.of<AuthAppProvider>(
                                                      context,
                                                      listen: false)
                                                      .bookmarkTestEntity
                                                      .userTests![index]
                                                      .text1 ??
                                                      ''
                                                      : (Provider.of<AuthAppProvider>(
                                                      context,
                                                      listen: false)
                                                      .bookmarkQuestionsEntity
                                                      .questions?[index]
                                                      .question ??
                                                      ''),
                                                  maxLines: 10,
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                      FontWeight.w600,
                                                      color: LoopsColors
                                                          .colorBlack),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: _showTest
                                                    ? Text(
                                                  Provider.of<AuthAppProvider>(
                                                      context,
                                                      listen:
                                                      false)
                                                      .bookmarkTestEntity
                                                      .userTests![
                                                  index]
                                                      .text2 ??
                                                      '',
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                    fontSize: 10.sp,
                                                    fontWeight:
                                                    FontWeight.w600,
                                                    color: LoopsColors
                                                        .colorGrey,
                                                  ),
                                                )
                                                    : Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceEvenly,
                                                  children: [
                                                    Container(
                                                      padding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                          horizontal:
                                                          10.0),

                                                      // height: 40.0,
                                                      width: 200.0,
                                                      decoration:
                                                      BoxDecoration(
                                                        color: LoopsColors
                                                            .colorPink2,
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            20.0),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          Provider.of<AuthAppProvider>(
                                                              context,
                                                              listen:
                                                              false)
                                                              .bookmarkQuestionsEntity
                                                              .questions?[
                                                          index]
                                                              .conceptName ??
                                                              '',
                                                          maxLines: 2,
                                                          overflow:
                                                          TextOverflow
                                                              .ellipsis,
                                                          style:
                                                          const TextStyle(
                                                            fontSize:
                                                            10.0,
                                                            color: Colors
                                                                .white,
                                                            fontWeight:
                                                            FontWeight
                                                                .bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 16.0,
                                                    ),
                                                    Container(
                                                      // height: 40.0,
                                                      width: 50,
                                                      decoration:
                                                      BoxDecoration(
                                                        color: LoopsColors
                                                            .secondaryColor,
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            20.0),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          (Provider.of<AuthAppProvider>(
                                                              context,
                                                              listen:
                                                              false)
                                                              .bookmarkQuestionsEntity
                                                              .questions?[
                                                          index]
                                                              .format ??
                                                              ''),
                                                          style:
                                                          TextStyle(
                                                            fontSize: 10,
                                                            fontWeight:
                                                            FontWeight
                                                                .w600,
                                                            color: Colors
                                                                .white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                flex: 4,
                                                child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .center,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          _showTest
                                                              ? Text(
                                                            _showTest
                                                                ? Provider.of<AuthAppProvider>(context, listen: false)
                                                                .bookmarkTestEntity
                                                                .userTests![
                                                            index]
                                                                .text3 ??
                                                                ''
                                                                : (Provider.of<AuthAppProvider>(context, listen: false)
                                                                .bookmarkQuestionsEntity
                                                                .questions?[index]
                                                                .format ??
                                                                ''),
                                                            style: appTheme
                                                                .textTheme
                                                                .bodyLarge!
                                                                .copyWith(
                                                              fontSize:
                                                              10.sp,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w600,
                                                              color: LoopsColors
                                                                  .colorGrey,
                                                            ),
                                                          )
                                                              : Container(),
                                                          // Expanded(child: Container()),
                                                          if (_showTest)
                                                            Row(children: [
                                                              Coin(
                                                                  coinSize:
                                                                  12.sp),
                                                              SizedBox(
                                                                width: 5.w,
                                                              ),
                                                              Text(
                                                                Provider.of<AuthAppProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .bookmarkTestEntity
                                                                    .userTests![
                                                                index]
                                                                    .coins
                                                                    .toString() ??
                                                                    '0',
                                                                style:
                                                                TextStyle(
                                                                  fontSize:
                                                                  10.sp,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                                  color: LoopsColors
                                                                      .colorBlack,
                                                                ),
                                                              ),
                                                            ]),
                                                        ],
                                                      ),
                                                      if (_showTest)
                                                        SizedBox(
                                                          height: 2.sp,
                                                          width: 50.w,
                                                          child:
                                                          LinearProgressIndicator(
                                                            value: _showTest
                                                                ? (Provider.of<AuthAppProvider>(context,
                                                                listen: false)
                                                                .bookmarkTestEntity
                                                                .userTests![index]
                                                                .text3 ==
                                                                'Finished'
                                                                ? 1
                                                                : 0.5)
                                                                : 0,
                                                            backgroundColor:
                                                            LoopsColors
                                                                .colorGrey
                                                                .withOpacity(
                                                                0.4),
                                                          ),
                                                        ),
                                                    ]),
                                              ),

                                              // SizedBox(
                                              //   width: 6.w,
                                              // ),

                                              // SizedBox(
                                              //   height: 10.h,
                                              // ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                if (_showTest &&
                                    Provider.of<AuthAppProvider>(context,
                                        listen: false)
                                        .bookmarkTestEntity
                                        .userTests![index]
                                        .leftTop !=
                                        null)
                                  Positioned(
                                    child: ContainerWithBorder(
                                      height: 17.h,
                                      width: 56.w,
                                      borderRadius: 12.sp,
                                      boxColor: LoopsColors.primaryColor,
                                      borderR: BorderRadius.only(
                                        topLeft: Radius.circular(12.sp),
                                        bottomRight: Radius.circular(12.sp),
                                      ),
                                      child: Center(
                                        child: Text(
                                          Provider.of<AuthAppProvider>(context,
                                              listen: false)
                                              .bookmarkTestEntity
                                              .userTests![index]
                                              .leftTop!,
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w600,
                                            color: LoopsColors.tertiaryColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                if (_showTest &&
                                    Provider.of<AuthAppProvider>(context,
                                        listen: false)
                                        .bookmarkTestEntity
                                        .userTests![index]
                                        .rightTop !=
                                        null)
                                  Positioned(
                                    right: 0,
                                    child: ContainerWithBorder(
                                      height: 17.h,
                                      width: 56.w,
                                      borderRadius: 12.sp,
                                      boxColor: LoopsColors.primaryColor,
                                      borderR: BorderRadius.only(
                                        topLeft: Radius.circular(12.sp),
                                        bottomRight: Radius.circular(12.sp),
                                      ),
                                      child: Center(
                                        child: Text(
                                          Provider.of<AuthAppProvider>(context,
                                              listen: false)
                                              .bookmarkTestEntity
                                              .userTests![index]
                                              .rightTop!,
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w600,
                                            color: LoopsColors.tertiaryColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ) ,
                ),
              ),
            ),
            SizedBox(
              height: 24.h,
            )
          ],
        ),
      ),
    );
  }
}

final List<SubjectList> _subjectList = [];
