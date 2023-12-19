import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rao_academy/application/test/test_provider.dart';
import 'package:rao_academy/core/utli/error_handle.dart';
import 'package:rao_academy/core/utli/goto_pages.dart';
import 'package:rao_academy/core/utli/loops_urls.dart';
import 'package:rao_academy/core/widgets/container_with_border.dart';
import 'package:rao_academy/presentation/other/widgets/cached_network_image.dart';
import 'package:rao_academy/presentation/test_screens/test_types/mcq.dart';
import 'package:rao_academy/presentation/test_screens/widget/bottombar.dart';
import 'package:rao_academy/presentation/test_screens/widget/goto_test_type.dart';
import 'package:rao_academy/presentation/test_screens/widget/test_type_name.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  bool _review = false;
  DateTime? _start;
  DateTime _end = DateTime.now();
  bool _isBottomSheetOpen = false;

  void _toggleBottomSheet(BuildContext context) {}

  @override
  void initState() {
    _start = DateTime.now();

    // final provider = context.read<TestProvider>();
    if (context.read<TestProvider>().testStart.resumeQuesId != null &&
        context.read<TestProvider>().testStart.resumeQuesId != '' &&
        context.read<TestProvider>().testStart.resumeQuesId != '0') {
      context.read<TestProvider>().currentQuestionPageIndex = context.read<TestProvider>().testStart.question!.indexOf(
          context.read<TestProvider>().testStart.question!.firstWhere((element) =>
              element.questionId == context.read<TestProvider>().testStart.resumeQuesId));
      context.read<TestProvider>().questionId = context.read<TestProvider>().testStart.resumeQuesId!;
      Future.delayed(const Duration(seconds: 2)).then((value) {
        context.read<TestProvider>().pageController.animateToPage(
          context.read<TestProvider>().currentQuestionPageIndex,
          curve: Curves.decelerate,
          duration: const Duration(milliseconds: 300),
        );
      });
    } else {
      if (kDebugMode) {
        print("TEST_INDEX");
        print(context.read<TestProvider>().testStart.question);
        print(context.read<TestProvider>().currentQuestionPageIndex);
      }
      context.read<TestProvider>().currentQuestionPageIndex = 0;
      context.read<TestProvider>().questionId = context.read<TestProvider>()
          .testStart.question![context.read<TestProvider>().currentQuestionPageIndex].questionId!
          .toInt();
    }
    // provider.userTestId = provider.testStart.userTestId!.toInt();

    setOptionLength(context);
    super.initState();
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TestProvider>();
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: LoopsColors.colorWhite,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            SizedBox(
              height: 4.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                getTestName(provider.testStart.question![
                    provider.currentQuestionPageIndex %
                        (provider.testStart.question!.length)]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 32.h,
                    ),
                    IconButton(
                      onPressed: () async {
                        provider.bookmarkQuestion[
                                provider.currentQuestionPageIndex] =
                            !provider.bookmarkQuestion[
                                provider.currentQuestionPageIndex];
                        // if (provider.bookmarkQuestion[
                        //     provider.currentQuestionPageIndex]) {
                          await provider
                              .fquestionBookmark(provider
                                  .testStart
                                  .question![provider.currentQuestionPageIndex]
                                  .questionId!
                                  .toInt())
                              .onError((error, stackTrace) async {
                            await handleError(error);
                          });
                        // }
                      },
                      icon: Icon(
                        provider.bookmarkQuestion[
                                provider.currentQuestionPageIndex]
                            ? Icons.bookmark_added
                            : Icons.bookmark_add_outlined,
                        size: 24.sp,
                        color: LoopsColors.primaryColor,
                      ),
                    ),
                    Checkbox(
                      onChanged: (v) {
                        setState(() {
                          _review = v!;
                          provider.review = v;
                        });
                      },
                      value: provider.review,
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            ContainerWithBorder(
              height: 60,
              width: MediaQuery.of(context).size.width,
              child: PageView.builder(
                controller: provider.pageController,
                itemCount: Provider.of<TestProvider>(context)
                    .testStart
                    .question!
                    .length,
                onPageChanged: (pageIndex) {
                  _end = DateTime.now();
                  final Duration timetaken = _end.difference(_start!);
                  provider.timeTake[provider.currentQuestionPageIndex] +=
                      timetaken.inSeconds;
                  provider.clearPrevious();
                  setState(() {
                    provider.currentQuestionPageIndex = pageIndex;
                    if (kDebugMode) {
                      print("CURRENT_TEST_DEBUG");
                      print(provider.currentQuestionPageIndex);
                    }
                    provider.question = provider
                        .testStart.question![provider.currentQuestionPageIndex];
                    provider.questionId = provider
                        .testStart
                        .question![provider.currentQuestionPageIndex]
                        .questionId!
                        .toInt();
                    provider.indexOfAcceptedItem = -1;
                    setOptionLength(context);
                  });
                },
                itemBuilder: (context, index) {
                  return /* Padding(
                    padding: index == 0
                        ? EdgeInsets.only(
                            left: MediaQuery.of(context).size.width / 2.7)
                        : index == 10 - 1
                            ? EdgeInsets.only(
                                right: MediaQuery.of(context).size.width /
                                    2.7)
                            : EdgeInsets.zero,
                    child:  */
                      InkWell(
                    // key: GlobalObjectKey(index.toString()),
                    onTap: () {
                      setState(() {
                        _end = DateTime.now();
                        final Duration timetaken = _end.difference(_start!);
                        provider.timeTake[provider.currentQuestionPageIndex] +=
                            timetaken.inSeconds;
                        provider.clearPrevious();
                        provider.currentQuestionPageIndex = index;
                        provider.indexOfAcceptedItem = -1;
                        setOptionLength(context);
                        provider.clearPrevious();
                        provider.pageController.animateToPage(
                          provider.currentQuestionPageIndex,
                          curve: Curves.decelerate,
                          duration: const Duration(milliseconds: 300),
                        );
                      });
                      /*  Scrollable.ensureVisible(
                        GlobalObjectKey(index.toString()).currentContext!,
                      ); */
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOutCubic,
                      margin: EdgeInsets.symmetric(
                        horizontal: 5.sp,
                      ),
                      child: ContainerWithBorder(
                        margin: provider.currentQuestionPageIndex == index
                            ? EdgeInsets.zero
                            : EdgeInsets.all(4.sp),
                        /* boxShadow: _currentPageIndex != index
                              ? [
                                  BoxShadow(
                                      blurRadius: 10,
                                      spreadRadius: 0,
                                      color: LoopsColors.colorGrey.withOpacity(0.2),
                                      offset: Offset(5.sp, 5.sp))
                                ]
                              : [], */
                        /* boxColor: _currentPageIndex == index
                              ? LoopsColors.selectedColor.withOpacity(0.5)
                              : LoopsColors.lightGrey.withOpacity(0.01), */
                        width: MediaQuery.of(context).size.width,
                        height: provider.currentQuestionPageIndex == index
                            ? 50.h
                            : 30.h,
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: provider.currentQuestionPageIndex == index
                                ? LoopsColors.colorBlack
                                : LoopsColors.textColor.withOpacity(0.3),
                          ),
                        ),
                      ),
                    ),
                    // ),
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 1.sp,
                    color: LoopsColors.lightGrey,
                  ),
                ),
                Container(
                  height: 2.sp,
                  color: LoopsColors.tertiaryColor,
                  width: 55.w,
                ),
                Expanded(
                  child: Container(
                    height: 1.sp,
                    color: LoopsColors.lightGrey,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 1.sp,
                    color: LoopsColors.lightGrey,
                  ),
                ),
                Container(
                  height: 2.sp,
                  color: LoopsColors.tertiaryColor,
                  width: 55.w,
                ),
                Expanded(
                  child: Container(
                    height: 1.sp,
                    color: LoopsColors.lightGrey,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            if (provider
                    .testStart
                    .question![provider.currentQuestionPageIndex %
                        (provider.testStart.question!.length)]
                    .questionImagePath !=
                null)
              Container(
                height: 150,
                child: LoopsImage(
                    path: provider
                        .testStart
                        .question![provider.currentQuestionPageIndex %
                            (provider.testStart.question!.length)]
                        .questionImagePath!),
              ),
            Expanded(
              flex: 1,
              child: getTestType(
                  provider.testStart.question![
                      provider.currentQuestionPageIndex %
                          (provider.testStart.question!.length)],
                  practice: provider.practice ?? false),
            ),
            SizedBox(
              height: 5.h,
            ),
          ],
        ),
      ),
      floatingActionButton: (provider.practice ?? false) &&
              provider.showAnswer &&
              (provider
                      .testStart
                      .question![provider.currentQuestionPageIndex %
                          (provider.testStart.question!.length)]
                      .ansExplanation !=
                  null)
          ? TextButton(
              style: TextButton.styleFrom(
                textStyle: TextStyle(fontSize: 20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Solution"),
                  SizedBox(width: 8.0),
                  Icon(Icons.question_answer),
                ],
              ),
              onPressed: () {
                if (kDebugMode) {
                  print(provider.currentQuestionPageIndex);
                  print(provider.testStart.question![
                      provider.currentQuestionPageIndex %
                          (provider.testStart.question!.length)]);
                  print(provider
                      .testStart
                      .question![provider.currentQuestionPageIndex %
                          (provider.testStart.question!.length)]
                      .ansExplanation);
                }

                setState(() {
                  _isBottomSheetOpen = true;
                });
                // _toggleBottomSheet(context);
                showModalBottomSheet(
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(25)),
                    ),
                    builder: (BuildContext context) {
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("CLOSE"),
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    // doSomething();
                                  },
                                  icon: Icon(Icons.arrow_downward),
                                  color: Colors.black,

                                  // iconSize:
                                  //     16.0, // istediğiniz boyutu burada belirtebilirsiniz
                                ),
                              ],
                            ),
                            Visibility(
                              visible: (provider.practice ?? false) &&
                                  provider.showAnswer,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ContainerWithBorder(
                                    width:
                                        MediaQuery.of(context).size.width / 1.1,
                                    borderColor: LoopsColors.colorGreen,
                                    borderRadius: 4.sp,
                                    // constraints: BoxConstraints(
                                    //   maxHeight: MediaQuery.of(context).size.height -
                                    //       kToolbarHeight -
                                    //       kBottomNavigationBarHeight -
                                    //       32.0,
                                    // ),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 4.sp,
                                            right: 4.sp,
                                            bottom: 65.sp),
                                        child: Text.rich(
                                          TextSpan(children: <InlineSpan>[
                                            WidgetSpan(
                                                child: SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Text('Solution: ',
                                                  style: TextStyle(
                                                      color: LoopsColors
                                                          .colorGreen)),
                                            )),
                                            if (provider
                                                    .testStart
                                                    .question![provider
                                                            .currentQuestionPageIndex %
                                                        (provider.testStart
                                                            .question!.length)]
                                                    .ansExpImage !=
                                                null)
                                              WidgetSpan(
                                                child: Center(
                                                  child: Visibility(
                                                    visible: provider
                                                            .testStart
                                                            .question![provider
                                                                    .currentQuestionPageIndex %
                                                                (provider
                                                                    .testStart
                                                                    .question!
                                                                    .length)]
                                                            .ansExpImage !=
                                                        null,
                                                    child: Container(
                                                      height: 150,
                                                      child: LoopsImage(
                                                          path: provider
                                                              .testStart
                                                              .question![provider
                                                                      .currentQuestionPageIndex %
                                                                  (provider
                                                                      .testStart
                                                                      .question!
                                                                      .length)]
                                                              .ansExpImage!),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            WidgetSpan(
                                                child: SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 0.h,
                                            )),
                                            TextSpan(
                                                text: provider.question
                                                        .ansExplanation ??
                                                    ''),
                                          ]),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]);
                    }).whenComplete(() {
                  setState(() {
                    _isBottomSheetOpen = false;
                  });
                });
              })
          : Container(),
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        color: LoopsColors.whiteBkground,
        padding: EdgeInsets.symmetric(horizontal: 12.sp),
        height: 55.h,
        child: Bottombar(
          hidePrevious: provider.currentQuestionPageIndex == 0,
          practice: provider.practice ?? false,
          progress: 50.0,
          getValue: (_) {
            _start = DateTime.now();
            provider.clearPrevious();
            if (_) {
              if (provider.currentQuestionPageIndex <
                  Provider.of<TestProvider>(context, listen: false)
                      .testStart
                      .question!
                      .length) {
                ++provider.currentQuestionPageIndex;
                provider.indexOfAcceptedItem = -1;
                provider.pageController.nextPage(
                  curve: Curves.decelerate,
                  duration: const Duration(milliseconds: 300),
                );
              }
            } else {
              if (provider.currentQuestionPageIndex > 0) {
                --provider.currentQuestionPageIndex;
                provider.indexOfAcceptedItem = -1;
                provider.pageController.nextPage(
                  curve: Curves.decelerate,
                  duration: const Duration(milliseconds: 300),
                );
              } else {
                gotoTestHome(context);
              }
            }

            setOptionLength(context);
          },
        ),
      ),
    );
  }
}
