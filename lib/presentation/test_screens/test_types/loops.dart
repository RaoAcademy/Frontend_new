import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:EdTestz/application/home/home_provider.dart';
import 'package:EdTestz/application/other/other_provider.dart';
import 'package:EdTestz/application/test/test_provider.dart';
import 'package:EdTestz/core/theme/custom_scroll_behaviour.dart';
import 'package:EdTestz/core/theme/theme.dart';
import 'package:EdTestz/core/utli/loops_urls.dart';
import 'package:EdTestz/core/widgets/box_corner_list.dart';
import 'package:EdTestz/core/widgets/container_with_border.dart';
import 'package:EdTestz/domain/entities/faqs_entity.dart';
import 'package:EdTestz/domain/entities/loops_entity.dart';
import 'package:EdTestz/domain/entities/subjects_entity.dart';
import 'package:EdTestz/presentation/core/bottom_bar.dart';
import 'package:EdTestz/presentation/core/drawer.dart';
import 'package:EdTestz/presentation/home/homescreen.dart';
import 'package:EdTestz/presentation/other/widgets/cached_network_image.dart';
import 'package:EdTestz/presentation/test_screens/test_types/widgets/loops_popup.dart';

final List<FAQsEntity> _faqs = [];
final List<LoopsEntity> _loops = [];

String? _selectedQuestion;
String? _selectedAnswer;

class Loops extends StatefulWidget {
  const Loops({Key? key}) : super(key: key);

  @override
  State<Loops> createState() => _LoopsState();
}

