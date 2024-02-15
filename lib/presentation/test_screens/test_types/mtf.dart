// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:EdTestz/application/test/test_provider.dart';
import 'package:EdTestz/core/utli/loops_urls.dart';
import 'package:EdTestz/core/widgets/container_with_border.dart';
import 'package:EdTestz/domain/entities/test_start_entity.dart';

class MathTheFollowing extends StatefulWidget {
  const MathTheFollowing({
    Key? key,
    required this.question,
    required this.practice,
  }) : super(key: key);

  final Question question;
  final bool practice;
  @override
  State<MathTheFollowing> createState() => _MathTheFollowingState();
}

class _MathTheFollowingState extends State<MathTheFollowing> {
  @override
  void initState() {
    _list.clear();
    _list.add(widget.question.leftChoice1!);
    _list.add(widget.question.leftChoice2!);
    _list.add(widget.question.leftChoice3!);
    _list.add(widget.question.leftChoice4!);
    _list2.clear();
    _list2.add(widget.question.rightChoice1!);
    _list2.add(widget.question.rightChoice2!);
    _list2.add(widget.question.rightChoice3!);
    _list2.add(widget.question.rightChoice4!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TestProvider>();
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
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                  child: Column(
                children: [
                  for (int index = 0; index < 4; index++)
                    ContainerWithBorder(
                      key: Key('$index'),
                      width: MediaQuery.of(context).size.width,
                      /*  constraints: BoxConstraints(
                          minHeight: 44.sp,
                        ), */
                      height: 44.sp,
                      boxColor: LoopsColors.colorGrey.withOpacity(0.2),
                      borderColor: LoopsColors.colorGrey,
                      borderRadius: 8.sp,
                      margin: EdgeInsets.all(8.sp),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.sp),
                            child: Row(
                              children: [
                                Text(
                                  '${_index1[index]})  ',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: LoopsColors.textColor,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    _list[index],
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: LoopsColors.textColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              )),
              Expanded(
                child: ReorderableListView(
                    physics: const NeverScrollableScrollPhysics(),
                    onReorder: (int oldIndex, int newIndex) async {
                      if (newIndex != oldIndex) {
                        setState(() {
                          final tempIndex =
                              newIndex < oldIndex ? newIndex : newIndex - 1;

                          final place = _list2[oldIndex];
                          _list2.removeAt(oldIndex);
                          _list2.insert(tempIndex, place);

                          final index = _index2[oldIndex];
                          _index2.removeAt(oldIndex);
                          _index2.insert(tempIndex, index);

                          provider.response = '';
                          _index2.forEach((element) {
                            provider.response +=
                                '$element,${_list2.indexOf(_list2[_index2.indexOf(element)]) + 1},';
                          });
                        });
                      }
                    },
                    children: [
                      for (int index = 0; index < 4; index++)
                        ContainerWithBorder(
                          key: Key('$index'),
                          width: MediaQuery.of(context).size.width,
                          /* constraints: BoxConstraints(
                              minHeight: 44.sp,
                            ), */
                          height: 44.sp,
                          // boxColor: LoopsColors.secondaryColor,

                          boxColor: LoopsColors.colorWhite,
                          borderColor: LoopsColors.primaryColor,
                          borderRadius: 8.sp,
                          margin: EdgeInsets.all(8.sp),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4.sp),
                                child: Row(
                                  children: [
                                    Text(
                                      '${_index2[index]})  ',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        color: LoopsColors.textColor,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        _list2[index],
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          color: LoopsColors.textColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                    ]),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

List<String> _index1 = ['1', '2', '3', '4'];
List<String> _index2 = ['A', 'B', 'C', 'D'];
List<String> _list = [];
List<String> _list2 = [];
