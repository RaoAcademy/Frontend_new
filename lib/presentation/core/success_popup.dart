// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:EdTestz/core/utli/loops_urls.dart';

bool _pop = false;

class LoaderPopup extends StatefulWidget {
  const LoaderPopup({
    Key? key,
    required this.getValue,
    required this.text,
  }) : super(key: key);
  final ValueChanged<BuildContext> getValue;
  final String text;

  @override
  State<LoaderPopup> createState() => _LoaderPopupState();
}

class _LoaderPopupState extends State<LoaderPopup> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    widget.getValue.call(context);
    return Scaffold(
      backgroundColor: LoopsColors.primaryColor,
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Text(
                "Payment Success..",
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
            child: SvgPicture.asset('assets/images/other/success_icon.svg'),
          ),
          Expanded(
            child: Center(
              child: Container(
                alignment: Alignment.center,
                width: 120.w,
                height: 40.h,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0),color: LoopsColors.tertiaryColor),
                child: Text("Ok",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w700),),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> showSuccessPopup(BuildContext context,
    ValueChanged<BuildContext> getValue, String text) async {
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (_) {
      return LoaderPopup(getValue: getValue, text: text);
    },
  );
}
