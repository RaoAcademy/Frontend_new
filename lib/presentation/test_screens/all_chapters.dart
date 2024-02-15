import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:EdTestz/application/other/other_provider.dart';
import 'package:EdTestz/application/test/test_provider.dart';
import 'package:EdTestz/core/utli/goto_pages.dart';
import 'package:EdTestz/core/utli/loops_urls.dart';
import 'package:EdTestz/core/widgets/container_with_border.dart';
import 'package:EdTestz/presentation/other/widgets/cached_network_image.dart';

class AllChapters extends StatelessWidget {
  const AllChapters({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TestProvider>();
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
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'All Chapters',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: LoopsColors.colorWhite,
              ),
            ),
            Text(
              provider.testChapters.subectName!,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: LoopsColors.colorWhite,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 16.h,
          ),
          Expanded(
            child: GridView.builder(
              itemCount: provider.testChapters.chapter?.length,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.only(
                  left: index.isEven ? 8.w : 4.w,
                  right: index.isOdd ? 8.w : 4.w,
                  top: 4.h,
                  bottom: 4.h,
                ),
                child: InkWell(
                  onTap: () {

                    gotoConceptBased(context,
                        provider.testChapters.chapter![index].id!.toInt());
                  },
                  child: ContainerWithBorder(
                    borderColor: LoopsColors.colorYellow1,
                    height: 94.h,
                    borderRadius: 5.sp,
                    padding: EdgeInsets.all(8.sp),
                    boxShadow: [
                      BoxShadow(blurRadius: 12.sp, color: LoopsColors.lightGrey)
                    ],
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    LoopsImage(
                                        width: 50.w,
                                        height: 50.h,
                                        path: provider.testChapters
                                            .chapter![index].imagePath!),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  for (final item in provider
                                      .testChapters.chapter![index].caption!
                                      .split(','))
                                    ContainerWithBorder(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 1.sp),
                                      boxColor: LoopsColors.colorYellow1
                                          .withOpacity(0.7),
                                      width: item.characters.length * 6.sp,
                                      height: 19.h,
                                      child: Text(
                                        item,
                                        style: TextStyle(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w600,
                                            color: LoopsColors.colorOrange2),
                                      ),
                                    ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Expanded(
                          child: Text(
                            provider.testChapters.chapter![index].name!,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 2),
            ),
          ),
        ],
      ),
    );
  }
}
