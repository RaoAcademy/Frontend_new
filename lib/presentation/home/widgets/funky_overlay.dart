import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rao_academy/core/utli/goto_pages.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:rao_academy/core/utli/loops_urls.dart';
import 'package:rao_academy/core/widgets/container_with_border.dart';
import 'package:rao_academy/presentation/other/widgets/cached_network_image.dart';
// import 'package:rao_academy/core/widgets/container_with_border.dart';

class FunkyOverlay extends StatelessWidget {
  const FunkyOverlay({
    Key? key,
    required this.index,
    required this.name,
    required this.text,
    this.svg = false,
  }) : super(key: key);
  final int index;
  final String name;
  final String text;
  final bool svg;

  /* @override
  State<StatefulWidget> createState() => FunkyOverlayState();
}

class FunkyOverlayState extends State<FunkyOverlay>
    with SingleTickerProviderStateMixin { */
  /* AnimationController? controller;
  Animation<double>? scaleAnimation; */

  /*  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller!, curve: Curves.elasticInOut);

    controller!.addListener(() {
      setState(() {});
    });

    controller!.forward();
  } */

  @override
  Widget build(BuildContext context) {
    return /* Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation!,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: */
        Center(
            child: /*  Stack(
        children: [ */
                /*  ContainerWithBorder(
            borderRadius: 10.sp,
            boxColor: LoopsColors.colorWhite,
            height: 120.h,
            width: 160.w,
            boxShadow: [
              BoxShadow(
                  blurRadius: 10,
                  spreadRadius: 10,
                  color: LoopsColors.colorGrey.withOpacity(0.2),
                  offset: Offset(5.sp, 5.sp))
            ],
          ), */
                ContainerWithBorder(
      borderRadius: 10.sp,
      boxColor: LoopsColors.colorWhite.withOpacity(0),
      height: 380.h,
      width: MediaQuery.of(context).size.width / 1.2,
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: 80.h,
              ),
              ContainerWithBorder(
                height: 200.h,
                borderRadius: 12.sp,
                child: Column(
                  children: [
                    SizedBox(
                      height: 40.h,
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Center(
                          child: Text(
                            text,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: LoopsColors.textColor,
                              letterSpacing: 0.03.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 42.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Material(
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: ContainerWithBorder(
                                  boxColor: LoopsColors.colorWhite,
                                  width: 80.w,
                                  height: 32.h,
                                  borderRadius: 12.sp,
                                  borderColor: LoopsColors.textColor,
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: LoopsColors.textColor
                                          .withOpacity(0.8),
                                      letterSpacing: 0.03.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Material(
                              child: InkWell(
                                onTap: () {
                                  // Navigator.pop(context);
                                  switch (index) {
                                    case 0:
                                      gotoProfile(context);
                                      break;
                                    case 1:
                                      gotoTestHome(context);
                                      break;
                                    case 2:
                                      gotoSubscription(context);
                                      break;
                                    case 3:
                                      gotoReports(context,false);
                                      break;
                                    default:
                                  }
                                },
                                child: ContainerWithBorder(
                                  boxColor:
                                      LoopsColors.primaryColor.withOpacity(0.2),
                                  width: 80.w,
                                  height: 32.h,
                                  borderRadius: 12.sp,
                                  // borderColor: LoopsColors.textColor,
                                  child: Text(
                                    'Check',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: LoopsColors.primaryColor,
                                      letterSpacing: 0.03.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 62,
            left: 0,
            right: 0,
            child: svg
                ? ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.sp),
                      topRight: Radius.circular(10.sp),
                    ),
                    child: SizedBox(
                      height: 76.h,
                      child: SvgPicture.asset(
                        name,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.sp),
                      topRight: Radius.circular(10.sp),
                    ),
                    child: LoopsImage(
                      path: name,
                      width: MediaQuery.of(context).size.width / 1.23,
                    ),
                  ),
          ),
        ],
      ),
    )
            /*  ],
      ), */
            /*  ),
          ),
        ),
      ), */
            );
  }
}