class _LoopsState extends State<Loops> {
  @override
  void initState() {
    context.read<OtherProvider>().currentTab = 2;
    _subjectList.clear();
    _faqs.clear();
    _loops.clear();
    context.read<TestProvider>().loopsHomeEntity.fAQs?.forEach((element) {
      _faqs.add(element);
    });
    // if (kDebugMode) {
    //   // print("TEST_DEBUG");
    //   // print(context.read<TestProvider>().loopsHomeEntity.loops?[0].chapterId);
    // }
    context.read<TestProvider>().loopsHomeEntity.loops?.forEach((element) {
      _loops.add(element);
    });

    context.read<TestProvider>().loopsHomeEntity.subjects?.forEach((element) {
      _subjectList.add(element);
    });

    context.read<TestProvider>().subjectId = int.parse(Provider.of<HomeProvider>(context,listen: false).homeEntity.defaultSubjectId.toString());

    context.read<TestProvider>().floopsHome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TestProvider provider = context.watch<TestProvider>();
    context.watch<OtherProvider>();
    context.read<OtherProvider>().currentTab = 2;
    _selectedQuestion ??= _faqs.first.question;
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
        key: scaffoldKey03,
        bottomNavigationBar: bottomNavigationBar(context),
        drawer: const DrawerWidget(),
        body: Column(
          children: [
            ContainerWithBorder(
              boxColor: LoopsColors.primaryColor,
              height: 64.h,
              child: Row(
                children: [
                  SizedBox(
                    width: 24.w,
                  ),
                  Text(
                    'Loops',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: LoopsColors.colorWhite,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: ListView(
                    children: [
                      BoxCornerList(
                          selectedIndex:
                              provider.loopsHomeEntity.subjects!.indexOf(
                            provider.loopsHomeEntity.subjects!.firstWhere(
                              (element) =>
                                  element.id ==
                                  context
                                      .read<HomeProvider>()
                                      .homeEntity
                                      .defaultSubjectId,
                            ),
                          ),
                          textList: _subjectList,
                          getValue: (value) {
                            provider.subjectId = provider
                                .loopsHomeEntity.subjects!
                                .firstWhere((element) =>
                                    element.name == value[value.keys.first])
                                .id!
                                .toInt();

                            provider.floopsHome();
                          }),
                      SizedBox(
                        height: 30.h,
                      ),
                      Wrap(
                        alignment: WrapAlignment.spaceAround,
                        runAlignment: WrapAlignment.spaceAround,
                        // crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          for (int index = 0;
                              index <
                                  (provider.loopsHomeEntity.loops?.length ?? 0);
                              index++)
                            ContainerWithBorder(
                              width: MediaQuery.of(context).size.width / 3.6,
                              boxColor: Colors.transparent,
                              padding: EdgeInsets.only(right: 14.w),
                              child: InkWell(
                                onTap: () {
                                  provider
                                      .floopsBottomSheet(provider
                                          .loopsHomeEntity.loops![index])
                                      .then((value) async {
                                    num? testId = provider
                                        .loopsHomeEntity.loops![index].id;
                                    if (Provider.of<TestProvider>(context,
                                            listen: false)
                                        .loopsBottomSheetEntity
                                        .start!) {
                                      if (kDebugMode) {
                                        print("TEST_START");
                                        print(provider
                                            .loopsHomeEntity.loops![index].id);
                                        // print(_loops[index]);
                                      }



                                     await showPopup01(
                                          context,
                                          context
                                              .read<TestProvider>()
                                              .loopsHomeEntity
                                              .subjects!,
                                          Provider.of<TestProvider>(context,
                                              listen: false),
                                          testId!,provider.loopsHomeEntity
                                         .loops![index].imagePath!);

                                    } else if (Provider.of<TestProvider>(
                                            context,
                                            listen: false)
                                        .loopsBottomSheetEntity
                                        .resume!) {
                                      if (kDebugMode) {
                                        print("TEST_RESUME");

                                        // print(_loops[index]);
                                      }
                                      showPopup02(
                                          context,
                                          context
                                              .read<TestProvider>()
                                              .loopsHomeEntity
                                              .subjects!,
                                          Provider.of<TestProvider>(context,
                                              listen: false),
                                          testId!,provider.loopsHomeEntity
                                          .loops![index].imagePath!);
                                      // gotoSprintHistory(
                                      //     context,
                                      //     (provider.loopsHomeEntity.loops?[index]
                                      //             .chapterId)!
                                      //         .toInt());
                                      // if (kDebugMode) {
                                      //   print("TEST_DEBUG");
                                      //   print(index);
                                      //   // print(context.read<TestProvider>().loopsHomeEntity.loops?[0].chapterId);
                                      //   print(provider.chapterId);
                                      //   print(provider.loopsHomeEntity.loops?[0]);
                                      //   print(_loops.first.chapterId);
                                      // }
                                    }
                                    // else if (Provider.of<TestProvider>(context,
                                    //
                                    //         listen: false)
                                    //     .loopsBottomSheetEntity
                                    //     .retake!) {

                                    // }
                                    else {
                                      if (kDebugMode) {
                                        print("TEST_ELSE");

                                        // print(_loops[index]);
                                      }
                                    var res = await  showPopup03(
                                        context,
                                        context
                                            .read<TestProvider>()
                                            .loopsHomeEntity
                                            .subjects!,
                                        Provider.of<TestProvider>(context,
                                            listen: false),provider.loopsHomeEntity
                                        .loops![index].imagePath!
                                      );
                                      if(res == true){
                                        await showPopup01(
                                            context,
                                            context
                                                .read<TestProvider>()
                                                .loopsHomeEntity
                                                .subjects!,
                                            Provider.of<TestProvider>(context,
                                                listen: false),
                                            testId!,provider.loopsHomeEntity
                                            .loops![index].imagePath!);
                                      }
                                      // gotoSprintHistory(
                                      //     context,
                                      //     (provider.loopsHomeEntity.loops?[index]
                                      //         .chapterId)!
                                      //         .toInt());

                                      // showPopup01(
                                      //   context,
                                      //   context
                                      //       .read<TestProvider>()
                                      //       .loopsHomeEntity
                                      //       .subjects!,
                                      //   Provider.of<TestProvider>(context,
                                      //       listen: false),
                                      // );
                                    }
                                  });
                                },
                                child: Column(
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    LoopsImage(
                                      height: 65.h,
                                      width: 65.w,
                                      path: provider.loopsHomeEntity
                                          .loops![index].imagePath!,
                                    ),
                                    /* ContainerWithBorder(
                                      boxColor:
                                          const Color.fromARGB(168, 245, 73, 125),
                                      borderRadius: 100.sp,
                                      height: 65.sp,
                                      width: 65.sp,
                                      child: Center(
                                        child: Icon(
                                          Icons.filter_vintage_rounded,
                                          size: 30.sp,
                                          color: LoopsColors.iconColor,
                                        ),
                                      ),
                                    ), */
                                    SizedBox(
                                      height: 6.h,
                                    ),
                                    Container(
                                        constraints: BoxConstraints(
                                          maxWidth: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3.6,
                                        ),
                                        child: Text(
                                          provider.loopsHomeEntity.loops![index]
                                              .name!,
                                          textAlign: TextAlign.center,
                                          maxLines: 3,
                                          overflow: TextOverflow.fade,
                                          style: appTheme.textTheme.bodyLarge!
                                              .copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: LoopsColors.colorGrey,
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                            )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 24.sp, bottom: 12.sp),
                        child: Text(
                          'Get Started with Loops',
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: LoopsColors.colorBlack),
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Wrap(
                              spacing: 12.sp,
                              runSpacing: 12.sp,
                              children: [
                                for (var item in _faqs)
                                  ContainerWithBorder(
                                    height: 32.h,
                                    borderRadius: 14.sp,
                                    // borderColor: LoopsColors.primaryColor,
                                    width: item.question!.characters.length *
                                        8.7.w,
                                    boxColor: _selectedQuestion == item.question
                                        ? LoopsColors.secondaryColor
                                            .withOpacity(0.2)
                                        : LoopsColors.whiteBkground,
                                    borderColor:
                                        _selectedQuestion == item.question
                                            ? LoopsColors.secondaryColor
                                                .withOpacity(0.2)
                                            : LoopsColors.primaryColor,
                                    child: InkWell(
                                      onTap: () {
                                        _selectedQuestion = item.question;
                                        _selectedAnswer = item.answer;
                                        provider.setState();
                                      },
                                      child: Text(
                                        item.question!,
                                        style: appTheme.textTheme.bodyLarge!
                                            .copyWith(
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
                            boxColor:
                                LoopsColors.secondaryColor.withOpacity(0.2),
                            child: Padding(
                              padding: EdgeInsets.all(12.sp),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _selectedQuestion ?? _faqs.first.question!,
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
                                  Text(
                                    _selectedAnswer ?? _faqs.first.answer!,
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
                        height: 12.h,
                      ),
                      /* Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 60.h,
                            child: ListView.separated(
                                separatorBuilder: (context, index) => SizedBox(
                                      width: 12.w,
                                    ),
                                scrollDirection: Axis.horizontal,
                                itemCount: _faqs.length,
                                itemBuilder: (conttext, index) {
                                  return ContainerWithBorder(
                                    height: 32.h,
                                    borderRadius: 14.sp,
                                    // borderColor: LoopsColors.primaryColor,
                                    margin: EdgeInsets.symmetric(vertical: 12.sp),
                                    width: _faqs[index].characters.length *
                                        8.7.w,
                                    boxColor: LoopsColors.secondaryColor
                                        .withOpacity(0.2),
                                    child: InkWell(
                                      onTap: () {
                                        showModalBottomSheet(
                                            context: context,
                                            backgroundColor: Colors.transparent,
                                            isDismissible: false,
                                            builder: (context) {
                                              return ContainerWithBorder(
                                                height: 300.h,
                                                borderRadius: 12.sp,
                                                padding: EdgeInsets.all(12.sp),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          _faqs[index],
                                                          style: TextStyle(
                                                            fontSize: 16.sp,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: LoopsColors
                                                                .primaryColor,
                                                            letterSpacing:
                                                                0.03.sp,
                                                          ),
                                                        ),
                                                        IconButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            icon: Icon(
                                                              Icons
                                                                  .do_not_disturb_alt_rounded,
                                                              color: LoopsColors
                                                                  .textColor
                                                                  .withOpacity(
                                                                      0.8),
                                                            )),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 12.h,
                                                    ),
                                                    Text(
                                                      '${_faqs.first}: Loops are a new way of taking test and achieving your target score.Loops are a new way of taking test and achieving your target score.Loops are a new way of taking test and achieving your target score.Loops are a new way of taking test and achieving your target score.',
                                                      style: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            LoopsColors.textColor,
                                                        letterSpacing: 0.1.sp,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            });
                                      },
                                      child: Text(
                                        _faqs[index],
                                        style: appTheme.textTheme.bodyLarge!
                                            .copyWith(
                                          // fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                          color: LoopsColors.primaryColor,
                                          letterSpacing: 0.1.sp,
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                        ],
                      ) */
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

final List<Subjects> _subjectList = [];
