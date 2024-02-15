import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:EdTestz/core/theme/custom_scroll_behaviour.dart';
import 'package:EdTestz/core/utli/loops_urls.dart';
import 'package:EdTestz/domain/entities/subjects_entity.dart';

class BoxCornerList extends StatefulWidget {
  const BoxCornerList({
    Key? key,
    required this.textList,
    required this.getValue,
    this.selectedIndex,
  }) : super(key: key);

  final List<Subjects> textList;
  final ValueChanged<Map<int, String>> getValue;
  final num? selectedIndex;

  @override
  State<BoxCornerList> createState() => _BoxCornerListState();
}

int _selectedIndex = 0;

class _BoxCornerListState extends State<BoxCornerList> {
  @override
  void initState() {
    _selectedIndex = widget.selectedIndex?.toInt() ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36.h,
      child: ScrollConfiguration(
        behavior: MyBehavior(),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.textList.length,
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              setState(() {
                _selectedIndex = index;
                widget.getValue.call(
                    {_selectedIndex: widget.textList[_selectedIndex].name!});
              });
            },
            child: Row(children: [
              Container(
                height: 26.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4.sp)),
                  color: index == _selectedIndex
                      ? LoopsColors.selectedColor
                      : LoopsColors.colorWhite,
                  boxShadow: [
                    BoxShadow(blurRadius: 12.sp, color: LoopsColors.lightGrey)
                  ],
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.sp),
                    child: Text(
                      widget.textList[index].name!,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: index == _selectedIndex
                            ? LoopsColors.primaryColor
                            : LoopsColors.textColor,
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
    );
  }
}
