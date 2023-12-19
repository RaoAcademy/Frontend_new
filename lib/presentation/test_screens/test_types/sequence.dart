import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rao_academy/application/test/test_provider.dart';
import 'package:rao_academy/core/utli/loops_urls.dart';
import 'package:rao_academy/core/widgets/container_with_border.dart';
import 'package:rao_academy/domain/entities/test_start_entity.dart';

class Sequence extends StatefulWidget {
  const Sequence({
    Key? key,
    required this.question,
    required this.practice,
  }) : super(key: key);

  final Question question;
  final bool practice;
  @override
  State<Sequence> createState() => _SequenceState();
}

class _SequenceState extends State<Sequence> {
  @override
  void initState() {
    _list2.clear();
    _list2.add(widget.question.choice1!);
    _list2.add(widget.question.choice2!);
    _list2.add(widget.question.choice3!);
    _list2.add(widget.question.choice4!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final provider = context.watch<TestProvider>();
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
                    context.read<TestProvider>().response = '';
                    _index2.forEach((element) {
                      context.read<TestProvider>().response +=
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
                    // color: LoopsColors.secondaryColor,
                    borderRadius: 12.sp,
                    borderColor: LoopsColors.textColor,

                    margin: EdgeInsets.all(8.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 20.w,
                            ),
                            Text(
                              '${_index2[index]} ',
                              style: TextStyle(
                                  color: LoopsColors.textColor,
                                  fontWeight: FontWeight.w500),
                            ),
                            Expanded(
                              child: Text(
                                _list2[index],
                                style: TextStyle(
                                    color: LoopsColors.textColor,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
              ]),
        ),
      ],
    );
  }
}

List<String> _index2 = ['a.', 'b.', 'c.', 'd.'];
List<String> _list2 = [];
