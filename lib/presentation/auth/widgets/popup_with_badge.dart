import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rao_academy/core/utli/loops_urls.dart';
import 'package:rao_academy/core/widgets/container_with_border.dart';
import 'package:rao_academy/presentation/other/widgets/cached_network_image.dart';

class PopupWithBadge extends StatelessWidget {
  const PopupWithBadge({
    Key? key,
    required this.svgAsset,
    required this.body,
  }) : super(key: key);
  final String? svgAsset;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ContainerWithBorder(
        borderRadius: 10.sp,
        boxColor: LoopsColors.colorWhite.withOpacity(0),
        height: 280.h,
        width: MediaQuery.of(context).size.width / 1.2,
        child: Stack(
          children: [
            Center(
              child: ContainerWithBorder(
                height: 140.h,
                borderRadius: 12.sp,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 24.h),
                  child: Center(
                    child: body,
                  ),
                ),
              ),
            ),
            Positioned(
                top: 10,
                left: 0,
                right: 0,
                child: Stack(
                  children: [
                    Center(
                      child: ContainerWithBorder(
                        height: 100.h,
                        width: 100.h,
                        boxColor: Colors.transparent,
                        borderRadius: 100.sp,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            spreadRadius: 10,
                            color: LoopsColors.colorBlack.withOpacity(0.1),
                            offset: Offset(0.sp, 10.sp),
                          )
                        ],
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        width: 100.w,
                        height: 120.h,
                        child: ClipRRect(
                          // height: 120.h,
                          child: LoopsImage(
                            path: svgAsset,
                            // 'assets/images/profile/activity/streak.png',
                            // colorCode: 'FFFFFF',
                          ),
                        ),
                      ),
                    ),
                    /* Positioned(
                      top: 0,
                      bottom: 10,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Material(
                          color: Colors.transparent,
                          child: Text(
                            index,
                            style: TextStyle(
                              fontSize: 28.sp,
                              fontWeight: FontWeight.w600,
                              color: LoopsColors.colorWhite,
                            ),
                          ),
                        ),
                      ),
                    ) */
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
