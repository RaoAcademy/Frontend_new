import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:rao_academy/application/home/home_provider.dart';
import 'package:rao_academy/application/test/test_provider.dart';
import 'package:rao_academy/core/theme/custom_scroll_behaviour.dart';
import 'package:rao_academy/core/utli/goto_pages.dart';
import 'package:rao_academy/core/utli/loops_urls.dart';
import 'package:rao_academy/core/widgets/container_with_border.dart';
import 'package:rao_academy/core/widgets/custom_text_field.dart';
import 'package:rao_academy/domain/entities/recommendations_entity.dart';
import 'package:rao_academy/domain/entities/subjects_entity.dart';

import '../../../other/widgets/cached_network_image.dart';

int showTargetWarning = 0;
GlobalKey<ExpandableBottomSheetState> key = new GlobalKey();
 showPopup01(BuildContext context, List<Subjects> subjectList,
    TestProvider provider, num testId,String imagePath) {
    key.currentState?.contract();
    provider.loopTarget = null;
  showModalBottomSheet(context: context, builder: (context) {
    return SingleChildScrollView(
      child: Consumer<HomeProvider>(builder: (context, homeProvider, child) {
        return Container(
          height: homeProvider.isBottomOpen ? MediaQuery.of(context).size.height / 0.4 : MediaQuery.of(context).size.height / 2.65,
          child: ExpandableBottomSheet(
              key: key,
              expandableContent: const SizedBox.shrink(),
              persistentFooter: const SizedBox.shrink(),
              background: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.all(12.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ContainerWithBorder(
                            boxColor: LoopsColors.colorPink2,
                            borderRadius: 100.sp,
                            height: 65.sp,
                            width: 65.sp,
                            child: Center(
                              child: LoopsImage(
                                height: 65.h,
                                width: 65.w,
                                path: imagePath,
                              ),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 260.w,
                              child: Text(
                                provider.loopsBottomSheetEntity.name ?? '',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 2,
                              ),
                            ),
                            SizedBox(
                              height: 6.h,
                            ),
                            Text(
                              'Prepared by : ${provider.loopsBottomSheetEntity.preparedBy}',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: LoopsColors.textColor.withOpacity(0.5),
                              ),
                            ),
                            SizedBox(
                              height: 6.h,
                            ),
                            SizedBox(
                              height: 30.h,
                              width: 260.w,
                              child: ScrollConfiguration(
                                behavior: MyBehavior(),
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: provider
                                      .loopsBottomSheetEntity.tags !=
                                      null
                                      ? provider.loopsBottomSheetEntity.tags!
                                      .split(',')
                                      .length
                                      : 0,
                                  itemBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8.w, vertical: 2.h),
                                      decoration: BoxDecoration(
                                        color: LoopsColors.colorBlue3
                                            .withOpacity(0.2),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(4.sp),
                                        ),
                                        // border: Border.all(
                                        //   color: _chapterColor[index].withOpacity(0.2),
                                        // ),
                                      ),
                                      height: 20.h,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 4.h,
                                          ),
                                          Text(
                                            provider
                                                .loopsBottomSheetEntity.tags!
                                                .split(',')[index],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: LoopsColors.colorBlue3,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        /* IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.share_outlined,
                                    color: LoopsColors.textColor.withOpacity(0.5),
                                    size: 24.sp,
                                  )) */
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.sp,
                    ),
                    child: Text(
                      provider.loopsBottomSheetEntity.description!,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.sp,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  // if (showTargetWarning == 1)

                  SizedBox(
                    height: 5.h,
                  ),
                  /* Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 72.sp, vertical: 8.sp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ContainerWithBorder(
                                boxColor: LoopsColors.selectedColor,
                                width: 70.w,
                                height: 22.h,
                                borderRadius: 12.sp,
                                child: Text(
                                  'Marks',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: LoopsColors.primaryColor,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 24.w,
                              ),
                              ContainerWithBorder(
                                boxColor: LoopsColors.selectedColor,
                                width: 74.w,
                                height: 22.h,
                                borderRadius: 12.sp,
                                child: Text(
                                  'Questions',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: LoopsColors.primaryColor,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ), */
                  // Expanded(child: Container()),
                  Container(
                    height: 48.h,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          LoopsColors.primaryColor,
                          LoopsColors.primaryColor,
                          LoopsColors.primaryColor,
                          LoopsColors.colorPink,
                        ],
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          height: 24.h,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 2.h,
                              ),
                            ),
                            SvgPicture.asset(
                              'assets/icons/tests_page/target.svg',
                              height: 24.sp,
                              width: 24.sp,
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 2.h,
                              ),
                            ),
                            Text(
                              'Target',
                              style: TextStyle(
                                fontSize: 8.sp,
                                fontWeight: FontWeight.w600,
                                color: LoopsColors.colorWhite,
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 2.h,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        Container(
                          // height: 22.h,
                          width: 60.w,
                          decoration: BoxDecoration(
                            color: LoopsColors.selectedColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(4.sp),
                            ),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: CustomTextField(
                                    inputType: TextInputType.number,
                                    onTap:  () {
                                      homeProvider.changeBottomSheet(true);
                                    },
                                    onChanged: (p0) {

                                      if(p0.isNotEmpty){
                                        if ((int.parse(p0) <= 0) || (int.parse(p0) > 100)) {
                                          showTargetWarning = 1;
                                          provider.loopTarget = null;
                                          if (kDebugMode) {
                                            print(showTargetWarning);
                                          }
                                          provider.setState();
                                        } else {

                                          showTargetWarning = 0;
                                          provider.loopTarget = int.parse(p0);
                                        }
                                      }else{
                                        showTargetWarning = 1;
                                        provider.loopTarget = null;
                                      }
                                    },
                                    onFieldSubmitted: (p0) {
                                    homeProvider.changeBottomSheet(false);
                                  },

                                    smallSize: true,
                                    hintText: provider
                                        .loopsBottomSheetEntity.target
                                        ?.toString() ??
                                        '0',
                                  ),
                                ),
                                Text(
                                  ' %',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: LoopsColors.colorBlue2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        InkWell(
                          onTap: () {
                            if (kDebugMode) {
                              print("TEST_DEBUG-X");
                              print(showTargetWarning);
                              // print(testId);
                              print(provider.loopsBottomSheetEntity.name);

                              print(provider.loopsBottomSheetEntity.userTestId);
                            }
                            if (kDebugMode) {
                              print("CHECK");
                              print(showTargetWarning);
                              print(provider.loopTarget);
                            }
                            if ((showTargetWarning != 1) &&
                                (provider.loopTarget != null)) {
                              if (kDebugMode) {
                                print("PROVIDER");
                                print(showTargetWarning);
                              }
                              gotoStartTest(
                                  context,
                                  TestEntity(
                                    testId: testId,
                                    // userTestId: provider
                                    //     .loopsBottomSheetEntity.userTestId,
                                  ),
                                  fromCustomTest: false,
                                  practiceId: null);
                            } else {
                              if (kDebugMode) {
                                print(showTargetWarning);
                              }
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16))),
                                    title: Text("Target Warning!",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 18)),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                            "Set a Target 1 to 100 achieve from this chapter",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 16),
                                            textAlign: TextAlign.center),
                                        SizedBox(
                                          height: 14,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF0F6FFF),
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      16)),
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 22,
                                                    vertical: 10),
                                                child: Text(
                                                  "Ok",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              )),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              );
                            }

                            // Navigator.pop(context);
                          },
                          child: Container(
                            height: 26.h,
                            width: 61.w,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  LoopsColors.primaryColor,
                                  LoopsColors.colorPink,
                                ],
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(12.sp),
                              ),
                              border: Border.all(
                                width: 1.sp,
                                color: LoopsColors.colorWhite,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Start',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: LoopsColors.colorWhite,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                ],
              )),
        );
      },),
    );
  },);
}

 Future showPopup02(BuildContext context, List<Subjects> subjectList,
    TestProvider provider, num testId,String imagePath) {
  return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      // isScrollControlled: true,
      builder: (context) {
        return SafeArea(
          child: Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            // borderRadius: 12.sp,
            color: LoopsColors.colorWhite,
            width: MediaQuery.of(context).size.width,
            // height: 250.h,
            child: Material(
              color: Colors.transparent,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.all(12.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ContainerWithBorder(
                            boxColor: LoopsColors.colorPink2,
                            borderRadius: 100.sp,
                            height: 65.sp,
                            width: 65.sp,
                            child: Center(
                              child: LoopsImage(
                                height: 65.h,
                                width: 65.w,
                                path: imagePath,
                              ),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 260.w,
                              child: Text(
                                provider.loopsBottomSheetEntity.name!,
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 6.h,
                            ),
                            Text(
                              'Prepared by : ${provider.loopsBottomSheetEntity.preparedBy}',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: LoopsColors.textColor.withOpacity(0.5),
                              ),
                            ),
                            SizedBox(
                              height: 6.h,
                            ),
                            SizedBox(
                              height: 30.h,
                              width: 260.w,
                              child: ScrollConfiguration(
                                behavior: MyBehavior(),
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: provider
                                      .loopsBottomSheetEntity.tags!
                                      .split(',')
                                      .length,
                                  itemBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8.w, vertical: 2.h),
                                      decoration: BoxDecoration(
                                        color: LoopsColors.colorBlue3
                                            .withOpacity(0.2),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(4.sp),
                                        ),
                                        // border: Border.all(
                                        //   color: _chapterColor[index].withOpacity(0.2),
                                        // ),
                                      ),
                                      height: 20.h,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 4.h,
                                          ),
                                          Text(
                                            provider
                                                .loopsBottomSheetEntity.tags!
                                                .split(',')[index],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: LoopsColors.colorBlue3,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        /* IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.share_outlined,
                              color: LoopsColors.textColor.withOpacity(0.5),
                              size: 24.sp,
                            )) */
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.sp,
                    ),
                    child: Text(
                      provider.loopsBottomSheetEntity.description!,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.sp,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  /* Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 72.sp, vertical: 8.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ContainerWithBorder(
                          boxColor: LoopsColors.selectedColor,
                          width: 70.w,
                          height: 22.h,
                          borderRadius: 12.sp,
                          child: Text(
                            'Marks',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: LoopsColors.primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 24.w,
                        ),
                        ContainerWithBorder(
                          boxColor: LoopsColors.selectedColor,
                          width: 74.w,
                          height: 22.h,
                          borderRadius: 12.sp,
                          child: Text(
                            'Questions',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: LoopsColors.primaryColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ), */
                  SizedBox(
                    height: 24.h,
                  ),
                  Container(
                    height: 48.h,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          LoopsColors.primaryColor,
                          LoopsColors.primaryColor,
                          LoopsColors.primaryColor,
                          LoopsColors.colorPink,
                        ],
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          height: 24.h,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 2.h,
                              ),
                            ),
                            SvgPicture.asset(
                              'assets/icons/tests_page/target.svg',
                              height: 24.sp,
                              width: 24.sp,
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 2.h,
                              ),
                            ),
                            Text(
                              'Target',
                              style: TextStyle(
                                fontSize: 6.sp,
                                fontWeight: FontWeight.w600,
                                color: LoopsColors.colorWhite,
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 2.h,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        Container(
                          // height: 22.h,
                          width: 60.w,
                          decoration: BoxDecoration(
                            color: LoopsColors.selectedColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(4.sp),
                            ),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: CustomTextField(
                                    readOnly: true,
                                    // onChanged: (p0) =>
                                    //     provider.loopTarget = int.parse(p0),
                                    smallSize: true,
                                    hintText: provider
                                            .loopsBottomSheetEntity.target
                                            ?.toString() ??
                                        '0',
                                  ),
                                ),
                                Text(
                                  ' %',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: LoopsColors.colorBlue2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 2.h,
                              ),
                            ),
                            SvgPicture.asset(
                              'assets/icons/tests_page/achived.svg',
                              height: 24.sp,
                              width: 24.sp,
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 2.h,
                              ),
                            ),
                            Text(
                              'Achived',
                              style: TextStyle(
                                fontSize: 8.sp,
                                fontWeight: FontWeight.w600,
                                color: LoopsColors.colorWhite,
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 2.h,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        Container(
                          height: 22.h,
                          width: 46.w,
                          decoration: BoxDecoration(
                            color: LoopsColors.selectedColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(4.sp),
                            ),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  provider.loopsBottomSheetEntity.achieved
                                          ?.toStringAsFixed(2) ??
                                      '',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600,
                                    color: LoopsColors.colorBlue2,
                                  ),
                                ),
                                Text(
                                  ' %',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: LoopsColors.colorBlue2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        InkWell(
                          onTap: () {
                            if (kDebugMode) {
                              print("RESUME_TEST_1");
                              // print(provider.loopsBottomSheetEntity.id);
                            }
                            gotoStartTest(
                                context,
                                TestEntity(
                                  // testId: provider.loopsBottomSheetEntity.id,
                                  testId: testId,
                                  userTestId: provider
                                      .loopsBottomSheetEntity.userTestId,
                                ),
                                fromCustomTest: false,
                                practiceId: null);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 2.h,
                                ),
                              ),
                              SvgPicture.asset(
                                'assets/icons/tests_page/resume.svg',
                                height: 24.sp,
                                width: 24.sp,
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: 2.h,
                                ),
                              ),
                              Text(
                                'Resume',
                                style: TextStyle(
                                  fontSize: 8.sp,
                                  fontWeight: FontWeight.w600,
                                  color: LoopsColors.colorWhite,
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: 2.h,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                ],
              ),
            ),
            // ),
          ),
        );
      });
}

