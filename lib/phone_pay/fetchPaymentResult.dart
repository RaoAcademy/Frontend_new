import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:EdTestz/core/utli/api_client.dart';

import '../core/utli/loops_urls.dart';

class FetchPaymentStatus extends StatefulWidget {
  FetchPaymentStatus(
      {Key? key,
      required this.amount,
      required this.coins,
      required this.subId,
      required this.mTID})
      : super(key: key);
  final String coins, mTID, amount, subId;
  @override
  State<FetchPaymentStatus> createState() => _FetchPaymentStatusState();
}

class _FetchPaymentStatusState extends State<FetchPaymentStatus> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPaymentData();
  }

  getPaymentData() async {
    try {
      debugPrint('inside check function of phone pe');
      FormData formData = FormData.fromMap({
        'userId': await APIClient().getUserId(),
        'coins': widget.coins,
        'amount': widget.amount,
        'subsId': widget.subId,
        'merchantTransactionId': widget.mTID,
      });
      debugPrint('form data body :: ${formData.fields}');
      final result =
          await Dio().post('https://raoacademy.com/fpayment/', data: formData);

      debugPrint('phone pe result :: ' + result.data['success'].toString());
      if (result.data['success'].toString() == 'true') {
        // showSuccessPopup(
        //     context, (value) {}, 'Payment Successful!');
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return Scaffold(
              backgroundColor: LoopsColors.primaryColor,
              body: Column(
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        'Payment Successful!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w600,
                          color: LoopsColors.colorWhite,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SvgPicture.asset(
                      'assets/images/other/success_icon.svg',
                      height: 80,
                      width: 80,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      // child: CustomButton(
                      //   width: 120.w,
                      //   onTap: () {

                      //   },
                      //   lable: 'Ok',
                      // ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 120.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: LoopsColors.tertiaryColor),
                          child: Text(
                            'Ok',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      } else {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return Scaffold(
              backgroundColor: LoopsColors.primaryColor,
              body: Column(
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        'Payment Failed!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w600,
                          color: LoopsColors.colorWhite,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Image.asset(
                      'assets/images/other/cross.png',
                      scale: 4,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      // child: CustomButton(
                      //   width: 120.w,
                      //   onTap: () {

                      //   },
                      //   lable: 'Ok',
                      // ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 120.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: LoopsColors.tertiaryColor),
                          child: Text(
                            'Ok',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
        // showSuccessPopup(
        //     context, (value) {}, 'Payment Failed!');
      }
    } on Exception catch (e) {
      if (e is DioError) {
        debugPrint(
            'Dio Error statusCode :: :: ${e.response?.statusCode} ||error :: ${e.error} || type :: ${e.type} || message :: ${e.message} || data :: ${e.response?.data}');
      } else {
        debugPrint('Dio Error :: $e');
      }
      // TODO
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: Colors.blueAccent,
        ),
      ),
    );
  }
}
