import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:EdTestz/application/test/test_provider.dart';
import 'package:EdTestz/core/utli/loops_urls.dart';
import 'package:EdTestz/core/widgets/container_with_border.dart';
import 'package:EdTestz/core/widgets/rounded_corner_list.dart';

List<String> _strengthKeys = [
  'Concepts',
  'Tests',
  'Chapter',
  'Question Level',
  'Question Format'
];
int _selectedStrengthkey = 0;
List<String>? _strong(int key, BuildContext context) {
  switch (key) {
    case 0:
      return Provider.of<TestProvider>(context, listen: false)
          .analyticsSubject
          .values!
          .conceptsStrong;
    case 1:
      return Provider.of<TestProvider>(context, listen: false)
          .analyticsSubject
          .values!
          .testsStrong;
    case 2:
      return Provider.of<TestProvider>(context, listen: false)
          .analyticsSubject
          .values!
          .chaptersStrong;
    case 3:
      return Provider.of<TestProvider>(context, listen: false)
          .analyticsSubject
          .values!
          .difficultyLevelStrong;
    case 4:
      return Provider.of<TestProvider>(context, listen: false)
          .analyticsSubject
          .values!
          .questionFormatStrong;
    default:
  }
  return null;
}

List<String>? _weak(int key, BuildContext context) {
  switch (key) {
    case 0:
      return Provider.of<TestProvider>(context, listen: false)
          .analyticsSubject
          .values!
          .conceptsWeak;
    case 1:
      return Provider.of<TestProvider>(context, listen: false)
          .analyticsSubject
          .values!
          .testsWeak;
    case 2:
      return Provider.of<TestProvider>(context, listen: false)
          .analyticsSubject
          .values!
          .chaptersWeak;
    case 3:
      return Provider.of<TestProvider>(context, listen: false)
          .analyticsSubject
          .values!
          .difficultyLevelWeak;
    case 4:
      return Provider.of<TestProvider>(context, listen: false)
          .analyticsSubject
          .values!
          .questionFormatWeak;
    default:
  }
  return null;
}

class Strength extends StatelessWidget {
  const Strength({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<TestProvider>(context);
    return ContainerWithBorder(
      borderRadius: 12.sp,
      boxShadow: [BoxShadow(blurRadius: 12.sp, color: LoopsColors.lightGrey)],
      child: Column(
        children: [
          RoundedCornerList(
            textList: _strengthKeys,
            getValue: (value) {
              _selectedStrengthkey = value.keys.first;
              Provider.of<TestProvider>(context, listen: false).setState();
            },
          ),
          if ((_strong(_selectedStrengthkey, context)?.length ?? 0) > 0)
            Row(
              children: [
                Text(
                  'You’re Strong in',
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: LoopsColors.colorBlack,
                  ),
                ),
              ],
            ),
          if ((_strong(_selectedStrengthkey, context)?.length ?? 0) > 0)
            SizedBox(
              height:
                  36.h * (_strong(_selectedStrengthkey, context)?.length ?? 0),
              child: Column(
                children: [
                  for (int i = 0;
                      i < (_strong(_selectedStrengthkey, context)?.length ?? 0);
                      i++)
                    SizedBox(
                      height: 36.h,
                      child: Padding(
                        padding: EdgeInsets.all(4.sp),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.sp),
                              child: ContainerWithBorder(
                                width: 6.sp,
                                height: 6.sp,
                                borderRadius: 12.sp,
                                boxColor: LoopsColors.textColor,
                              ),
                            ),
                            Text(
                              _strong(_selectedStrengthkey, context)?[i] ?? '',
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                                color: LoopsColors.colorBlack,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          if ((_weak(_selectedStrengthkey, context)?.length ?? 0) > 0)
            Row(
              children: [
                Text(
                  'You’re Weak in',
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: LoopsColors.colorBlack,
                  ),
                ),
              ],
            ),
          if ((_weak(_selectedStrengthkey, context)?.length ?? 0) > 0)
            SizedBox(
              height:
                  36.h * (_weak(_selectedStrengthkey, context)?.length ?? 0),
              child: Column(
                children: [
                  for (int i = 0;
                      i < (_weak(_selectedStrengthkey, context)?.length ?? 0);
                      i++)
                    SizedBox(
                      height: 36.h,
                      child: Padding(
                        padding: EdgeInsets.all(4.sp),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.sp),
                              child: ContainerWithBorder(
                                width: 6.sp,
                                height: 6.sp,
                                borderRadius: 12.sp,
                                boxColor: LoopsColors.textColor,
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 1.2,
                              child: Text(
                                _weak(_selectedStrengthkey, context)?[i] ?? '',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500,
                                  color: LoopsColors.colorBlack,
                                  overflow: TextOverflow.ellipsis
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