Future showPopup03(
    BuildContext context, List<Subjects> subjectList, TestProvider provider,String imagePath) {
  return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return SafeArea(
          child: Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            // borderRadius: 12.sp,
            color: LoopsColors.colorWhite,
            width: MediaQuery.of(context).size.width,
            // height: 250.h,
            child: Material(
              color: Colors.transparent,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.all(12.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ContainerWithBorder(
                            boxColor: LoopsColors.colorPink2,
                            borderRadius: 100.sp,
                            height: 65.sp,
                            width: 65.sp,
                            child: Center(
                              child: LoopsImage(
                                height: 65.h,
                                width: 65.w,
                                path: imagePath,
                              ),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 260.w,
                              child: Text(
                                provider.loopsBottomSheetEntity.name ?? '',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 6.h,
                            ),
                            Text(
                              'Prepared by : ${provider.loopsBottomSheetEntity.preparedBy ?? 'Experts'}',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: LoopsColors.textColor.withOpacity(0.5),
                              ),
                            ),
                            SizedBox(
                              height: 6.h,
                            ),
                            SizedBox(
                              height: 30.h,
                              width: 260.w,
                              child: ScrollConfiguration(
                                behavior: MyBehavior(),
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 3,
                                  itemBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8.w, vertical: 2.h),
                                      decoration: BoxDecoration(
                                        color: LoopsColors.colorBlue3
                                            .withOpacity(0.2),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(4.sp),
                                        ),
                                        // border: Border.all(
                                        //   color: _chapterColor[index].withOpacity(0.2),
                                        // ),
                                      ),
                                      height: 20.h,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 4.h,
                                          ),
                                          Text(
                                            subjectList[index].name!,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: LoopsColors.colorBlue3,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        /* IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.share_outlined,
                              color: LoopsColors.textColor.withOpacity(0.5),
                              size: 24.sp,
                            )) */
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.sp,
                    ),
                    child: Text(
                      provider.loopsBottomSheetEntity.description ?? '',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.sp,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  /*  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 72.sp, vertical: 8.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ContainerWithBorder(
                          boxColor: LoopsColors.selectedColor,
                          width: 70.w,
                          height: 22.h,
                          borderRadius: 12.sp,
                          child: Text(
                            'Marks',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: LoopsColors.primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 24.w,
                        ),
                        ContainerWithBorder(
                          boxColor: LoopsColors.selectedColor,
                          width: 74.w,
                          height: 22.h,
                          borderRadius: 12.sp,
                          child: Text(
                            'Questions',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: LoopsColors.primaryColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ), */
                  SizedBox(
                    height: 24.h,
                  ),
                  Container(
                    height: 48.h,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          LoopsColors.primaryColor,
                          LoopsColors.primaryColor,
                          LoopsColors.primaryColor,
                          LoopsColors.colorPink,
                        ],
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 24.h,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 2.h,
                              ),
                            ),
                            SvgPicture.asset(
                              'assets/icons/tests_page/target.svg',
                              height: 24.sp,
                              width: 24.sp,
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 2.h,
                              ),
                            ),
                            Text(
                              'Target',
                              style: TextStyle(
                                fontSize: 8.sp,
                                fontWeight: FontWeight.w600,
                                color: LoopsColors.colorWhite,
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 2.h,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        Container(
                          height: 22.h,
                          width: 46.w,
                          decoration: BoxDecoration(
                            color: LoopsColors.selectedColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(4.sp),
                            ),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: CustomTextField(
                                    onChanged: (p0) =>
                                        provider.loopTarget = int.parse(p0),
                                    smallSize: true,
                                    hintText: provider
                                            .loopsBottomSheetEntity.target
                                            ?.toString() ??
                                        '0',
                                  ),
                                ),
                                Text(
                                  ' %',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: LoopsColors.colorBlue2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 2.h,
                              ),
                            ),
                            SvgPicture.asset(
                              'assets/icons/tests_page/achived.svg',
                              height: 24.sp,
                              width: 24.sp,
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 2.h,
                              ),
                            ),
                            Text(
                              'Achived',
                              style: TextStyle(
                                fontSize: 8.sp,
                                fontWeight: FontWeight.w600,
                                color: LoopsColors.colorWhite,
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 2.h,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        Container(
                          height: 23.h,
                          width: 47.w,
                          decoration: BoxDecoration(
                            color: LoopsColors.selectedColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(4.sp),
                            ),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  provider.loopsBottomSheetEntity.achieved
                                          ?.toString() ??
                                      '',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: LoopsColors.colorBlue2,
                                  ),
                                ),
                                Text(
                                  ' %',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: LoopsColors.colorBlue2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        if (provider.loopsBottomSheetEntity.results!)
                          InkWell(
                            onTap: () {
                              // Note: Check after these value is correct.
                              // int id_get_from_provider =
                              //     (provider.loopsBottomSheetEntity.id)!.toInt();

                              gotoSprintHistory(
                                  context,
                                  // (provider
                                  //         .loopsHomeEntity
                                  //         .loops?[id_get_from_provider]
                                  //         .chapterId)!
                                  //     .toInt(),
                                  (provider.loopsBottomSheetEntity.userTestId)!
                                      .toInt(),
                                  provider.testEntity.text1 ?? "");
                              // (provider.testEntity.testId)!.toInt());

                              // gotoSprintHistory(
                              //     context,
                              //     provider.loopsHomeEntity
                              //         .loops?[id_get_from_provider]);
                              //         .chapterId)!
                              //         .toInt())

                              // gotoSprintHistory(context, provider.chapterId);
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 2.h,
                                  ),
                                ),
                                SvgPicture.asset(
                                  'assets/icons/tests_page/results.svg',
                                  height: 24.sp,
                                  width: 24.sp,
                                ),
                                Expanded(
                                  child: SizedBox(
                                    height: 2.h,
                                  ),
                                ),
                                Text(
                                  'Results',
                                  style: TextStyle(
                                    fontSize: 8.sp,
                                    fontWeight: FontWeight.w600,
                                    color: LoopsColors.colorWhite,
                                  ),
                                ),
                                Expanded(
                                  child: SizedBox(
                                    height: 2.h,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        SizedBox(
                          width: 20.w,
                        ),
                        if (provider.loopsBottomSheetEntity.results!)
                          InkWell(
                            onTap: () {
                              if (kDebugMode) {
                                print("RESUME_TEST");
                                print(provider.loopsBottomSheetEntity.id);
                              }

                              Navigator.pop(context, true);

                              // gotoStartTest(
                              //     context,
                              //     TestEntity(
                              //       testId: provider.loopsBottomSheetEntity.id,
                              //       userTestId: provider
                              //           .loopsBottomSheetEntity.userTestId,
                              //     ),
                              //     fromCustomTest: false);
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 2.h,
                                  ),
                                ),
                                Icon(
                                  Icons.loop_rounded,
                                  color: LoopsColors.iconColor2,
                                  size: 24.sp,
                                ),
                                Expanded(
                                  child: SizedBox(
                                    height: 2.h,
                                  ),
                                ),
                                Text(
                                  'Retake',
                                  style: TextStyle(
                                    fontSize: 8.sp,
                                    fontWeight: FontWeight.w600,
                                    color: LoopsColors.colorWhite,
                                  ),
                                ),
                                Expanded(
                                  child: SizedBox(
                                    height: 2.h,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        SizedBox(
                          height: 24.h,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                ],
              ),
            ),
            // ),
          ),
        );
      });
}
