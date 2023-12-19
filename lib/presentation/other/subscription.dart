import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:rao_academy/application/home/home_provider.dart';
import 'package:rao_academy/application/other/other_provider.dart';
// import 'package:rao_academy/application/other/other_provider.dart';
import 'package:rao_academy/core/theme/custom_scroll_behaviour.dart';
import 'package:rao_academy/core/utli/loops_urls.dart';
import 'package:rao_academy/core/widgets/container_with_border.dart';
import 'package:rao_academy/core/widgets/show_bottom_sheet.dart';
import 'package:rao_academy/core/widgets/unorderd_list.dart';
import 'package:rao_academy/presentation/other/widgets/subscription_popup.dart';

class Subcription extends StatelessWidget {
  const Subcription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("SUBS");
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            ContainerWithBorder(
              boxShadow: [
                BoxShadow(
                    blurRadius: 10,
                    color: LoopsColors.lightGrey.withOpacity(0.4),
                    offset: Offset(5.sp, 5.sp))
              ],
              height: 64.h,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Provider.of<OtherProvider>(context, listen: false)
                          .routeNames
                          .remove(
                              Provider.of<OtherProvider>(context, listen: false)
                                  .routeNames
                                  .last);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: LoopsColors.tertiaryColor,
                      size: 24.sp,
                    ),
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  Text(
                    'Subscription',
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: LoopsColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            ContainerWithBorder(
              width: MediaQuery.of(context).size.width,
              borderRadius: 10.sp,
              // margin: EdgeInsets.symmetric(horizontal: 1.w),

              boxShadow: [
                BoxShadow(
                    blurRadius: 10,
                    color: LoopsColors.lightGrey.withOpacity(0.4),
                    offset: Offset(5.sp, 5.sp))
              ],
              child: Column(
                children: [
                  Stack(
                    children: [
                      ContainerWithBorder(
                        margin: EdgeInsets.symmetric(
                          vertical: 24.h,
                          horizontal: 4.w,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                        ),
                        borderColor: LoopsColors.colorGrey,
                        height: 70.h,
                        borderRadius: 4.sp,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              (Provider.of<HomeProvider>(context, listen: false)
                                              .subscriptionEntity
                                              .activePlans !=
                                          null &&
                                      Provider.of<HomeProvider>(context,
                                              listen: false)
                                          .subscriptionEntity
                                          .activePlans!
                                          .isNotEmpty)
                                  ? Provider.of<HomeProvider>(context,
                                          listen: false)
                                      .subscriptionEntity
                                      .activePlans!
                                      .first
                                      .subsName!
                                  : Provider.of<HomeProvider>(context,
                                          listen: false)
                                      .subscriptionEntity
                                      .pastPlans!
                                      .first
                                      .subsName!,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  height: 16.h,
                                ),
                                SizedBox(
                                  width: 140.w,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      if (!(Provider.of<HomeProvider>(context,
                                                      listen: false)
                                                  .subscriptionEntity
                                                  .activePlans !=
                                              null &&
                                          Provider.of<HomeProvider>(context,
                                                  listen: false)
                                              .subscriptionEntity
                                              .activePlans!
                                              .isEmpty))
                                        Container()
                                      else
                                        ContainerWithBorder(
                                          boxColor: LoopsColors.colorRed,
                                          width: 70.w,
                                          height: 20.h,
                                          borderRadius: 12.sp,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              ContainerWithBorder(
                                                boxColor:
                                                    LoopsColors.colorWhite,
                                                width: 8.sp,
                                                height: 8.sp,
                                                borderRadius: 12.sp,
                                              ),
                                              Text(
                                                'Expired',
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: LoopsColors.colorWhite,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      Text(
    Provider.of<HomeProvider>(context, listen: false).subscriptionEntity.activePlans!.isNotEmpty ? '${Provider.of<HomeProvider>(context, listen: false).subscriptionEntity.activePlans!.first.numberOfTests ?? 0} Tests' : '0 Tests',
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 4.sp,
                                ),
                                Row(
                                  children: [
                                    Text(
                                Provider.of<HomeProvider>(context, listen: false).subscriptionEntity.activePlans!.isNotEmpty ? '${Provider.of<HomeProvider>(context, listen: false).subscriptionEntity.activePlans!.first.testsRemaining ?? 0} Tests available' : '0 Tests available',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                        color: LoopsColors.textColor
                                            .withOpacity(0.5),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 4.w,
                                      ),
                                      child: SvgPicture.asset(
                                        'assets/icons/logos/line.svg',
                                        color: LoopsColors.tertiaryColor,
                                        matchTextDirection: true,
                                        height: 16.h,
                                        width: 2.sp,
                                      ),
                                    ),
                                    Text(
                                      Provider.of<HomeProvider>(context, listen: false).subscriptionEntity.activePlans!.isNotEmpty ? 'Expires on ${Provider.of<HomeProvider>(context, listen: false).subscriptionEntity.activePlans!.first.expiryDate ?? '2020-01-01'}' : 'Expires on 2020-01-01',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                        color: LoopsColors.textColor
                                            .withOpacity(0.5),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Center(
                        child: ContainerWithBorder(
                          borderRadius: 4.sp,
                          margin: EdgeInsets.symmetric(vertical: 12.h),
                          boxColor: LoopsColors.lightGrey,
                          width: 112.w,
                          height: 25.h,
                          child: Text(
                            'Current Plan',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ContainerWithBorder(
                    margin: EdgeInsets.only(
                      left: 4.w,
                      right: 4.w,
                      bottom: 12.h,
                    ),
                    boxColor: LoopsColors.lightGrey.withOpacity(0.4),
                    borderRadius: 12.sp,
                    borderColor: LoopsColors.primaryColor,
                    child: Column(
                      children: [
                        ContainerWithBorder(
                          height: 55.h,
                          boxColor: LoopsColors.primaryColor,
                          borderR: BorderRadius.only(
                              topLeft: Radius.circular(12.sp),
                              topRight: Radius.circular(12.sp)),
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Rao Academy',
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700,
                                  color: LoopsColors.colorWhite,
                                ),
                              ),
                              /* Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/logos/loops.svg',
                                    color: LoopsColors.tertiaryColor,
                                    matchTextDirection: true,
                                    height: 12.h,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 4.w,
                                    ),
                                    child: SvgPicture.asset(
                                      'assets/icons/logos/line.svg',
                                      color: LoopsColors.colorWhite,
                                      matchTextDirection: true,
                                      height: 16.h,
                                    ),
                                  ),
                                  Text(
                                    'Loops',
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w700,
                                      color: LoopsColors.colorWhite,
                                    ),
                                  )
                                ],
                              ), */
                              Text(
                                'PREMIUM',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: LoopsColors.colorWhite,
                                ),
                              )
                            ],
                          ),
                        ),
                        ContainerWithBorder(
                          boxColor: LoopsColors.colorWhite,
                          borderRadius: 12.sp,
                          // borderWidth: 1.sp,
                          borderColor: LoopsColors.primaryColor,
                          height: (419 - 55).h,
                          child: ScrollConfiguration(
                            behavior: MyBehavior(),
                            child: ListView.builder(
                              // physics: const NeverScrollableScrollPhysics(),
                              itemCount: Provider.of<HomeProvider>(context,
                                      listen: false)
                                  .subscriptionEntity
                                  .subscriptions!
                                  .length,
                              itemBuilder: (BuildContext context, int i) =>
                                  InkWell(
                                onTap: () {
                                  showSubscriptionPopup(
                                      context,
                                      Provider.of<HomeProvider>(context,
                                              listen: false)
                                          .subscriptionEntity
                                          .subscriptions![i]);
                                },
                                child: ContainerWithBorder(
                                  margin: EdgeInsets.symmetric(
                                    vertical: 6.h,
                                    horizontal: 6.w,
                                  ),
                                  boxColor: LoopsColors.colorWhite,
                                  borderColor: LoopsColors.primaryColor,
                                  borderRadius: 10.sp,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 24.w,
                                    vertical: 6.h,
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                '${Provider.of<HomeProvider>(context, listen: false).subscriptionEntity.subscriptions![i].subsName}',
                                                style: TextStyle(
                                                  fontSize: 17.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                      LoopsColors.primaryColor,
                                                ),
                                              ),
                                              if (Provider.of<HomeProvider>(
                                                          context,
                                                          listen: false)
                                                      .subscriptionEntity
                                                      .subscriptions![i]
                                                      .comment !=
                                                  '')
                                                ContainerWithBorder(
                                                  width: 80.w,
                                                  height: 18.h,
                                                  boxColor:
                                                      LoopsColors.tertiaryColor,
                                                  borderRadius: 12.sp,
                                                  margin: EdgeInsets.only(
                                                      left: 6.sp),
                                                  child: Text(
                                                    '${Provider.of<HomeProvider>(context, listen: false).subscriptionEntity.subscriptions![i].comment}',
                                                    style: TextStyle(
                                                      fontSize: 10.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: LoopsColors
                                                          .primaryColor,
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              SizedBox(
                                                height: 10.sp,
                                              ),
                                              Text(
                                                '₹ ${Provider.of<HomeProvider>(context, listen: false).subscriptionEntity.subscriptions![i].price}',
                                                style: TextStyle(
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: LoopsColors.textColor,
                                                ),
                                              ),
                                              Text(
                                                '₹ ${Provider.of<HomeProvider>(context, listen: false).subscriptionEntity.subscriptions![i].strikedPrice}',
                                                style: TextStyle(
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  fontSize: 10.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: LoopsColors.textColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 4.h,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '${Provider.of<HomeProvider>(context, listen: false).subscriptionEntity.subscriptions![i].numberOfTests} Tests',
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w600,
                                              color: LoopsColors.textColor
                                                  .withOpacity(0.5),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 4.w,
                                            ),
                                            child: SvgPicture.asset(
                                              'assets/icons/logos/line.svg',
                                              color: LoopsColors.tertiaryColor,
                                              matchTextDirection: true,
                                              height: 16.h,
                                            ),
                                          ),
                                          Text(
                                            'Max Coins: ${Provider.of<HomeProvider>(context, listen: false).subscriptionEntity.subscriptions![i].maxReedemableCoins}',
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w600,
                                              color: LoopsColors.textColor
                                                  .withOpacity(0.5),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 4.w,
                                            ),
                                            child: SvgPicture.asset(
                                              'assets/icons/logos/line.svg',
                                              color: LoopsColors.tertiaryColor,
                                              matchTextDirection: true,
                                              height: 16.h,
                                            ),
                                          ),
                                          Text(
                                            'Validity: ${Provider.of<HomeProvider>(context, listen: false).subscriptionEntity.subscriptions![i].validity}',
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w600,
                                              color: LoopsColors.textColor
                                                  .withOpacity(0.5),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 120.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            loopsBottomSheet(
                              context,
                              Column(
                                children: const [
                                  UnorderedListItem(
                                      'We do not offer refund on this plan'),
                                  UnorderedListItem(
                                      'Incase of an auto renewal cycle, you can place arequest to discontinue your plan at any time. However, the cancellation will take effectonly at the end of the billing cycle thus allowing the content to be available for that billing cycle'),
                                ],
                              ),
                              'Frequently Asked Questions',
                            );
                          },
                          child: Text(
                            'Frequently Asked Questions',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: LoopsColors.textColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
