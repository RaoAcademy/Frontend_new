// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:EdTestz/core/utli/loops_urls.dart';
import 'package:EdTestz/core/widgets/container_with_border.dart';
import 'package:EdTestz/domain/entities/test_start_entity.dart';

import '../../../application/test/test_provider.dart';
import '../../../core/utli/logger.dart';

class DragNDrop extends StatefulWidget {
  const DragNDrop({
    Key? key,
    required this.question,
    required this.practice,
  }) : super(key: key);

  final Question question;
  final bool practice;
  @override
  State<DragNDrop> createState() => _DragNDropState();
}

class _DragNDropState extends State<DragNDrop> {
  int _indexOfDroppedItem = 0;
  int _indexOfAcceptedItem = -1;
  bool _isDragging = false;

  void _acceptDraggedItem(int index) {
    setState(() {
      _indexOfAcceptedItem = index;
      _indexOfDroppedItem = index;
    });
  }
  
  String showNewOptionValue(int index){

    if(index == 0){
      return widget.question.choice1 ?? "";
    }else if(index == 1){
      return widget.question.choice2 ?? "";
    }else if(index == 2){
      return widget.question.choice3 ?? "";
    }else{
      return widget.question.choice4 ?? "";
    }
  }

  void _setIsDragging(TestProvider provider,int index) {
    setState(() {
      _isDragging = true;
    });
    // if (provider.showAnswer == false) {
      setState(() {
        if (provider.selectedChoice[
        provider.currentQuestionPageIndex] ==
            index + 1) {
          provider.selectedChoice[
          provider.currentQuestionPageIndex] = -1;
        } else {
          provider.selectedChoice[provider
              .currentQuestionPageIndex] = index + 1;
          provider.response = (index + 1).toString();
          // if (_start != null) {

            provider.timeTake[
            provider.currentQuestionPageIndex] +=
                DateTime.now().second;
            provider.timetaken = provider.timeTake[
            provider.currentQuestionPageIndex];
          // }
        }
        logger.i(index);
      });

    // }
  }

  void _resetIsDragging() {
    setState(() {
      _isDragging = false;
    });
  }

  // final List<String> _options = [];

