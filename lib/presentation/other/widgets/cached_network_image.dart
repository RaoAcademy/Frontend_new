import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:curved_progress_bar/curved_progress_bar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rao_academy/core/utli/get_image_path.dart';
import 'package:rao_academy/core/utli/logger.dart';
// import 'package:rao_academy/core/utli/logger.dart';
import 'package:rao_academy/core/utli/loops_urls.dart';

final storageRef = FirebaseStorage.instance.ref();

class LoopsImage extends StatelessWidget {
  const LoopsImage(
      {Key? key, required this.path, this.fit, this.width, this.height})
      : super(key: key);
  final String? path;
  final BoxFit? fit;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    /* return Image.asset(
                'assets/images/img/${path.split('/').last.replaceAll(' ', '')}'); */
    return FutureBuilder<String>(
      future: getImagePath(path!),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          logger.e(snapshot.error);
          log(path!);
          return SizedBox(
              width: 32.sp,
              height: 32.sp,
              child: Icon(Icons.error, color: LoopsColors.colorRed));
        } else if (snapshot.hasData) {
          return CachedNetworkImage(
            progressIndicatorBuilder: (context, url, progress) {
              return Center(
                child: CurvedCircularProgressIndicator(
                  color: LoopsColors.primaryColor,
                  value: (progress.totalSize ?? 300) /
                      (progress.downloaded != 0 ? progress.downloaded : 0.1),
                ),
              );
            },
            imageUrl: snapshot.data!,
            fit: fit,
            width: width,
            height: height,
            /* placeholder: (context, url) => Center(
            child: SizedBox(
                width: 32.sp,
                height: 32.sp,
                child: CurvedCircularProgressIndicator(
                    color: LoopsColors.primaryColor)),
          ), */
            errorWidget: (context, url, error) => Center(
              child: Image(
                image: NetworkImage(
                  url /* 'assets/images/img/${path.split('/').last.replaceAll(' ', '')}' */,
                  // width: width,
                  // fit: fit,
                ),
                errorBuilder: (context, error, stackTrace) {
                  logger.wtf(stackTrace);
                  logger.wtf(url);
                  logger.e(error);

                  return SizedBox(
                      width: 32.sp,
                      height: 32.sp,
                      child: Icon(Icons.error, color: LoopsColors.colorRed));
                },
              ),
            ),
          );
        } else {
          return SizedBox(
            width: 32.sp,
            height: 32.sp,
            child: Center(
              child: CurvedCircularProgressIndicator(
                color: LoopsColors.colorRed,
              ),
            ),
          );
        }
      },
    );
  }
}
