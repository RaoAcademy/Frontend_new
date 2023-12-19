import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rao_academy/application/other/other_provider.dart';
import 'package:rao_academy/core/utli/loops_urls.dart';
import 'package:rao_academy/core/widgets/container_with_border.dart';

class Support extends StatelessWidget {
  const Support({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            ContainerWithBorder(
              borderRadius: 4.sp,
              height: 64.h,
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 8.w,
                      right: 16.w,
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Provider.of<OtherProvider>(context, listen: false)
                            .routeNames
                            .remove(Provider.of<OtherProvider>(context,
                                    listen: false)
                                .routeNames
                                .last);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: LoopsColors.tertiaryColor,
                        size: 24.sp,
                      ),
                    ),
                  ),
                  Text(
                    'Support',
                    style: TextStyle(
                      color: LoopsColors.primaryColor,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Expanded(
              child: ContainerWithBorder(
                borderRadius: 4.sp,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.sp),
                          child: Text(
                            'CONTACT US',
                            style: TextStyle(
                              color: LoopsColors.colorBlack,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          "Can't find what you’re looking for",
                          style: TextStyle(
                            color: LoopsColors.textColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            ContainerWithBorder(
                              height: 64.sp,
                              width: 64.sp,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: LoopsColors.lightGrey,
                                  width: 1.sp,
                                ),
                                borderRadius: BorderRadius.circular(900),
                              ),
                              child: Icon(
                                Icons.phone_android,
                                size: 24.sp,
                                color: LoopsColors.primaryColor,
                              ),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Text(
                              'whatsapp',
                              style: TextStyle(
                                color: LoopsColors.textColor,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '+91 8431757301',
                              style: TextStyle(
                                color: LoopsColors.textColor,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            ContainerWithBorder(
                              height: 64.sp,
                              width: 64.sp,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: LoopsColors.lightGrey,
                                  width: 1.sp,
                                ),
                                borderRadius: BorderRadius.circular(900.sp),
                              ),
                              child: Icon(
                                Icons.mail,
                                size: 24.sp,
                                color: LoopsColors.primaryColor,
                              ),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Text(
                              'Mail',
                              style: TextStyle(
                                color: LoopsColors.textColor,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'support\n@raoacademy.com',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: LoopsColors.textColor,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.sp),
                          child: Text(
                            'WORKING HOURS',
                            style: TextStyle(
                              color: LoopsColors.colorBlack,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          'MON-SAT 09.00 AM TO 05.00 PM',
                          style: TextStyle(
                            color: LoopsColors.textColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'SUNDAY WE ARE CLOSED ',
                          style: TextStyle(
                            color: LoopsColors.textColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    // Text(
                    //   'OR',
                    //   style: TextStyle(
                    //     color: LoopsColors.textColor,
                    //     fontSize: 14.sp,
                    //     fontWeight: FontWeight.w600,
                    //   ),
                    // ),
                    // ContainerWithBorder(
                    //   height: 51.h,
                    //   width: 229.w,
                    //   boxColor: LoopsColors.tertiaryColor,
                    //   borderRadius: 8.sp,
                    //   padding: EdgeInsets.symmetric(horizontal: 24.w),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //     children: [
                    //       Icon(
                    //         Icons.phone,
                    //         size: 20.sp,
                    //         color: LoopsColors.primaryColor,
                    //       ),
                    //       Text(
                    //         'Request call back',
                    //         style: TextStyle(
                    //           color: LoopsColors.primaryColor,
                    //           fontSize: 16.sp,
                    //           fontWeight: FontWeight.w600,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    SizedBox(
                      height: 180.h,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
