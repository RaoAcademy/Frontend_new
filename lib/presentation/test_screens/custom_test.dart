import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rao_academy/application/test/test_provider.dart';
import 'package:rao_academy/core/utli/error_handle.dart';
import 'package:rao_academy/core/utli/goto_pages.dart';
import 'package:rao_academy/core/utli/loops_urls.dart';
import 'package:rao_academy/core/utli/show_error_toast.dart';
import 'package:rao_academy/core/utli/validations.dart';
import 'package:rao_academy/core/widgets/container_with_border.dart';
import 'package:rao_academy/core/widgets/custom_button.dart';
import 'package:rao_academy/core/widgets/custom_text_field.dart';
List<int> selectedChapters = [];
List<int> selectedConcepts = [];
List<int> selectedLevels = [];
List<int> selectedFormats = [];
TextEditingController controllerCustom = TextEditingController();
class CustomTest extends StatefulWidget {
  const CustomTest({Key? key}) : super(key: key);

  @override
  State<CustomTest> createState() => _CustomTestState();
}



final formkey = GlobalKey<FormState>();

class _CustomTestState extends State<CustomTest> {
  @override
  void initState() {
    final TestProvider provider = context.read<TestProvider>();
    selectedChapters.clear();
    selectedConcepts.clear();
    selectedLevels.clear();
    selectedFormats.clear();
    controllerCustom.clear();
    provider.timeTake = List.filled(1000, 0);
    provider.clearPrevious();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final TestProvider provider = context.watch<TestProvider>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            goSpecificBack(context, 3);
          },
          icon: Icon(
            Icons.arrow_back,
            color: LoopsColors.whiteBkground,
            size: 24.sp,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: LoopsColors.primaryColor,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Custom Test',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: LoopsColors.colorWhite,
              ),
            ),
            /* Text(
              'Physics - 3 Chapters selected',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: LoopsColors.colorWhite,
              ),
            ), */
          ],
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
            ContainerWithBorder(
              borderColor: LoopsColors.primaryColor,
              borderRadius: 8.sp,
              height: 46.h,
              child: Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.only(left: 12.sp),
                    child: CustomTextField(
                      formKey: formkey,
                      hintText: 'Add your test name here',
                      controller: controllerCustom,
                      validator: LoopsValidation.name,
                      smallSize: true,
                    ),
                  )),
                  // Expanded(
                  //   child: ContainerWithBorder(
                  //     borderColor: LoopsColors.tertiaryColor,
                  //     borderRadius: 8.sp,
                  //     borderWidth: 2.sp,
                  //     width: 164.w,
                  //     height: 46.h,
                  //     child: Text(
                  //       provider.customTestEntity.customName ?? '',
                  //       style: TextStyle(
                  //         fontSize: 16.sp,
                  //         fontWeight: FontWeight.w600,
                  //         color: LoopsColors.secondaryColor,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            SizedBox(
              height: 24.h,
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Chapter',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: LoopsColors.colorBlack,
                  ),
                ),
                /* if (provider.customTestEntity.chapters!.length > 3)
                  InkWell(
                    onTap: () {
                      setState(() {
                        _showAll = !_showAll;
                      });
                    },
                    child: Text(
                      'Show All',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: LoopsColors.colorBlack,
                      ),
                    ),
                  ), */
              ],
            ),
            SizedBox(
              height: 8.h,
            ),
            Wrap(
              children: [
                for (int index = 0;
                    index < provider.customTestEntity.chapters!.length;
                    index++)
                  InkWell(
                    onTap: () {
                      if (!selectedChapters.contains(
                          provider.customTestEntity.chapters![index].id)) {
                        selectedChapters.add(provider
                            .customTestEntity.chapters![index].id!
                            .toInt());
                        if (controllerCustom.text != '') {
                          provider
                              .fcustomTest(
                            chapterIds: selectedChapters,
                            // conceptIds: _selectedConcepts,
                            // level: _selectedLevels,
                            // format: _selectedFormats,
                          )
                              .then((_) {

                            selectedConcepts.add(provider
                                    .customTestEntity.concepts![index].id
                                    ?.toInt() ??
                                1);
                          });
                        } else {
                          handleError('Custom test name is required.');
                        }
                      } else {
                        if (kDebugMode) {
                          print("REMOVE TRIGGER");
                          print(selectedConcepts);
                        }

                        selectedChapters.remove(
                            provider.customTestEntity.chapters![index].id);

                        selectedConcepts.remove(
                            provider.customTestEntity.concepts![index].id);

                        provider
                            .fcustomTest(
                          chapterIds: selectedChapters,
                          // conceptIds: _selectedConcepts,
                          // level: _selectedLevels,
                          // format: _selectedFormats,
                        )
                            .then((_) {
                          selectedConcepts.add(provider
                                  .customTestEntity.concepts![index].id
                                  ?.toInt() ??
                              1);
                          selectedLevels.add(provider
                                  .customTestEntity.levels![index].id
                                  ?.toInt() ??
                              1);
                        });

                        // provider.customTestEntity.concepts?[index
                        if (kDebugMode) {
                          print("AFTER TRIGGER");
                          print(selectedConcepts);
                        }
                        //TODO: Remove the concept
                      }
                      provider.setState();
                    },
                    child: Container(
                      margin: EdgeInsets.all(4.w),
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          color: selectedChapters.contains(
                                  provider.customTestEntity.chapters![index].id)
                              ? LoopsColors.selectedColor
                              : LoopsColors.colorWhite,
                          borderRadius: BorderRadius.all(
                            Radius.circular(4.sp),
                          ),
                          border: Border.all(
                            color: LoopsColors.selectedColor,
                          )),
                      constraints: BoxConstraints(
                        minWidth: MediaQuery.of(context).size.width / 3.4,
                      ),
                      height: 38.h,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Text(
                            provider.customTestEntity.chapters![index].name ??
                                '',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: index == 0
                                  ? LoopsColors.primaryColor
                                  : LoopsColors.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                SizedBox(
                  width: 8.h,
                ),
              ],
            ),
            SizedBox(
              height: 24.h,
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Concepts',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: LoopsColors.colorBlack,
                  ),
                ),
                /* if (provider.customTestEntity.concepts!.length > 3)
                  InkWell(
                    onTap: () {
                      setState(() {
                        _showAll = !_showAll;
                      });
                    },
                    child: Text(
                      'Show All',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: LoopsColors.colorBlack,
                      ),
                    ),
                  ), */
              ],
            ),
            SizedBox(
              height: 8.h,
            ),
            Wrap(
              children: [
                for (int index = 0;
                    index <
                        provider.customTestEntity.concepts!
                            .length /*  < 3
                            ? provider.customTestEntity.concepts!.length
                            : 3) */
                    ;
                    index++)
                  InkWell(
                    onTap: () {
                      provider
                          .fcustomTest(
                        chapterIds: selectedChapters,
                        conceptIds: selectedConcepts,
                        // level: _selectedLevels,
                        // format: _selectedFormats,
                      )
                          .then((_) {
                        // _selectedConcepts.add(provider
                        //     .customTestEntity.concepts![index].id
                        //     ?.toInt() ??
                        //     1);
                        // _selectedLevels.add(provider
                        //     .customTestEntity.levels![index].id
                        //     ?.toInt() ??
                        //     1);
                        if (!selectedConcepts.contains(
                            provider.customTestEntity.concepts![index].id)) {
                          selectedConcepts.add(provider
                              .customTestEntity.concepts![index].id!
                              .toInt());
                          // _selectedLevels.clear();
                          //
                          // _selectedLevels.add(provider
                          //         .customTestEntity.levels![index].id
                          //         ?.toInt() ??
                          //     1);
                          selectedFormats.clear();
                          selectedFormats.add(provider
                              .customTestEntity.formats![index].id!
                              .toInt());
                        } else {
                          selectedConcepts.remove(
                              provider.customTestEntity.concepts![index].id);
                        }
                      });

                      provider.setState();
                    },
                    child: Container(
                      margin: EdgeInsets.all(4.w),
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          color: selectedConcepts.contains(
                                  provider.customTestEntity.concepts![index].id)
                              ? LoopsColors.selectedColor
                              : LoopsColors.colorWhite,
                          borderRadius: BorderRadius.all(
                            Radius.circular(4.sp),
                          ),
                          border: Border.all(
                            color: LoopsColors.selectedColor,
                          )),
                      constraints: BoxConstraints(
                        minWidth: MediaQuery.of(context).size.width / 3.4,
                      ),
                      height: 38.h,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Text(
                            provider.customTestEntity.concepts![index].name ??
                                '',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: index == 0
                                  ? LoopsColors.primaryColor
                                  : LoopsColors.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                SizedBox(
                  width: 8.h,
                ),
              ],
              /*  );
                              }, */
            ),
            SizedBox(
              height: 24.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Level',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: LoopsColors.colorBlack,
                  ),
                ),
                /* if (_levels.length > 3)
                  InkWell(
                    onTap: () {
                      setState(() {
                        _showAll = !_showAll;
                      });
                    },
                    child: Text(
                      'Show All',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: LoopsColors.colorBlack,
                      ),
                    ),
                  ), */
              ],
            ),
            SizedBox(
              height: 8.h,
            ),
            Wrap(
              children: [
                for (int index = 0;
                    index <
                        provider.customTestEntity.levels!
                            .length /* < 3
                            ? provider.customTestEntity.levels!.length
                            : 3) */
                    ;
                    index++)
                  InkWell(
                    onTap: () {
                      if (!selectedLevels.contains(
                          provider.customTestEntity.levels![index].id)) {
                        selectedLevels.add(provider
                            .customTestEntity.levels![index].id!
                            .toInt());
                      } else {
                        selectedLevels.remove(
                            provider.customTestEntity.levels![index].id);
                      }
                      provider.setState();
                    },
                    child: Container(
                      margin: EdgeInsets.all(4.w),
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          color: selectedLevels.contains(
                                  provider.customTestEntity.levels![index].id)
                              ? LoopsColors.selectedColor
                              : LoopsColors.colorWhite,
                          borderRadius: BorderRadius.all(
                            Radius.circular(4.sp),
                          ),
                          border: Border.all(
                            color: LoopsColors.selectedColor,
                          )),
                      constraints: BoxConstraints(
                        minWidth: MediaQuery.of(context).size.width / 3.4,
                      ),
                      height: 38.h,
                      width: MediaQuery.of(context).size.width / 2.42,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Text(
                            provider.customTestEntity.levels![index].level ??
                                '',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: index == 0
                                  ? LoopsColors.primaryColor
                                  : LoopsColors.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                SizedBox(
                  width: 8.h,
                ),
              ],
              /* );
                              }, */
            ),
            SizedBox(
              height: 24.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Question types',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: LoopsColors.colorBlack,
                  ),
                ),
                /* if (_questionTypes.length > 3)
                  InkWell(
                    onTap: () {
                      setState(() {
                        _showAll = !_showAll;
                      });
                    },
                    child: Text(
                      'Show All',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: LoopsColors.colorBlack,
                      ),
                    ),
                  ), */
              ],
            ),
            SizedBox(
              height: 8.h,
            ),
            /* // if (!_showAll)
              SizedBox(
                height: 40.h,
                child: /* ListView.builder(
                itemCount: _questionTypes.length < 3 ? _questionTypes.length : 3,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return */
                    ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      for (int index = 0;
                          index <
                              (provider.customTestEntity.formats!.length < 3
                                  ? provider.customTestEntity.formats!.length
                                  : 3);
                          index++)
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 4.w),
                          decoration: BoxDecoration(
                              color: index == 0
                                  ? LoopsColors.selectedColor
                                  : LoopsColors.colorWhite,
                              borderRadius: BorderRadius.all(
                                Radius.circular(4.sp),
                              ),
                              border: Border.all(
                                color: LoopsColors.selectedColor,
                              )),
                          constraints: BoxConstraints(
                            minWidth: MediaQuery.of(context).size.width / 3.4,
                          ),
                          height: 38.h,
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                              child: Text(
                                provider.customTestEntity.formats![index]
                                        .format ??
                                    '',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: index == 0
                                      ? LoopsColors.primaryColor
                                      : LoopsColors.primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                    /*   );
                                      }, */
                  ),
                ),
              )
            else */
            Wrap(
              children: [
                for (int index = 0;
                    index < provider.customTestEntity.formats!.length;
                    index++)
                  InkWell(
                    onTap: () {
                      if (!selectedFormats.contains(
                          provider.customTestEntity.formats![index].id)) {
                        selectedFormats.add(provider
                            .customTestEntity.formats![index].id!
                            .toInt());
                      } else {
                        selectedFormats.remove(
                            provider.customTestEntity.formats![index].id);
                      }
                      provider.setState();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: selectedFormats.contains(provider
                                    .customTestEntity.formats![index].id)
                                ? LoopsColors.selectedColor
                                : LoopsColors.colorWhite,
                            borderRadius: BorderRadius.all(
                              Radius.circular(4.sp),
                            ),
                            border: Border.all(
                              color: LoopsColors.selectedColor,
                            )),
                        height: 38.h,
                        width: MediaQuery.of(context).size.width / 2.42,
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            child: Text(
                              provider.customTestEntity.formats![index]
                                      .format ??
                                  '',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5.sp,
                                color: index == 0
                                    ? LoopsColors.primaryColor
                                    : LoopsColors.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(
              height: 24.h,
            ),
            /* Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Do it',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: LoopsColors.colorBlack,
                  ),
                ),
                if (_doIt.length > 3)
                  InkWell(
                    onTap: () {
                      _showAll = true;
                    },
                    child: Text(
                      'Show All',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: LoopsColors.colorBlack,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(
              height: 8.h,
            ),
            SizedBox(
              height: 40.h,
              child: ListView.builder(
                itemCount: _doIt.length < 3 ? _doIt.length : 3,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: index == 0 ? LoopsColors.selectedColor : LoopsColors.colorWhite,
                            borderRadius: BorderRadius.all(
                              Radius.circular(4.sp),
                            ),
                            border: Border.all(
                              color: LoopsColors.selectedColor,
                            )),
                        height: 38.h,
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: Text(
                              _doIt[index],
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: index == 0
                                    ? LoopsColors.primaryColor
                                    : LoopsColors.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8.h,
                      ),
                    ],
                  );
                },
              ),
            ), */
            // Expanded(child: Container()),
            CustomButton(
              onTap: () {

                  if (controllerCustom.text != '') {
                    if(selectedChapters.isNotEmpty && selectedConcepts.isNotEmpty && selectedLevels.isNotEmpty && selectedFormats.isNotEmpty){
                      provider
                          .fcustomTest(
                        chapterIds: selectedChapters,
                        conceptIds: selectedConcepts,
                        level: selectedLevels,
                        format: selectedFormats,
                      )
                          .then((_) {
                        gotoTestInstructions(
                          testType: "Custom Test",

                          context,
                          customName: controllerCustom.text,
                          // chapterIds: _selectedChapters,
                          customConceptIds: selectedConcepts.join(","),
                          customFormats: selectedFormats.join(","),
                          customLevels: selectedLevels.join(","),
                          fromCustomTest: true,
                          questionsId: provider.customTestEntity.questionIds,
                          chaptersId: selectedChapters.join(","),
                        ).then((value) {
                          // provider
                          //     .ftestStart(
                          //
                          //   customName: controllerCustom.text,
                          //   chapterIds: selectedChapters,
                          //   customConceptIds: selectedConcepts,
                          //   customFormats: selectedFormats,
                          //   customLevels: selectedLevels,
                          //   questionIds: provider.customTestEntity.questionIds,
                          // );
                        });
                        // provider
                        //     .ftestStart(
                        //   customName: _controller.text,
                        //   chapterIds: _selectedChapters,
                        //   customConceptIds: _selectedConcepts,
                        //   customFormats: _selectedFormats,
                        //   customLevels: _selectedLevels,
                        //   questionIds: provider.customTestEntity.questionIds,
                        // )
                        //     .then((value) {
                        //   gotoTestInstructions(
                        //     context,
                        //     customName: _controller.text,
                        //     // chapterIds: _selectedChapters,
                        //     customConceptIds: _selectedConcepts,
                        //     customFormats: _selectedFormats,
                        //     customLevels: _selectedLevels,
                        //     fromCustomTest: true,
                        //   );
                        //});
                      });
                    }else{
                      showErrorToast('Select atleast one option from each section');
                    }

                  } else {
                    handleError('Custom test name is required.');
                  }


              },
              child: Text(
                'Next',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: LoopsColors.primaryColor,
                  letterSpacing: 1.sp,
                ),
              ),
            ),
            SizedBox(
              height: 24.h,
            ),
          ],
        ),
      ),
    );
  }
}
