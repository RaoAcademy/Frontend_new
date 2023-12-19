import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rao_academy/core/utli/loops_urls.dart';
import 'package:rao_academy/core/widgets/container_with_border.dart';

int _currentPageIndex = 0;
final PageController _pageController = PageController(viewportFraction: 0.2);

class MathTheFollowingImage extends StatefulWidget {
  const MathTheFollowingImage({Key? key}) : super(key: key);

  @override
  State<MathTheFollowingImage> createState() => _MathTheFollowingImageState();
}

class _MathTheFollowingImageState extends State<MathTheFollowingImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 4.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ContainerWithBorder(
                  width: 160.w,
                  height: 24.h,
                  borderRadius: 5.sp,
                  borderColor: LoopsColors.textColor,
                  child: Text(
                    'Match The Following',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 32.h,
                    ),
                    /*  IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.settings_outlined,
            size: 24.sp,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.share,
            size: 20.sp,
          ),
        ) */
                  ],
                )
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            ContainerWithBorder(
              height: 60,
              width: MediaQuery.of(context).size.width,
              child: PageView.builder(
                controller: _pageController,
                itemCount: 10,
                onPageChanged: (pageIndex) {
                  setState(() {
                    _currentPageIndex = pageIndex;
                  });
                },
                itemBuilder: (context, index) {
                  return /* Padding(
                    padding: index == 0
                        ? EdgeInsets.only(
                            left: MediaQuery.of(context).size.width / 2.7)
                        : index == 10 - 1
                            ? EdgeInsets.only(
                                right: MediaQuery.of(context).size.width /
                                    2.7)
                            : EdgeInsets.zero,
                    child:  */
                      InkWell(
                    // key: GlobalObjectKey(index.toString()),
                    onTap: () {
                      setState(() {
                        _currentPageIndex = index;
                        _pageController.animateToPage(
                          _currentPageIndex,
                          curve: Curves.decelerate,
                          duration: const Duration(milliseconds: 300),
                        );
                      });
                      /*  Scrollable.ensureVisible(
                        GlobalObjectKey(index.toString()).currentContext!,
                      ); */
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOutCubic,
                      margin: EdgeInsets.symmetric(
                        horizontal: 5.sp,
                      ),
                      child: ContainerWithBorder(
                        margin: _currentPageIndex == index
                            ? EdgeInsets.zero
                            : EdgeInsets.all(4.sp),
                        /* boxShadow: _currentPageIndex != index
                              ? [
                                  BoxShadow(
                                      blurRadius: 10,
                                      spreadRadius: 0,
                                      color: LoopsColors.colorGrey.withOpacity(0.2),
                                      offset: Offset(5.sp, 5.sp))
                                ]
                              : [], */
                        /* boxColor: _currentPageIndex == index
                              ? LoopsColors.selectedColor.withOpacity(0.5)
                              : LoopsColors.lightGrey.withOpacity(0.01), */
                        width: MediaQuery.of(context).size.width,
                        height: _currentPageIndex == index ? 50.h : 30.h,
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: _currentPageIndex == index
                                ? LoopsColors.colorBlack
                                : LoopsColors.textColor.withOpacity(0.3),
                          ),
                        ),
                      ),
                    ),
                    // ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 80.h,
            ),
            Text.rich(
              TextSpan(
                children: <InlineSpan>[
                  TextSpan(
                    text:
                        'TextField in Flutter is the most commonly used text input?',
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
                        Container(
                          key: Key('$index'),
                          width: MediaQuery.of(context).size.width,
                          /*  constraints: BoxConstraints(
                            minHeight: 44.sp,
                          ), */
                          height: 80.sp,

                          // boxColor: LoopsColors.secondaryColor,

                          margin: EdgeInsets.all(8.sp),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
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
                            });
                          }
                        },
                        children: [
                          for (int index = 0; index < 4; index++)
                            Row(
                              key: Key('$index'),
                              children: [
                                Text(
                                  '${_index2[index]}) ',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: LoopsColors.textColor,
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.8,
                                  /* constraints: BoxConstraints(
                                    minHeight: 44.sp,
                                  ), */
                                  height: 80.sp,
                                  // boxColor: LoopsColors.secondaryColor,

                                  margin: EdgeInsets.all(8.sp),
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(10.sp),
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(
                                          _list2[index],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<String> _index1 = ['1', '2', '3', '4'];
List<String> _index2 = ['A', 'B', 'C', 'D'];
List<String> _list = [
  'This is Lake, This is Lake, This is Lake',
  'Sample Mountain',
  'Lorem ipsum Desert',
  'And comes Forest',
];
List<String> _list2 = [
  'https://picsum.photos/id/${123 + 0}/200/200',
  'https://picsum.photos/id/${123 + 1}/200/200',
  'https://picsum.photos/id/${123 + 2}/200/200',
  'https://picsum.photos/id/${123 + 3}/200/200',
];
