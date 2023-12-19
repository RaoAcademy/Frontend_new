import 'package:curved_progress_bar/curved_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:rao_academy/application/auth/auth_provider.dart';
import 'package:rao_academy/core/theme/custom_scroll_behaviour.dart';
import 'package:rao_academy/core/theme/theme.dart';
import 'package:rao_academy/core/utli/loops_urls.dart';
import 'package:rao_academy/core/widgets/container_with_border.dart';
import 'package:rao_academy/core/widgets/custom_button.dart';

final _formKey = GlobalKey<FormState>();

class SignInOTP extends StatelessWidget {
  const SignInOTP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthProvider>();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: ListView(
          // physics: const NeverScrollableScrollPhysics(),
          children: [
            SizedBox(
              height: 60.h,
            ),
            /* Center(
              child: SvgPicture.asset(
                'assets/icons/logos/loops.svg',
                color: LoopsColors.secondaryColor,
                matchTextDirection: true,
                height: 38.h,
              ),
            ), */
            SizedBox(
              height: 30.h,
            ),
            Center(
              child: Text(
                'Hey there!',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                  color: LoopsColors.colorBlack,
                ),
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            Center(
              child: Text(
                'Just add your number',
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: 60.h,
            ),
            Center(
              child: ContainerWithBorder(
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                height: 418.h,
                width: 371.w,
                borderRadius: 12.sp,
                borderColor: LoopsColors.textColor,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10,
                      color: LoopsColors.colorGrey.withOpacity(0.2),
                      offset: Offset(5.sp, 5.sp))
                ],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 22.w),
                      // child: SvgPicture.asset('assets/images/auth/mobile.svg'),
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    Text(
                      'OTP Verification',
                      style: appTheme.textTheme.headlineMedium,
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    Text(
                      'Enter the Code sent to ${authProvider.phoneController.text}',
                      style: appTheme.textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                    // Padding(
                    //   padding:
                    //       EdgeInsets.symmetric(vertical: 20, horizontal: 32.w),
                    //   child: Form(
                    //     key: _formKey,
                    //     child: TextField(
                    //       controller: authProvider.otpController,textAlign: TextAlign.center,maxLength: 6,
                    //     decoration: InputDecoration(isDense: true,))
                    //     /*PinCodeTextField(
                    //       controller: authProvider.otpController,
                    //       cursorColor: LoopsColors.textColor,
                    //       pinTheme: PinTheme(
                    //         activeColor: LoopsColors.textColor,
                    //         inactiveColor: LoopsColors.textColor,
                    //         selectedColor: LoopsColors.secondaryColor,
                    //       ),
                    //       onTap: () {
                    //         _formKey.currentState!.reset();
                    //       },
                    //       errorTextSpace: 24.sp,
                    //       // controller: _controller,
                    //       autoFocus: true,
                    //       appContext: context,
                    //       textStyle:
                    //           Theme.of(context).textTheme.titleLarge!.copyWith(
                    //                 color: LoopsColors.textColor,
                    //               ),
                    //       length: 6,
                    //       keyboardType: TextInputType.number,
                    //       onChanged: (value) {},
                    //       validator: (v) {
                    //         if (v!.length == 6) {
                    //           return '';
                    //         } else {
                    //           return 'Invalid OTP';
                    //         }
                    //       },
                    //       onCompleted: (value) async {},
                    //     )*/,
                    //   ),
                    // ),
                    Padding(
                      padding:
                      EdgeInsets.symmetric(vertical: 20, horizontal: 32.w),
                      child: Form(
                        key: _formKey,
                        child: PinCodeTextField(
                          controller: authProvider.otpController,
                          cursorColor: LoopsColors.textColor,
                          pinTheme: PinTheme(
                            activeColor: LoopsColors.textColor,
                            inactiveColor: LoopsColors.textColor,
                            selectedColor: LoopsColors.secondaryColor,
                          ),
                          onTap: () {
                            _formKey.currentState!.reset();
                          },
                          errorTextSpace: 24.sp,
                          // controller: _controller,
                          autoFocus: true,
                          appContext: context,
                          textStyle:
                          Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: LoopsColors.textColor,
                          ),
                          length: 6,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {},
                          validator: (v) {
                            if (v!.length == 6) {
                              return '';
                            } else {
                              return 'Invalid OTP';
                            }
                          },
                          onCompleted: (value) async {},
                        ),
                      ),
                    ),
                    Text(
                      'Didnt receive OTP code?',
                      style: appTheme.textTheme.bodyMedium,
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    TextButton(
                      onPressed: () => authProvider
                          .getOtp(authProvider.phoneController.text, context)
                          .then(
                            (value) =>
                                Fluttertoast.showToast(msg: 'OTP resent!'),
                          ),
                      child: Text(
                        'Resend Code',
                        style: appTheme.textTheme.titleLarge!
                            .copyWith(color: LoopsColors.colorRed),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 42.w, vertical: 12.h),
                      child: CustomButton(
                        color: LoopsColors.secondaryColor,
                        onTap: () async {
                          if (authProvider.otpController.text.length == 6) {
                            /* context
                                .read<AuthProvider>()
                                .validateOtp(context.read<AuthProvider>().otp)
                                .then((_) { */

                            otpSink.add(authProvider.otpController.text);
                            await showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (_) => const Center(
                                child: CurvedCircularProgressIndicator(),
                              ),
                            );
                              //
                              // Navigator.pushNamedAndRemoveUntil(
                              //   context,
                              //   '/signUpForm',
                              //   (route) => false,
                              // ).onError((error, stackTrace) => Fluttertoast.showToast(msg: error.toString()));

        // .onError((error, stackTrace) {
        //                       Fluttertoast.showToast(msg: error.toString());
        //                       Navigator.pushNamedAndRemoveUntil(
        //                         context,
        //                         '/signUpForm',
        //                         (route) => false,
        //                       );
        //                     }));
                          }
                        },
                        child: Text(
                          'Verify & Proceed',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: LoopsColors.colorWhite,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            /* SizedBox(
              height: 90.h,
            ),
            CustomButton(
              onTap: () {},
              lable: 'Request OTP',
            ) */
          ],
        ),
      ),
    );
  }
}
