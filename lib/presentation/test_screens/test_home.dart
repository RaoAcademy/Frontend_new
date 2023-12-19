import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rao_academy/application/home/home_provider.dart';
import 'package:rao_academy/application/other/other_provider.dart';
import 'package:rao_academy/application/test/test_provider.dart';
import 'package:rao_academy/core/theme/custom_scroll_behaviour.dart';
import 'package:rao_academy/core/utli/error_handle.dart';
import 'package:rao_academy/core/utli/goto_pages.dart';
import 'package:rao_academy/core/utli/loops_urls.dart';
import 'package:rao_academy/core/widgets/box_corner_list.dart';
import 'package:rao_academy/core/widgets/container_with_border.dart';
import 'package:rao_academy/presentation/core/bottom_bar.dart';
import 'package:rao_academy/presentation/core/drawer.dart';
import 'package:rao_academy/presentation/core/test_card.dart';
import 'package:rao_academy/presentation/home/homescreen.dart';
import 'package:rao_academy/presentation/other/widgets/cached_network_image.dart';

class TestHome extends StatefulWidget {
  const TestHome({Key? key}) : super(key: key);

  @override
  State<TestHome> createState() => _TestHomeState();
}

class _TestHomeState extends State<TestHome> {
  @override
  void initState() {
    super.initState();
    context.read<TestProvider>().subjectId = int.parse(Provider.of<HomeProvider>(context,listen: false).homeEntity.defaultSubjectId.toString());
    Provider.of<TestProvider>(context, listen: false)
        .ftestHome();
 
  }


  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TestProvider>(context);
    context.watch<OtherProvider>();
    context.read<OtherProvider>().currentTab = 1;
    int presscount = 0;
    return WillPopScope(
      onWillPop: () async {
        presscount++;

        if (presscount == 2) {
          exit(0);
        } else {
          const snackBar = SnackBar(
            content: Text('Press again to exit'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          return false;
        }
      },
      child: Scaffold(
        key: scaffoldKey02,
        bottomNavigationBar: bottomNavigationBar(context),
        drawer: const DrawerWidget(),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: LoopsColors.primaryColor,
          title: Text(
            'Tests',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: LoopsColors.colorWhite,
            ),
          ),
          /* actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  size: 24.sp,
                ))
          ], */
        ),
        body: ContainerWithBorder(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(12.sp),
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h),
                child: SizedBox(
                  height: 32.h,
                  child: ScrollConfiguration(
                    behavior: MyBehavior(),
                    child: BoxCornerList(
                        selectedIndex:
                        provider.testHomeEntity.subjects!.indexOf(
                          provider.testHomeEntity.subjects!.firstWhere(
                                (element) =>
                            element.id ==
                                context
                                    .read<HomeProvider>()
                                    .homeEntity
                                    .defaultSubjectId,
                          ),
                        ),
                        textList:
                        Provider.of<TestProvider>(context, listen: false)
                            .testHomeEntity
                            .subjects!,
                        getValue: (value) {
                          provider.subjectId = provider.testHomeEntity.subjects!
                              .firstWhere((element) =>
                          element.name == value[value.keys.first])
                              .id!
                              .toInt();
                          Provider.of<TestProvider>(context, listen: false)
                              .ftestHome()
                              .onError((error, stackTrace) async {
                            await handleError(error);
                          });
                        }),

                    /*  ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        ContainerWithBorder(
                          borderRadius: 4.sp,
                          boxColor: LoopsColors.selectedColor,
                          width: 78.w,
                          height: 24.h,
                          child: Text(
                            'Physics',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: LoopsColors.primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8.h,
                        ),
                        ContainerWithBorder(
                          borderRadius: 4.sp,
                          boxColor: LoopsColors.colorWhite,
                          borderColor: LoopsColors.textColor.withOpacity(0.5),
                          width: 78.w,
                          height: 24.h,
                          child: Text(
                            'Chemistry',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: LoopsColors.textColor.withOpacity(0.8),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8.h,
                        ),
                        ContainerWithBorder(
                          borderRadius: 4.sp,
                          boxColor: LoopsColors.colorWhite,
                          borderColor: LoopsColors.textColor.withOpacity(0.5),
                          width: 78.w,
                          height: 24.h,
                          child: Text(
                            'Biology',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: LoopsColors.textColor.withOpacity(0.8),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8.h,
                        ),
                        ContainerWithBorder(
                          borderRadius: 4.sp,
                          boxColor: LoopsColors.colorWhite,
                          borderColor: LoopsColors.textColor.withOpacity(0.5),
                          width: 78.w,
                          height: 24.h,
                          child: Text(
                            'Maths',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: LoopsColors.textColor.withOpacity(0.8),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8.h,
                        ),
                      ],
                    ), */
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              /* Text(
                'Tests',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ), */
              SizedBox(
                height: 120.h,
                child: ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: Provider.of<TestProvider>(context, listen: false)
                        .testHomeEntity
                        .testCategories
                        ?.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          switch (
                          Provider.of<TestProvider>(context, listen: false)
                              .testHomeEntity
                              .testCategories?[index]
                              .name) {
                            case 'Concept Based':
                              gotoAllChapters(context);
                              break;
                            case 'Custom Tests':
                              gotoCustomTest(
                                context,
                                Provider.of<TestProvider>(context,
                                    listen: false)
                                    .testHomeEntity
                                    .testCategories![index]
                                    .id!
                                    .toInt(),
                              );
                              break;
                            default:
                              gotoAllChapters(context); //TODO: gotoOtherTest
                          }
                        },
                        child: LoopsImage(
                          path:
                          Provider.of<TestProvider>(context, listen: false)
                              .testHomeEntity
                              .testCategories![index]
                              .imagePath!,
                          fit: BoxFit.fill,
                        ),
                        /* ContainerWithBorder(
                          borderRadius: 10.sp,
                          height: 100.h,
                          width: 206.w,
                          boxColor: LoopsColors.tertiaryColor,
                          margin: EdgeInsets.all(8.sp),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4,
                              color: LoopsColors.colorGrey.withOpacity(0.8),
                              offset: Offset(0.sp, 5.sp),
                            )
                          ],
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 18.w),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(),
                                    Text(
                                      Provider.of<TestProvider>(context,
                                              listen: false)
                                          .testHomeEntity
                                          .testCategories![index]
                                          .caption!,
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: LoopsColors.colorRed,
                                      ),
                                    ),
                                    Text(
                                      Provider.of<TestProvider>(context,
                                              listen: false)
                                          .testHomeEntity
                                          .testCategories![index]
                                          .name!,
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                        color: LoopsColors.textColor,
                                      ),
                                    ),
                                    Container(),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 80.w,
                                child: Center(
                                  child: SizedBox(
                                    height: 60.h,
                                    child: LoopsImage(
                                      path: Provider.of<TestProvider>(context,
                                              listen: false)
                                          .testHomeEntity
                                          .testCategories![index]
                                          .imagePath!,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ), */
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              if (Provider.of<TestProvider>(context, listen: false)
                  .testHomeEntity
                  .recent !=
                  null &&
                  Provider.of<TestProvider>(context, listen: false)
                      .testHomeEntity
                      .recent!
                      .isNotEmpty)
                Text(
                  'Recent tests',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              if (Provider.of<TestProvider>(context, listen: false)
                  .testHomeEntity
                  .recent !=
                  null &&
                  Provider.of<TestProvider>(context, listen: false)
                      .testHomeEntity
                      .recent!
                      .isNotEmpty)
                ContainerWithBorder(
                  height: 160.h,
                  padding: EdgeInsets.only(
                    top: 12.h,
                  ),
                  child: ScrollConfiguration(
                    behavior: MyBehavior(),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:
                      Provider.of<TestProvider>(context, listen: false)
                          .testHomeEntity
                          .recent
                          ?.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            gotoTestInstructions(
                              testType: "",
                              context,
                              testEntity:
                              provider.testHomeEntity.recent![index],
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.all(8.sp),
                            child: TestCard01(
                              testEntity:
                              provider.testHomeEntity.recent![index],
                              repeat: () {
                                context.read<TestProvider>().testStart.resumeQuesId = null;
                                if(Provider.of<TestProvider>(context,
                                    listen: false)
                                    .testHomeEntity
                                    .recent![index].leftTop == "Practice" ){
                                  Provider.of<TestProvider>(context,
                                      listen: false)
                                      .testHomeEntity
                                      .recent![index].testId = null;
                                }else{
                                  Provider.of<TestProvider>(context,
                                      listen: false)
                                      .testHomeEntity
                                      .recent![index].userTestId = null;
                                }

                                gotoTestInstructions(
                                  testType: "",

                                  context,
                                  testEntity: Provider.of<TestProvider>(context,
                                      listen: false)
                                      .testHomeEntity
                                      .recent![index],
                                );
                              },
                              results: () {
                                if (Provider.of<TestProvider>(context,
                                    listen: false)
                                    .testHomeEntity
                                    .recent?[index]
                                    .text3
                                    ?.toUpperCase() ==
                                    'FINISHED') {
                                  gotoResults(
                                      context,
                                      Provider.of<TestProvider>(context,
                                          listen: false)
                                          .testHomeEntity
                                          .recent?[index]
                                          .userTestId
                                          ?.toInt(),
                                      3);
                                }
                              },
                              resume: () {
                                context.read<TestProvider>().testStart.resumeQuesId = 1;
                                if (Provider.of<TestProvider>(context,
                                    listen: false)
                                    .testHomeEntity
                                    .recent?[index]
                                    .text3
                                    ?.toUpperCase() ==
                                    'ONGOING') {
                                  gotoTestInstructions(                              testType: "",

                                    isPrecticeTest:Provider.of<TestProvider>(context,
                                        listen: false)
                                        .testHomeEntity
                                        .recent?[index].leftTop == "Practice" ? true : false,
                                    context,
                                    testEntity: Provider.of<TestProvider>(
                                        context,
                                        listen: false)
                                        .testHomeEntity
                                        .recent![index],

                                  );
                                }
                              },
                            ),
                          ),
                        );
                        /* Padding(
                          padding: EdgeInsets.only(
                              bottom: 14.h, right: 20.w, top: 4.h, left: 4.w),
                          child: Stack(
                            children: [
                              ContainerWithBorder(
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 10,
                                      color:
                                          LoopsColors.colorGrey.withOpacity(0.8),
                                      offset: Offset(5.sp, 5.sp))
                                ],
                                height: 200.h,
                                width: 261.w,
                                borderRadius: 12.sp,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        SizedBox(
                                          height: 25.h,
                                        ),
                                        SvgPicture.asset(
                                            'assets/images/home/chemicals.svg'),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Refraction',
                                          style: appTheme.textTheme.bodyLarge!
                                              .copyWith(
                                                  fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          'Light',
                                          style: appTheme.textTheme.bodyLarge!
                                              .copyWith(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w600,
                                            color: LoopsColors.colorGrey,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 77.w,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Physics',
                                                style: appTheme
                                                    .textTheme.bodyLarge!
                                                    .copyWith(
                                                  fontSize: 10.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: LoopsColors.colorGrey,
                                                ),
                                              ),
                                              SvgPicture.asset(
                                                'assets/icons/logos/line.svg',
                                                height: 10.5.h,
                                                width: 4.sp,
                                                color: LoopsColors.secondaryColor,
                                              ),
                                              Text(
                                                'NCERT',
                                                style: appTheme
                                                    .textTheme.bodyLarge!
                                                    .copyWith(
                                                  fontSize: 10.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: LoopsColors.colorGrey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        Text(
                                          '30% completed',
                                          style: appTheme.textTheme.bodyLarge!
                                              .copyWith(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w600,
                                            color: LoopsColors.colorGrey,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 2.sp,
                                          width: 71.w,
                                          child: LinearProgressIndicator(
                                            value: 0.3,
                                            backgroundColor: LoopsColors.colorGrey
                                                .withOpacity(0.4),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Positioned(
                                child: ContainerWithBorder(
                                  height: 17.h,
                                  width: 56.w,
                                  borderRadius: 12.sp,
                                  boxColor: LoopsColors.secondaryColor,
                                  borderR: BorderRadius.only(
                                    topLeft: Radius.circular(12.sp),
                                    bottomRight: Radius.circular(12.sp),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Practice',
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w600,
                                        color: LoopsColors.tertiaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ); */
                      },
                    ),
                  ),
                ),
              SizedBox(
                height: 24.h,
              ),
              if (Provider.of<TestProvider>(context, listen: false)
                  .testHomeEntity
                  .recommendations !=
                  null &&
                  Provider.of<TestProvider>(context, listen: false)
                      .testHomeEntity
                      .recommendations!
                      .isNotEmpty)
                Text(
                  'Recommendations',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              if (Provider.of<TestProvider>(context, listen: false)
                  .testHomeEntity
                  .recommendations !=
                  null &&
                  Provider.of<TestProvider>(context, listen: false)
                      .testHomeEntity
                      .recommendations!
                      .isNotEmpty)
                ContainerWithBorder(
                  height: 160.h,
                  padding: EdgeInsets.all(4.w),
                  child: ScrollConfiguration(
                    behavior: MyBehavior(),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:
                      Provider.of<TestProvider>(context, listen: false)
                          .testHomeEntity
                          .recommendations
                          ?.length,
                      itemBuilder: (context, index) {

                        return InkWell(
                          onTap: () {
                            provider.currentQuestionPageIndex = 0;
                            Provider.of<TestProvider>(context,
                                listen: false).testStart.resumeQuesId = null;
                            if(provider.testHomeEntity.recommendations?[index].leftTop == "Practice"){
                              provider.practice = true;
                            }else{
                            provider.practice = false;
                            }
                            gotoTestInstructions(
                                                            testType: provider.practice ?? false ?  "Practice" : "",

                              context,
                              testEntity: Provider.of<TestProvider>(context,
                                  listen: false)
                                  .testHomeEntity.recommendations![index],
                            ).onError((error, stackTrace) async {
                              await handleError(error);
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.all(8.sp),
                            child: TestCard01(
                              testEntity: provider
                                  .testHomeEntity.recommendations![index],
                              repeat: () {
                                context.read<TestProvider>().testStart.resumeQuesId = null;

                                gotoTestInstructions(
                                                                testType: "",

                                  context,
                                  testEntity: Provider.of<TestProvider>(context,
                                      listen: false)
                                      .testHomeEntity
                                      .recommendations![index],
                                );
                              },
                              results: () {
                                if (Provider.of<TestProvider>(context,
                                    listen: false)
                                    .testHomeEntity
                                    .recommendations?[index]
                                    .text3
                                    ?.toUpperCase() ==
                                    'FINISHED') {
                                  gotoResults(
                                      context,
                                      Provider.of<TestProvider>(context,
                                          listen: false)
                                          .testHomeEntity
                                          .recommendations?[index]
                                          .userTestId
                                          ?.toInt(),
                                      1);
                                }
                              },
                              resume: () {
                                context.read<TestProvider>().testStart.resumeQuesId = 1;

                                if (Provider.of<TestProvider>(context,
                                    listen: false)
                                    .testHomeEntity
                                    .recommendations?[index]
                                    .text3
                                    ?.toUpperCase() ==
                                    'ONGOING') {
                                  gotoTestInstructions(
                                                                  testType: "",

                                    context,
                                    testEntity: Provider.of<TestProvider>(
                                        context,
                                        listen: false)
                                        .testHomeEntity
                                        .recommendations![index],
                                      isPrecticeTest:Provider.of<TestProvider>(context,
                                          listen: false)
                                          .testHomeEntity
                                          .recommendations?[index].leftTop == "Practice" ? true : false
                                  );
                                }
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
