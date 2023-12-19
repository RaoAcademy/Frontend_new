import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rao_academy/application/other/other_provider.dart';
import 'package:rao_academy/application/test/test_provider.dart';
import 'package:rao_academy/core/utli/goto_pages.dart';
import 'package:rao_academy/core/utli/loops_urls.dart';
import 'package:rao_academy/core/widgets/container_with_border.dart';
import 'package:rao_academy/presentation/core/test_card.dart';
import 'package:rao_academy/presentation/other/widgets/cached_network_image.dart';

import '../../core/utli/error_handle.dart';


class ConceptBased extends StatelessWidget {
  const ConceptBased({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TestProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: LoopsColors.primaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            Provider.of<OtherProvider>(context, listen: false)
                .routeNames
                .remove(Provider.of<OtherProvider>(context, listen: false)
                    .routeNames
                    .last);
          },
          icon: Icon(
            Icons.arrow_back,
            color: LoopsColors.tertiaryColor,
            size: 24.sp,
          ),
        ),
        title: Text(
          'Concept Based',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: LoopsColors.colorWhite,
          ),
        ),
      ),
      body: ContainerWithBorder(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(12.sp),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(right: 16.sp, bottom: 16.sp),
                      child: LoopsImage(
                        path: provider.testChapterConcept.imagePath!,
                        width: 65.w,
                        height: 65.h,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          provider.testChapterConcept.name!,
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                            color: LoopsColors.colorBlack,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Expanded(
                          child: Wrap(
                            children: [
                              for (var item
                                  in provider.testChapterConcept.tags!)
                                ContainerWithBorder(
                                  boxColor: LoopsColors.colorsList02[provider
                                          .testChapterConcept.tags!
                                          .indexOf(item)]
                                      .withOpacity(0.2),
                                  height: 22.h,
                                  width: item.characters.length * 9.w +
                                      (item.split(' ').length * 4.sp),
                                  borderRadius: 4,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 4.w, vertical: 2.h),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 2.sp,
                                      color: LoopsColors.lightGrey,
                                    )
                                  ],
                                  child: Text(
                                    item,
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      letterSpacing: 0.8.sp,
                                      fontWeight: FontWeight.w600,
                                      color: LoopsColors.colorsList02[provider
                                          .testChapterConcept.tags!
                                          .indexOf(item)],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 16.sp,
                        letterSpacing: 0.8.sp,
                        fontWeight: FontWeight.w600,
                        color: LoopsColors.colorBlack,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        provider.testChapterConcept.description!,
                        style: TextStyle(
                          fontSize: 14.sp,
                          letterSpacing: 0.8.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            ContainerWithBorder(
              width: MediaQuery.of(context).size.width,
              height: 1.sp,
              boxColor: LoopsColors.colorGrey,
            ),
            SizedBox(
              height: 30.h,
            ),
            Expanded(
              flex: 6,
              child: Padding(
                padding: EdgeInsets.all(4.w),
                child: ListView.builder(
                  itemCount: Provider.of<TestProvider>(context, listen: false)
                      .testChapterConcept
                      .test
                      ?.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        SizedBox(
                          width: 261.w,
                          height: 160.h,
                          child: InkWell(
                            onTap: () async{
                              await Provider.of<TestProvider>(context, listen: false)
                                  .ftestStart(testEntity: provider.testEntity)
                                  .then((_) async {
                                await gotoQuestionTypes(
                                  context,
                                  Provider.of<TestProvider>(context, listen: false)
                                      .testStart
                                      .question!
                                      .first
                                      .format!,
                                );
                              }).onError((error, stackTrace) async {
                                await handleError(error);
                              });
                              if(Provider.of<TestProvider>(context,
                                  listen: false)
                                  .testChapterConcept
                                  .test![index].rightTop != null){
                                Provider.of<TestProvider>(context,
                                    listen: false)
                                    .testStart.resumeQuesId = null;
                              }else{
                                Provider.of<TestProvider>(context,
                                    listen: false)
                                    .testStart.resumeQuesId = provider.testStart.resumeQuesId;
                              }
                              gotoTestInstructions(
                                testType: "",
                                context,
                                testEntity:
                                    provider.testChapterConcept.test![index],
                              );
                            },
                            child: TestCard01(
                              testEntity: Provider.of<TestProvider>(context,
                                      listen: false)
                                  .testChapterConcept
                                  .test![index],
                              repeat: () {
                                Provider.of<TestProvider>(context,
                                    listen: false)
                                    .testStart.resumeQuesId = null;
                                // if(Provider.of<TestProvider>(context,
                                //     listen: false)
                                //     .testChapterConcept
                                //     .test![index].rightTop != null){
                                //   Provider.of<TestProvider>(context,
                                //       listen: false)
                                //       .testStart.resumeQuesId = null;
                                // }else{
                                //   Provider.of<TestProvider>(context,
                                //       listen: false)
                                //       .testStart.resumeQuesId = provider.testStart.resumeQuesId;
                                // }

                                Provider.of<TestProvider>(context,
                                    listen: false)
                                    .testChapterConcept
                                    .test![index].userTestId = null;


                                gotoTestInstructions(
                                testType: "",
                                  context,
                                  testEntity: Provider.of<TestProvider>(context,
                                      listen: false)
                                      .testChapterConcept
                                      .test![index],
                                );
                              },
                              results: () {
                                if(Provider.of<TestProvider>(context,
                                    listen: false)
                                    .testChapterConcept
                                    .test![index].rightTop != null){
                                  Provider.of<TestProvider>(context,
                                      listen: false)
                                      .testStart.resumeQuesId = null;
                                }else{
                                  Provider.of<TestProvider>(context,
                                      listen: false)
                                      .testStart.resumeQuesId = provider.testStart.resumeQuesId;
                                }
                                if (Provider.of<TestProvider>(context,
                                            listen: false)
                                        .testChapterConcept
                                        .test![index]
                                        .text3
                                        ?.toUpperCase() ==
                                    'FINISHED') {
                                  gotoResults(
                                      context,
                                      Provider.of<TestProvider>(context,
                                              listen: false)
                                          .testChapterConcept
                                          .test![index]
                                          .userTestId
                                          ?.toInt(),
                                      3);
                                }
                              },
                              resume: () async{
                                if (Provider.of<TestProvider>(context,
                                            listen: false)
                                        .testChapterConcept
                                        .test![index]
                                        .text3
                                        ?.toUpperCase() ==
                                    'ONGOING') {
                                  if(Provider.of<TestProvider>(context,
                                      listen: false)
                                      .testChapterConcept
                                      .test![index].rightTop != null){
                                    Provider.of<TestProvider>(context,
                                        listen: false)
                                        .testStart.resumeQuesId = null;
                                  }else{
                                    // await Provider.of<TestProvider>(context, listen: false)
                                    //     .ftestStart(testEntity:Provider.of<TestProvider>(context,
                                    //     listen: false)
                                    //     .testEntity )
                                    //     .then((_) async {
                                    //   await gotoQuestionTypes(
                                    //     context,
                                    //     Provider.of<TestProvider>(context, listen: false)
                                    //         .testStart
                                    //         .question!
                                    //         .first
                                    //         .format!,
                                    //   );
                                    // }).onError((error, stackTrace) async {
                                    //   await handleError(error);
                                    // });


                                    Provider.of<TestProvider>(context,
                                        listen: false)
                                        .testStart.resumeQuesId = provider.testStart.resumeQuesId;
                                  }

                                  gotoTestInstructions(
                                    testType: "",
                                    context,
                                    testEntity: Provider.of<TestProvider>(
                                            context,
                                            listen: false)
                                        .testChapterConcept
                                        .test![index],
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
