import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rao_academy/core/utli/loops_urls.dart';
import 'package:rao_academy/core/widgets/container_with_border.dart';
// import 'package:rao_academy/presentation/test_screens/widget/bottombar.dart';

class MCQImage extends StatefulWidget {
  const MCQImage({Key? key}) : super(key: key);

  @override
  State<MCQImage> createState() => _MCQImageState();
}

class _MCQImageState extends State<MCQImage> {
  int _indexOfAcceptedItem = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LoopsColors.colorWhite,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            SizedBox(
              height: 4.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ContainerWithBorder(
                  width: 64.w,
                  height: 24.h,
                  borderRadius: 5.sp,
                  borderColor: LoopsColors.textColor,
                  child: Text(
                    'MCQ',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  height: 32.h,
                ),
                /* Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
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
                    )
                  ],
                ) */
              ],
            ),
            SizedBox(
              height: 40.h,
            ),
            Container(
              height: 162.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.sp),
                image: const DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                    'https://picsum.photos/id/${237 + 5}/600/300',
                  ),
                ),
                /* loadingBuilder: (Bcontext, () =>  Continer(), _) => const Center(
                  child: CircularProgressIndicator(
                    color: LoopsColors.tertiaryColor,
                  ),
                ),
                errorWidget: (context, url, error) => Center(
                    child: Icon(
                  Icons.error_outline_outlined,
                  size: 24.sp,
                  color: LoopsColors.colorRed,
                )) */
              ),
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
            Wrap(
              children: [
                for (int index = 0; index < 4; index++)
                  Padding(
                    padding: EdgeInsets.only(
                        top: 12.h,
                        bottom: 12.h,
                        left: index.isOdd ? 12.w : 0,
                        right: index.isEven ? 12.w : 0),
                    child: ContainerWithBorder(
                      width: MediaQuery.of(context).size.width / 2.5,
                      height: 122.h,
                      borderRadius: 8.sp,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _indexOfAcceptedItem = index;
                          });
                        },
                        child: Stack(
                          children: [
                            DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.sp),
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                    // height: 122.h,
                                    // imageUrl:
                                    'https://picsum.photos/id/${123 + index}/200/200',

                                    /*   placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(
                                    color: LoopsColors.tertiaryColor,
                                  ),
                                ), */
                                    /*  loadingBuilder: (context, imageProvider) =>
                                    Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.sp),
                                    ),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                      colorFilter: ColorFilter.mode(
                                        _indexOfAcceptedItem == index
                                            ? LoopsColors.secondaryColor
                                            : Colors.transparent,
                                        BlendMode.colorBurn,
                                      ),
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) => Center(
                                  child: Icon(
                                    Icons.error_outline_outlined,
                                    size: 24.sp,
                                    color: LoopsColors.colorRed,
                                  ),
                                ), */
                                  ),
                                ),
                              ),
                            ),
                            if (_indexOfAcceptedItem == index)
                              ContainerWithBorder(
                                borderRadius: 10.sp,
                                boxColor:
                                    LoopsColors.secondaryColor.withOpacity(0.8),
                                child: Center(
                                  child: Icon(
                                    Icons.check,
                                    color: LoopsColors.colorWhite,
                                    size: 24.sp,
                                  ),
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            /* Expanded(child: Container()),
            ContainerWithBorder(
              boxColor: LoopsColors.whiteBkground,
              padding: EdgeInsets.symmetric(vertical: 12.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ContainerWithBorder(
                    borderColor: LoopsColors.textColor,
                    width: 100.w,
                    borderRadius: 4.sp,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.report_sharp,
                          color: LoopsColors.primaryColor,
                          size: 24.sp,
                        ),
                        Icon(
                          Icons.align_vertical_bottom_sharp,
                          color: LoopsColors.primaryColor,
                          size: 24.sp,
                        ),
                        Icon(
                          Icons.book_outlined,
                          color: LoopsColors.primaryColor,
                          size: 24.sp,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 100.w,
                    child: LinearProgressIndicator(
                      value: 0.4.sp,
                    ),
                  ),
                  CustomButton(
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/dragNDrop',
                        (route) => false,
                      );
                    },
                    width: 80.w,
                    height: 30.h,
                    lable: 'Next',
                  )
                ],
              ),
            ) */
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        color: LoopsColors.whiteBkground,
        padding: EdgeInsets.symmetric(horizontal: 12.sp),
        height: 55.h,
        /* child: Bottombar(
          hidePrevious: provider.currentQuestionPageIndex,
          progress: 30.0, getValue: (_) {}), */
      ),
    );
  }
}
