import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:EdTestz/core/utli/goto_pages.dart';
import 'package:EdTestz/core/utli/loops_urls.dart';
import 'package:EdTestz/core/widgets/container_with_border.dart';
import 'package:EdTestz/core/widgets/custom_button.dart';

Future<bool> onWillPop(BuildContext context, {bool allowToPop = false}) async {
  if (Navigator.canPop(context) && allowToPop) {
    Navigator.of(context).pop();
  } else {
    await showDialog(
      barrierDismissible: false,
      useRootNavigator: false,
      context: context,
      builder: (BuildContext context2) => twoFunctionPopup(
        context: context,
        heading: 'Are you sure?',
        message: 'Do you want to exit the app?',
        lButton: 'Yes',
        rButton: 'No',
        lFunction: () async {
          await Future.delayed(Duration.zero).then((value) {
            Navigator.of(context2).pop();
            Navigator.of(context).pop();
            SystemNavigator.pop();
            if (Platform.isAndroid) {
              exit(0);
            }
          });
        },
        rFunction: () async {
          await gotoSplashScreen(context);
        },
      ),
    );
  }
  return true;
}

Dialog twoFunctionPopup({
  required BuildContext context,
  required String heading,
  required String message,
  required String lButton,
  required String rButton,
  required Function() lFunction,
  required Function() rFunction,
}) {
  return Dialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)), //this right here
    child: ContainerWithBorder(
      boxColor: LoopsColors.colorWhite,
      borderRadius: 10.0,
      height: 240.h,
      width: 350.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Text(
                heading,
                style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: LoopsColors.primaryColor),
              ),
              SizedBox(
                height: 12.h,
              ),
              SizedBox(
                height: 100.h,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      message,
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: LoopsColors.primaryColor),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: lFunction,
                child: ContainerWithBorder(
                  boxColor: LoopsColors.colorWhite,
                  borderColor: LoopsColors.secondaryColor,
                  borderRadius: 10.sp,
                  borderWidth: 2,
                  width: 137.w,
                  height: 50.h,
                  child: Text(
                    lButton,
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: LoopsColors.secondaryColor),
                  ),
                ),
              ),
              CustomButton(
                width: 137.w,
                height: 50.h,
                onTap: rFunction,
                child: Text(
                  rButton,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: LoopsColors.primaryColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
        ],
      ),
    ),
  );
}
