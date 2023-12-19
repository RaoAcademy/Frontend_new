import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rao_academy/application/home/home_provider.dart';
import 'package:rao_academy/core/utli/loops_urls.dart';
import 'package:rao_academy/domain/entities/subcriptions.dart';
import 'package:rao_academy/presentation/other/widgets/subscription_ui.dart';

Future showSubscriptionPopup(
    BuildContext context, Subscriptions subscriptions) {
  return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(12.sp))),
      backgroundColor: LoopsColors.colorWhite,
      builder: (context) => AnimatedPadding(
            duration: Duration(
              milliseconds: 150,
            ),
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Consumer<HomeProvider>(builder: (context, value, child) {
              return Container(
                child: SubscriptionBottomsheet(
                  subscriptions: subscriptions,
                ),
              );
            },),
          ));
}
