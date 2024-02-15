// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:EdTestz/application/test/test_provider.dart';
import 'package:EdTestz/core/utli/loops_urls.dart';
import 'package:EdTestz/core/widgets/custom_text_field.dart';
import 'package:EdTestz/domain/entities/recommendations_entity.dart';
import 'package:EdTestz/domain/entities/test_start_entity.dart';

class Fill extends StatefulWidget {
  const Fill({
    Key? key,
    required this.question,
    required this.practice,
  }) : super(key: key);

  final Question question;
  final bool practice;
  @override
  State<Fill> createState() => _FillState();
}

TextEditingController _controller = TextEditingController(text: '');

class _FillState extends State<Fill> {
  // final TextEditingController _controller = TextEditingController(text: '');
  @override
  void initState() {
    _controller.text = '';
    final provider = context.read<TestProvider>();
    _controller.text = provider.filledAnswer[provider.currentQuestionPageIndex];
    provider.testEntity = TestEntity(
      userTestId: provider.testStart.userTestId!.toInt(),
      // testId: provider.testStart
    );
    provider.questionId = widget.question.questionId!.toInt();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TestProvider>();
    if (provider.filledAnswer[provider.currentQuestionPageIndex] != '') {
      _controller.text =
          provider.filledAnswer[provider.currentQuestionPageIndex];
    } else {
      _controller.text = provider.response;
    }
    return GestureDetector(
      onTap: () {
        provider.response = provider
            .filledAnswer[provider.currentQuestionPageIndex] = _controller.text;
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: ColoredBox(
        color: LoopsColors.colorWhite,
        child: Column(
          children: [
            SizedBox(
              height: 30.h,
            ),
            Text.rich(
              TextSpan(
                children: <InlineSpan>[
                  if (widget.question.questionText!.indexOf('_____') != 0)
                    TextSpan(
                      text: widget.question.questionText
                          ?.split('_____')
                          .first
                          .replaceAll('_', ''),
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        height: 1.6.h,
                      ),
                    ),
                  WidgetSpan(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2.2,
                      child: CustomTextField(
                        controller: _controller,
                        borderColor:
    context.read<TestProvider>().showAnswer ? widget.question.answer == provider.response ? LoopsColors.colorGreen : LoopsColors.colorRed :LoopsColors.textColor,
                        // widget.question.answer ==
                        //
                        //     context.read<TestProvider>().showAnswer
                        //     ? LoopsColors.colorGreen
                        //     : (context.read<TestProvider>().selectedChoice[context.read<TestProvider>()
                        //     .currentQuestionPageIndex]
                        //     .toString() !=
                        //     widget.question.answer &&
                        //     1 ==
                        //         context.read<TestProvider>().selectedChoice[context.read<TestProvider>()
                        //             .currentQuestionPageIndex] -
                        //             1) &&
                        //     context.read<TestProvider>().showAnswer
                        //     ? LoopsColors.colorRed
                        //     : LoopsColors.primaryColor,
                        smallSize: true,
                        onFieldSubmitted: (v) {
                          log(v);
                          provider.filledAnswer[
                                  provider.currentQuestionPageIndex] =
                              _controller.text = provider.response = v;
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                      ),
                    ),
                  ),
                  if (widget.question.questionText!.indexOf('_____') <
                      widget.question.questionText!.length - 5)
                    TextSpan(
                      text: widget.question.questionText
                          ?.split('_____')
                          .last
                          .replaceAll('_', ''),
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
              height: 60.h,
            )
            // if()
          ],
        ),
      ),
    );
  }
}
