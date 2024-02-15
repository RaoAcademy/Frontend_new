import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:EdTestz/core/utli/loops_urls.dart';
import 'package:EdTestz/core/widgets/container_with_border.dart';

class BehaviourBox extends StatefulWidget {
  const BehaviourBox({
    Key? key,
    required this.title,
    required this.color,
    required this.dataList,
  }) : super(key: key);
  final String title;
  final Color color;
  final List<String> dataList;

  @override
  State<BehaviourBox> createState() => _BehaviourBoxState();
}

int _selectedIndex = 0;

class _BehaviourBoxState extends State<BehaviourBox> {
  @override
  void initState() {
    _selectedIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ContainerWithBorder(
      padding: EdgeInsets.all(8.sp),
      boxShadow: [
        BoxShadow(
            blurRadius: 10,
            color: LoopsColors.lightGrey.withOpacity(0.4),
            offset: Offset(5.sp, 5.sp))
      ],
      height: 164.h,
      borderRadius: 12.sp,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.03.sp,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 12.h,
          ),
          Row(
            children: [
              SizedBox(
                height: 42.h,
                width: MediaQuery.of(context).size.width / 1.2,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.dataList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            _selectedIndex = index;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            if (_selectedIndex == index)
                              SizedBox(
                                height: 16.h,
                              ),
                            ContainerWithBorder(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 10,
                                    color: LoopsColors.lightGrey.withOpacity(1),
                                    offset: Offset(5.sp, 5.sp))
                              ],
                              borderRadius: 4.sp,
                              margin: EdgeInsets.symmetric(
                                horizontal: 8.w,
                              ),
                              height: 25.h,
                              freeWidth: true,
                              boxColor: widget.color.withOpacity(0.3),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.circle,
                                    size: 6.sp,
                                    color: widget.color,
                                  ),
                                  SizedBox(
                                    width: 8.sp,
                                  ),
                                  Text(
                                    widget.dataList[index],
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      color: widget.color,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (_selectedIndex != index)
                              SizedBox(
                                height: 6.h,
                              ),
                          ],
                        ),
                      );
                    }),
              ),
            ],
          ),
          ContainerWithBorder(
            borderRadius: 4.sp,
            height: 55.h,
            boxColor: widget.color.withOpacity(0.3),
            child: Row(
              children: [
                Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.dataList[_selectedIndex] +
                            widget.dataList[_selectedIndex] +
                            widget.dataList[_selectedIndex] +
                            widget.dataList[_selectedIndex] +
                            widget.dataList[_selectedIndex] +
                            widget.dataList[_selectedIndex],
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: widget.color,
                        ),
                        maxLines: 5,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
