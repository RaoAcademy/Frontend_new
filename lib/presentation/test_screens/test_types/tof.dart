// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:EdTestz/application/test/test_provider.dart';
import 'package:EdTestz/core/utli/loops_urls.dart';
import 'package:EdTestz/core/widgets/container_with_border.dart';
import 'package:EdTestz/domain/entities/test_start_entity.dart';

class TOF extends StatefulWidget {
  const TOF({
    Key? key,
    required this.question,
    required this.practice,
  }) : super(key: key);

  final Question question;
  final bool practice;
  @override
  State<TOF> createState() => _TOFState();
}

class _TOFState extends State<TOF> {
  final List<String> _options = [
    'True',
    'False',
  ];

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TestProvider>();
    if (provider.boolChoice[provider.currentQuestionPageIndex] != null) {
      provider.indexOfAcceptedItem =
          provider.boolChoice[provider.currentQuestionPageIndex] == true
              ? 0
              : 1;
    }
    if (kDebugMode) {
      print("TEST");
      print(provider.indexOfAcceptedItem);
      print(provider.showAnswer);
    }
    return Column(
      children: [
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
          height: 40.h,
        ),
        Wrap(
          children: [
            for (int index = 0; index < 2; index++)
              Padding(
                padding: EdgeInsets.only(
                  top: 12.h,
                  bottom: 12.h,
                  /* left: index.isOdd ? 4.w : 0,
                    right: index.isEven ? 4.w : 0 */
                ),
                child: ContainerWithBorder(
                  margin: EdgeInsets.only(
                      left: index.isOdd ? 14.w : 0,
                      right: index.isEven ? 14.w : 0),
                  width: MediaQuery.of(context).size.width / 2.8,
                  height: 42.h,
                  borderRadius: 8.sp,
                  borderWidth: 1.sp,
                  borderColor: /*(widget.question.answer?.toUpperCase().trim() ==
                              ((index == provider.indexOfAcceptedItem)
                                  .toString()
                                  .toUpperCase()
                                  .trim())) &&*/
                      /* && provider.selectedChoice[
                                        provider.currentQuestionPageIndex] == index+1 */

                      provider.showAnswer &&
                              (index == provider.indexOfAcceptedItem)
                          ? LoopsColors.colorGreen
                          : (provider.selectedChoice[provider
                                                  .currentQuestionPageIndex]
                                              .toString() !=
                                          widget.question.answer &&
                                      index ==
                                          provider.selectedChoice[provider
                                                  .currentQuestionPageIndex] -
                                              1) &&
                                  provider.showAnswer
                              ? LoopsColors.colorRed
                              : !provider.showAnswer
                                  ? LoopsColors.primaryColor
                                  : LoopsColors.colorRed,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        provider.boolChoice[provider.currentQuestionPageIndex] =
                            index == 0;
                        if (provider.indexOfAcceptedItem == index) {
                          provider.indexOfAcceptedItem = -1;
                        } else {
                          provider.indexOfAcceptedItem = index;
                          provider.response = _options[index].toLowerCase();
                        }
                        provider.setState();
                      });
                    },
                    child: ContainerWithBorder(
                      width: MediaQuery.of(context).size.width / 2.2,
                      height: 42.h,
                      borderRadius: 8.sp,
                      borderColor: index == provider.indexOfAcceptedItem
                          ? LoopsColors.secondaryColor
                          : LoopsColors.textColor,
                      child: Text(
                        _options[index],
                        style: TextStyle(
                            color: provider.indexOfAcceptedItem == index
                                ? LoopsColors.colorBlack
                                : LoopsColors.textColor,
                            fontWeight: provider.indexOfAcceptedItem == index
                                ? FontWeight.w600
                                : FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
