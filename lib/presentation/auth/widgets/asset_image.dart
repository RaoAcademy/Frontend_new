import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';

import 'package:EdTestz/core/utli/loops_urls.dart';
import 'package:EdTestz/core/widgets/container_with_border.dart';
import 'package:EdTestz/presentation/other/widgets/cached_network_image.dart';

class AssetSvgImage extends StatelessWidget {
  const AssetSvgImage({
    Key? key,
    required this.svgAsset,
  }) : super(key: key);

  final String svgAsset;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: ContainerWithBorder(
            height: 40.h,
            width: 40.h,
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
        SizedBox(
          width: 80.w,
          height: 100.h,
          child: ClipRRect(
            // height: 120.h,
            child: LoopsImage(
              path: svgAsset,
              // colorCode: 'FFFFFF',
            ),
          ),
        ),
        /* Positioned(
          top: 0,
          bottom: 10,
          left: 0,
          right: 0,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.w600,
                color: LoopsColors.colorWhite,
              ),
            ),
          ),
        ) */
      ],
    );
  }
}
