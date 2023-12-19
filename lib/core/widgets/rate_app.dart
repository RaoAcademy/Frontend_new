import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rao_academy/application/other/other_provider.dart';
import 'package:rao_academy/core/utli/loops_urls.dart';
import 'package:rao_academy/core/widgets/container_with_border.dart';
import 'package:rao_academy/core/widgets/custom_button.dart';
import 'package:url_launcher/url_launcher.dart';

int _ratings = -1;
bool _rated = false;

void rateApp(BuildContext context, OtherProvider provider) {
  // context.watch<OtherProvider>();
  showDialog(
    context: context,
    builder: (_) {
      _.watch<OtherProvider>();
      return AlertDialog(
        content: ContainerWithBorder(
          borderRadius: 10.sp,
          width: MediaQuery.of(context).size.width / 1.02,
          height: _rated ? 200.h : 170.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Rate the App',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: LoopsColors.colorBlack,
                ),
              ),
              Center(
                child: SizedBox(
                  height: 50.h,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return IconButton(
                          onPressed: () {
                            _rated = true;
                            provider.setState();
                            _ratings = index + 1;
                          },
                          icon: Icon(
                            _ratings <= index
                                ? Icons.star_border_outlined
                                : Icons.star,
                            size: 40.sp,
                            color: _ratings <= index
                                ? LoopsColors.textColor.withOpacity(0.6)
                                : LoopsColors.tertiaryColor,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              // if (_rated)
              //   const CustomTextField(
              //     borderAround: true,
              //     hintText: 'Please write your review here',
              //   ),
              if (!_rated)
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Not now',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: LoopsColors.textColor,
                    ),
                  ),
                ),
              if (_rated)
                CustomButton(
                  lable: 'Post',
                  onTap: () {
                    if(_ratings > 2){
                      launchUrl(Uri.parse("https://play.google.com/store/apps/details?id=com.app.raoacademy"),mode: LaunchMode.externalApplication);
                    }
                    Navigator.pop(context);
                  },
                )
            ],
          ),
        ),
      );
    },
  );
}