  @override
  void initState() {
    // _options.clear();
    //
    // _options.add(widget.question.choice1!);
    // _options.add(widget.question.choice2!);
    // _options.add(widget.question.choice3!);
    // _options.add(widget.question.choice4!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LoopsColors.colorWhite,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            SizedBox(
              height: 30.h,
            ),
            Text.rich(
              TextSpan(
                children: <InlineSpan>[
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
                      child: Column(
                    children: [
                      if (_indexOfAcceptedItem == _indexOfDroppedItem &&
                          !_isDragging &&
                          _indexOfAcceptedItem != -1)
                        ContainerWithBorder(
                          constraints: BoxConstraints(
                            minHeight: 42.h,
                            // maxHeight: 100.h,
                          ),
                          borderRadius: 8.sp,

                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(vertical: 8.sp),
                          borderColor: LoopsColors.primaryColor,
                          borderWidth: 1.sp,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 32.w,
                                child: Center(
                                  child: Text(
                                    _indexOfAcceptedItem == 0
                                        ? 'a.'
                                        : _indexOfAcceptedItem == 1
                                            ? 'b.'
                                            : _indexOfAcceptedItem == 2
                                                ? 'c.'
                                                : 'd.',
                                    style: TextStyle(
                                        color: LoopsColors.textColor,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  _indexOfAcceptedItem == -1
                                      ? ''
                                      : showNewOptionValue(_indexOfAcceptedItem),
                                  style: TextStyle(
                                    color: LoopsColors.textColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      else
                        DragTarget<int>(
                          builder: (
                            BuildContext context,
                            List<dynamic> accepted,
                            List<dynamic> rejected,
                          ) {
                            return ContainerWithBorder(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(vertical: 8.sp),
                              height: 42.h,
                              boxColor: LoopsColors.colorWhite,
                              borderColor: LoopsColors.textColor,
                              child: const Text(
                                '',
                              ),
                            );
                          },
                          onAccept: (int data) {
                            log(data.toString());
                            _acceptDraggedItem(data);
                          },
                        ),
                    ],
                  )),
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
              height: 40.h,
            ),
            Wrap(
              children: [
                for (int index = 0; index < 4; index++)
                  Padding(
                    padding: EdgeInsets.only(
                      top: 12.h,
                      bottom: 12.h,
                      left: 4.w,
                      right: 4.w,
                      /* left: index.isOdd ? 4.w : 0,
                          right: index.isEven ? 4.w : 0 */
                    ),
                    child: Draggable<int>(
                      data: index,
                      childWhenDragging: ContainerWithBorder(
                        constraints: BoxConstraints(
                          minHeight: 42.h,
                          // maxHeight: 100.h,
                        ),
                        borderColor: widget.question.answer ==
                            (index + 1)
                                .toString() /* && provider.selectedChoice[
                                        provider.currentQuestionPageIndex] == index+1 */
                            &&
                            context.read<TestProvider>().showAnswer
                            ? LoopsColors.colorGreen
                            : (context.read<TestProvider>().selectedChoice[context.read<TestProvider>()
                            .currentQuestionPageIndex]
                            .toString() !=
                            widget.question.answer &&
                            index ==
                                context.read<TestProvider>().selectedChoice[context.read<TestProvider>()
                                    .currentQuestionPageIndex] -
                                    1) &&
                            context.read<TestProvider>().showAnswer
                            ? LoopsColors.colorRed
                            : LoopsColors.primaryColor,
                        borderRadius: 8.sp,
                        ////////////////////

                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: 8.sp),

                        boxColor: LoopsColors.textColor.withOpacity(0.5),
                        /* boxColor: /* index == _indexOfAcceptedItem
                            ? LoopsColors.primaryColor
                            : */
                            LoopsColors.secondaryColor, */
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
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                showNewOptionValue(index),
                                style: TextStyle(
                                  color: _indexOfAcceptedItem == index
                                      ? LoopsColors.colorWhite
                                      : LoopsColors.textColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onDragStarted: () {
                        _setIsDragging(context.read<TestProvider>(),index);
                      },
                      onDraggableCanceled: (_, __) {
                        _resetIsDragging();
                      },
                      onDragCompleted: () {
                        _resetIsDragging();
                      },
                      feedback: Material(
                        child: ContainerWithBorder(
                          constraints: BoxConstraints(
                            minHeight: 42.h,
                            // maxHeight: 100.h,
                          ),
                          borderRadius: 8.sp,
                          borderWidth: (widget.question.answer ==
                              (index + 1)
                                  .toString() /* && provider.selectedChoice[
                                        provider.currentQuestionPageIndex] == index+1 */
                             ) ||
                              widget.question.answer ==
                                  (index + 1).toString() &&
                                  context.read<TestProvider>().selectedChoice[context.read<TestProvider>()
                                      .currentQuestionPageIndex] ==
                                      index + 1
                              ? 1.sp
                              : index ==
                              context.read<TestProvider>().selectedChoice[
                              context.read<TestProvider>().currentQuestionPageIndex] -
                                  1
                              ? 1.sp
                              : 0.5.sp,

                          width: MediaQuery.of(context).size.width / 1.4,
                          padding: EdgeInsets.symmetric(vertical: 8.sp),
                          borderColor: widget.question.answer ==
                              (index + 1)
                                  .toString() /* && provider.selectedChoice[
                                        provider.currentQuestionPageIndex] == index+1 */
                              &&
                              context.read<TestProvider>().showAnswer
                              ? LoopsColors.colorGreen
                              : (context.read<TestProvider>().selectedChoice[context.read<TestProvider>()
                              .currentQuestionPageIndex]
                              .toString() !=
                              widget.question.answer &&
                              index ==
                                  context.read<TestProvider>().selectedChoice[context.read<TestProvider>()
                                      .currentQuestionPageIndex] -
                                      1) &&
                              context.read<TestProvider>().showAnswer
                              ? LoopsColors.colorRed
                              : LoopsColors.primaryColor,
                          /* boxColor: /* index == _indexOfAcceptedItem
                              ? LoopsColors.primaryColor
                              : */
                              LoopsColors.secondaryColor, */
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
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  showNewOptionValue(index),
                                  style: TextStyle(
                                    color: _indexOfAcceptedItem == index
                                        ? LoopsColors.colorWhite
                                        : LoopsColors.textColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      child: ContainerWithBorder(
                        constraints: BoxConstraints(
                          minHeight: 42.h,
                          // maxHeight: 100.h,
                        ),
                        borderRadius: 8.sp,
                        ////////////////////

                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: 8.sp),
                        borderColor: widget.question.answer ==
                            (index + 1)
                                .toString() /* && provider.selectedChoice[
                                        provider.currentQuestionPageIndex] == index+1 */
                            &&
                            context.read<TestProvider>().showAnswer
                            ? LoopsColors.colorGreen
                            : (context.read<TestProvider>().selectedChoice[context.read<TestProvider>()
                            .currentQuestionPageIndex]
                            .toString() !=
                            widget.question.answer &&
                            index ==
                                context.read<TestProvider>().selectedChoice[context.read<TestProvider>()
                                    .currentQuestionPageIndex] -
                                    1) &&
                            context.read<TestProvider>().showAnswer
                            ? LoopsColors.colorRed
                            : LoopsColors.primaryColor,
                        /* boxColor: /* index == _indexOfAcceptedItem
                            ? LoopsColors.primaryColor
                            : */
                            LoopsColors.secondaryColor, */
                        ///this work
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
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                showNewOptionValue(index),
                                style: TextStyle(
                                  color: LoopsColors.textColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
