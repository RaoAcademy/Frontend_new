import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rao_academy/domain/entities/concept_list.dart';

import '../theme/custom_scroll_behaviour.dart';
import '../utli/loops_urls.dart';

class TestRoundedCornerList extends StatefulWidget {
  const TestRoundedCornerList({
    Key? key,
    required this.textList,
    required this.getValue,
    this.selectedIndex,
  }) : super(key: key);

  final List<ConceptList>? textList;
  final ValueChanged<ConceptList> getValue;
  final num? selectedIndex;

  @override
  State<TestRoundedCornerList> createState() => _TestRoundedCornerListState();
}

class _TestRoundedCornerListState extends State<TestRoundedCornerList> {
  int _selectedIndex = 0;

  @override
  void initState() {
    _selectedIndex = widget.selectedIndex?.toInt() ?? 0;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: ScrollConfiguration(
        behavior: MyBehavior(),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.textList?.length,
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              setState(() {
                _selectedIndex = index;
                widget.getValue
                    .call(widget.textList![_selectedIndex]);
              });
            },
            child: Center(
              child: Row(children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12.sp)),
                    color: index == _selectedIndex
                        ? LoopsColors.selectedColor
                        : LoopsColors.colorWhite,
                    border: Border.all(
                      width: 0.5.sp,
                      color: index == _selectedIndex
                          ? LoopsColors.selectedColor
                          : LoopsColors.textColor,
                    ),
                    boxShadow: [
                      BoxShadow(blurRadius: 2.sp, color: LoopsColors.lightGrey)
                    ],
                  ),
                  height: 24.h,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.sp),
                      child: Text(
                        widget.textList?[index].name ?? "",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: index == _selectedIndex
                              ? LoopsColors.primaryColor
                              : LoopsColors.textColor.withOpacity(0.8),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 12.sp,
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
