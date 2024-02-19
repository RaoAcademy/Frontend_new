import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:EdTestz/application/test/test_provider.dart';
import 'package:EdTestz/core/utli/goto_pages.dart';
import 'package:EdTestz/core/utli/loops_urls.dart';
import 'package:EdTestz/core/widgets/container_with_border.dart';
import 'package:EdTestz/domain/entities/test_start_entity.dart';

class MSQ extends StatefulWidget {
  const MSQ({
    Key? key,
    required this.question,
    required this.practice,
  }) : super(key: key);

  final Question question;
  final bool practice;

  @override
  State<MSQ> createState() => _MSQState();
}

// double _maxWidthChoice = 120.w;

class _MSQState extends State<MSQ> {
  DateTime? _start;
  DateTime _end = DateTime.now();

  @override
  void initState() {
    _start = DateTime.now();
    final provider = context.read<TestProvider>();
    // provider.userTestId = provider.testStart.userTestId!.toInt();
    provider.questionId = widget.question.questionId!.toInt();
    setOptionLength(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TestProvider>();
    if (kDebugMode) {
      print('my selected options:' + provider.response);
    }
    return Column(
      children: [
        /* Row(
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
        ), */
        SizedBox(
          height: 30.h,
        ),
        Text.rich(
          TextSpan(
            children: <InlineSpan>[
              TextSpan(
                text: widget.question.questionText,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  height: 1.6.h,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Expanded(
          flex: 2,
          child: Center(
            child: Wrap(
              children: [
                for (int index = 0; index < 4; index++)
                  Padding(
                    padding: EdgeInsets.only(
                      top: 3.h,
                      bottom: 12.h,
                      left: 4.w,
                      right: 4.w,
                      /* left: index.isOdd ? 4.w : 0,
                          right: index.isEven ? 4.w : 0 */
                    ),
                    child: ContainerWithBorder(
                      width: MediaQuery.of(context).size.width,
                      // height: 42.h,
                      borderRadius: 8.sp,
                      child: InkWell(
                        onTap: () {
                          if (kDebugMode) {
                            print("Selected");
                            print(index);
                          }
                          if (provider.showAnswer == false) {
                            setState(() {
                              if (provider.selectedChoices[provider
                                      .currentQuestionPageIndex][index] ==
                                  index + 1) {
                                provider.selectedChoices[provider
                                    .currentQuestionPageIndex][index] = -1;
                              } else {
                                provider.selectedChoices[
                                        provider.currentQuestionPageIndex]
                                    [index] = index + 1;
                                provider.response = (index + 1).toString();
                                if (_start != null) {
                                  _end = DateTime.now();
                                  final Duration timetaken =
                                      _end.difference(_start!);
                                  provider.timeTake[
                                          provider.currentQuestionPageIndex] +=
                                      timetaken.inSeconds;
                                  provider.timetaken = provider.timeTake[
                                      provider.currentQuestionPageIndex];
                                }
                              }
                            });
                            provider.response = '';
                            provider.selectedChoices[
                                    provider.currentQuestionPageIndex]
                                .forEach((element) {
                              if (element > 0) {
                                provider.response += '$element,';
                              }
                            });
                          }
                        },
                        child: ContainerWithBorder(
                          constraints: BoxConstraints(
                            minHeight: 42.h,
                            // maxHeight: 100.h,
                          ),
                          borderRadius: 8.sp,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(vertical: 8.sp),

                          borderWidth:
                              /* ((widget.question.answer?.contains((index + 1)
                                        .toString())??false)
                                      &&
                                      provider.showAnswer) ||
                                  widget.question.answer ==
                                          (index + 1).toString() &&
                                      provider.selectedChoice[provider
                                              .currentQuestionPageIndex] ==
                                          index + 1
                              ? 1.sp
                              : index ==
                                      provider.selectedChoice[provider
                                              .currentQuestionPageIndex] -
                                          1
                                  ? 1.sp
                                  : 0.5.sp, */
                              (index ==
                                          provider.selectedChoices[provider
                                                      .currentQuestionPageIndex]
                                                  [index] -
                                              1 &&
                                      !provider.refresh)
                                  ? 1.sp
                                  : 0.5.sp,
                          boxColor: /*  index ==
                                  provider.selectedChoice[
                                          provider.currentQuestionPageIndex] -
                                      1
                              ? LoopsColors.secondaryColor
                              :  */
                              LoopsColors.colorWhite,
                          borderColor: (widget.question.answer
                                          ?.contains((index + 1).toString()) ??
                                      false)
                                  /* && provider.selectedChoice[
                                        provider.currentQuestionPageIndex] == index+1 */
                                  &&
                                  provider.showAnswer
                              ? LoopsColors.colorGreen
                              : (provider.selectedChoice[provider
                                                      .currentQuestionPageIndex]
                                                  .toString() !=
                                              widget.question.answer &&
                                          index ==
                                              provider.selectedChoice[provider
                                                      .currentQuestionPageIndex] -
                                                  1 &&
                                          !provider.refresh) &&
                                      provider.showAnswer
                                  ? LoopsColors.colorRed
                                  : !provider.showAnswer
                                      ? LoopsColors.primaryColor
                                      : LoopsColors.colorRed,

                          /*  index ==
                                  provider.selectedChoices[provider
                                          .currentQuestionPageIndex][index] -
                                      1
                              ? LoopsColors.primaryColor
                              : LoopsColors.textColor, */

                          ////////////////////

                          child: Row(
                            children: [
                              SizedBox(
                                width: 32.w,
                                child: Center(
                                  child: Text(
                                    index == 0
                                        ? 'a.'
                                        : index == 1
                                            ? 'b.'
                                            : index == 2
                                                ? 'c.'
                                                : 'd.',
                                    style: TextStyle(
                                        color: LoopsColors.textColor,
                                        fontWeight: provider.selectedChoices[
                                                            provider
                                                                .currentQuestionPageIndex]
                                                        [index] -
                                                    1 ==
                                                index
                                            ? FontWeight.w600
                                            : FontWeight.w500),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  index == 0
                                      ? '${widget.question.choice1}'
                                      : index == 1
                                          ? '${widget.question.choice2}'
                                          : index == 2
                                              ? '${widget.question.choice3}'
                                              : '${widget.question.choice4}',
                                  style: TextStyle(
                                      color: /* provider.selectedChoices[provider
                                                          .currentQuestionPageIndex]
                                                      [index] -
                                                  1 ==
                                              index
                                          ? LoopsColors.colorWhite
                                          : */
                                          LoopsColors.textColor,
                                      fontWeight: provider.selectedChoices[provider
                                                          .currentQuestionPageIndex]
                                                      [index] -
                                                  1 ==
                                              index
                                          ? FontWeight.w600
                                          : FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(),
        )
      ],
    );
  }
}

void setOptionLength(BuildContext context) {
  final provider = Provider.of<TestProvider>(context, listen: false);
  // _maxWidthChoice = 120.w;
  provider.bookmarked = false;
  provider.review = false;

  try {
    if (provider.currentQuestionPageIndex <
        provider.testStart.question!.length) {
      provider.questionId = provider
          .testStart.question![provider.currentQuestionPageIndex].questionId!
          .toInt();

      /*  if (provider.testStart.question![provider.currentQuestionPageIndex]
                  .choice1!.length *
              8 >
          _maxWidthChoice) {
        _maxWidthChoice = provider.testStart
                .question![provider.currentQuestionPageIndex].choice1!.length *
            8;
      }
      if (provider.testStart.question![provider.currentQuestionPageIndex]
                  .choice2!.length *
              8 >
          _maxWidthChoice) {
        _maxWidthChoice = provider.testStart
                .question![provider.currentQuestionPageIndex].choice2!.length *
            8;
      }
      if (provider.testStart.question![provider.currentQuestionPageIndex]
                  .choice3!.length *
              8 >
          _maxWidthChoice) {
        _maxWidthChoice = provider.testStart
                .question![provider.currentQuestionPageIndex].choice3!.length *
            8;
      }
      if (provider.testStart.question![provider.currentQuestionPageIndex]
                  .choice4!.length *
              8 >
          _maxWidthChoice) {
        _maxWidthChoice = provider.testStart
                .question![provider.currentQuestionPageIndex].choice4!.length *
            8;
      }
      if (_maxWidthChoice >= 350) {
        _maxWidthChoice = MediaQuery.of(context).size.width;
      } */
    } else {
      gotoTestSummary(context, provider.testStart.userTestId!.toInt(), false);
    }
    // ignore: avoid_catches_without_on_clauses
  } catch (_) {
    //ignore
  }
}
