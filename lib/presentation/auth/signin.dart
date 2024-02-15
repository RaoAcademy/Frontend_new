import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:EdTestz/application/auth/auth_provider.dart';
import 'package:EdTestz/application/other/other_provider.dart';
import 'package:EdTestz/core/theme/custom_scroll_behaviour.dart';
import 'package:EdTestz/core/utli/logger.dart';
import 'package:EdTestz/core/utli/loops_urls.dart';
import 'package:EdTestz/core/utli/validations.dart';
import 'package:EdTestz/core/widgets/custom_button.dart';
import 'package:EdTestz/core/widgets/custom_text_field.dart';

final _formKey = GlobalKey<FormState>();

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthAppProvider>();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(35.sp),
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: ListView(
            children: [
              SizedBox(
                height: 60.h,
              ),
              /* SvgPicture.asset(
                'assets/icons/logos/loops.svg',
                color: LoopsColors.secondaryColor,
                matchTextDirection: true,
                height: 38.h,
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
              Form(
                key: _formKey,
                child: CustomTextField(
                  prefixIcon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 12.w, right: 12.sp),
                        child: Text(
                          '+91',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            letterSpacing: 2.sp,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // textAlign: TextAlign.center,
                  textStyle: TextStyle(
                    letterSpacing: 2.sp,
                  ),
                  // suffixIcon: Container(),
                  controller: authProvider.phoneController,
                  hintText: 'Mobile Number',
                  inputType: TextInputType.phone,
                  validator: LoopsValidation.phoneNumber,
                  onTap: () {
                    _formKey.currentState!.reset();
                  },
                  maxLength: 10,
                ),
              ),
              SizedBox(
                height: 90.h,
              ),
              CustomButton(
                color: LoopsColors.secondaryColor,
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    authProvider
                        .getOtp(authProvider.phoneController.text, context)
                        .onError((error, stackTrace) {
                      logger.e(error);
                    }).then((value) {
                      Provider.of<OtherProvider>(context, listen: false)
                          .routeNames
                          .add('/signInOTP');
                      Navigator.pushNamed(
                        context,
                        '/signInOTP',
                      );
                    });
                  }
                },
                child: Text(
                  'Request OTP',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: LoopsColors.colorWhite,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
