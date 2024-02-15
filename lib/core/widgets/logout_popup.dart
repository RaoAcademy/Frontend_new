import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:EdTestz/application/auth/auth_provider.dart';
import 'package:EdTestz/application/other/other_provider.dart';
import 'package:EdTestz/core/utli/loops_urls.dart';
import 'package:EdTestz/core/widgets/container_with_border.dart';
import 'package:EdTestz/core/widgets/custom_button.dart';

void showLogoutPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        content: ContainerWithBorder(
          borderRadius: 10.sp,
          width: MediaQuery.of(context).size.width / 1.02,
          height: 170.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Logout?',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: LoopsColors.colorBlack,
                ),
              ),
              Text(
                'Are you sure you want to logout?',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: LoopsColors.textColor,
                ),
              ),
              SizedBox(
                width: 200.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: ContainerWithBorder(
                        width: 80.w,
                        height: 40.h,
                        borderRadius: 12.sp,
                        boxColor: LoopsColors.lightGrey,
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: LoopsColors.textColor.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ),
                    CustomButton(
                      width: 80.w,
                      height: 40.h,
                      onTap: () {
                        Provider.of<AuthAppProvider>(context, listen: false)
                            .logout()
                            .then(
                          (value) {
                            Provider.of<OtherProvider>(context, listen: false)
                                .routeNames
                                .add('/signIn');
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              '/signIn',
                              (route) => false,
                            );
                          },
                        );
                      },
                      child: Text(
                        'Log out',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: LoopsColors.primaryColor,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}
