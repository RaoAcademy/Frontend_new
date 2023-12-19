// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:rao_academy/application/home/home_provider.dart';
import 'package:rao_academy/application/payment/payment_provider.dart';
import 'package:rao_academy/core/utli/error_handle.dart';
import 'package:rao_academy/core/utli/loops_urls.dart';
import 'package:rao_academy/core/widgets/container_with_border.dart';
import 'package:rao_academy/core/widgets/custom_button.dart';
import 'package:rao_academy/domain/entities/subcriptions.dart';
import 'package:rao_academy/phone_pay/pone_pay.dart';

TextEditingController _controller = TextEditingController();

class SubscriptionBottomsheet extends StatefulWidget {
  const SubscriptionBottomsheet({
    Key? key,
    required this.subscriptions,
  }) : super(key: key);
  final Subscriptions subscriptions;

  @override
  State<SubscriptionBottomsheet> createState() => _SubscriptionBottomsheetState();
}

class _SubscriptionBottomsheetState extends State<SubscriptionBottomsheet> {
  bool _isSubscriptionBottomOpen = false;
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeProvider>();
    final paymentProvider = context.watch<PaymentProvider>();
    return SingleChildScrollView(
      child: Container(
        //  height: _isSubscriptionBottomOpen ? MediaQuery.of(context).size.height / 1.4 : MediaQuery.of(context).size.height / 1.9,
        child: Padding(
          padding: EdgeInsets.all(24.sp),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.subscriptions.subsName!,
                          style: TextStyle(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w600,
                            color: LoopsColors.primaryColor,
                          ),
                        ),
                        /* ContainerWithBorder(
                                width: 88.w,
                                boxColor: LoopsColors.tertiaryColor,
                                borderRadius: 12.sp,
                                child: Text(
                                  'Recomended',
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w600,
                                    color: LoopsColors.primaryColor,
                                  ),
                                ),
                              ), */
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          '₹ ${widget.subscriptions.price}',
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: LoopsColors.textColor,
                          ),
                        ),
                        Text(
                          '₹ ${widget.subscriptions.strikedPrice}',
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                            color: LoopsColors.textColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              Row(
                children: [
                  Text(
                    '${widget.subscriptions.numberOfTests} Tests',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: LoopsColors.textColor.withOpacity(0.5),
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
                    'Max Coins: ${widget.subscriptions.maxReedemableCoins}',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: LoopsColors.textColor.withOpacity(0.5),
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
                    'Validity: ${widget.subscriptions.validity}',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: LoopsColors.textColor.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              ContainerWithBorder(
                borderColor: LoopsColors.primaryColor,
                borderRadius: 10.sp,
                height: 42.h,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Redeem',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: LoopsColors.textColor,
                        ),
                      ),
                      Stack(
                        children: [
                          SvgPicture.asset(
                            'assets/images/other/coupon_value.svg',
                          ),
                          Positioned(
                            right: 16.w,
                            top: 0,
                            bottom: 0,
                            child: Center(
                              child: Text(
                                '${widget.subscriptions.yourReedemableCoins ?? 0}',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: LoopsColors.colorWhite,
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              ContainerWithBorder(
                borderColor: LoopsColors.primaryColor,
                borderRadius: 10.sp,
                height: 42.h,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 140.w,
                        child: TextFormField(
                          onTap: () {
                            setState(() {
                              _isSubscriptionBottomOpen = true;
                            });
                          },
                            style: TextStyle(fontSize: 14.sp),
                            controller: _controller,
                            textCapitalization: TextCapitalization.characters,
                            scrollPadding: EdgeInsets.all(20),
                            decoration: InputDecoration(
                              hintText: 'Enter Coupon Code',
                              hintStyle: TextStyle(
                                  fontSize: 10.sp,
                                  color: LoopsColors.textColor.withOpacity(0.5)),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            onFieldSubmitted: (value) {
                              setState(() {
                                _isSubscriptionBottomOpen = false;
                              });
                            },
                            onChanged: (value) {
                              provider.couponEntity.value = 0;
                              provider.setState();
                            }),
                      ),
                      ContainerWithBorder(
                        height: 26.h,
                        width: 80.w,
                        boxColor: LoopsColors.secondaryColor,
                        borderRadius: 4.sp,
                        child: InkWell(
                          onTap: () {
                            provider.fcoupon(_controller.text).then((_) {
                              if (provider.couponEntity.error != null) {
                                handleError(provider.couponEntity.error);
                              }
                            });
                          },
                          child: Text(
                            'Apply',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: LoopsColors.colorWhite,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ExpandableNotifier(
                  initialExpanded: false,
                  child: ScrollOnExpand(
                    child: ExpandablePanel(
                      theme: const ExpandableThemeData(
                        hasIcon: false,
                        tapHeaderToExpand: true,
                        tapBodyToCollapse: false,
                        tapBodyToExpand: true,
                      ),
                      header: Builder(builder: (context) {
                        final controller =
                            ExpandableController.of(context, required: true)!;

                        return Padding(
                          padding: EdgeInsets.only(right: 1.w, top: 10.h),
                          child: ContainerWithBorder(
                            decoration: BoxDecoration(
                              color: LoopsColors.colorWhite,
                              border: Border.all(
                                color: LoopsColors.primaryColor,
                                width: 0.5.sp,
                              ),
                              borderRadius: BorderRadius.only(
                                bottomLeft: controller.expanded
                                    ? Radius.zero
                                    : Radius.circular(10.sp),
                                bottomRight: controller.expanded
                                    ? Radius.zero
                                    : Radius.circular(10.sp),
                                topLeft: Radius.circular(10.sp),
                                topRight: Radius.circular(10.sp),
                              ),
                            ),
                            height: 42.h,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'You Pay',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          color: LoopsColors.colorBlack,
                                        ),
                                      ),
                                      if ((widget.subscriptions.gstAmount ?? 0) > 0)
                                        Text(
                                          '(incl..GST)',
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w300,
                                            color: LoopsColors.textColor,
                                          ),
                                        ),
                                    ],
                                  ),
                                  Center(
                                    child: Row(
                                      children: [
                                        Text(
                                          '₹ ${widget.subscriptions.youPay! - (provider.couponEntity.value ?? 0)}/-',
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600,
                                            color: LoopsColors.textColor,
                                          ),
                                        ),
                                        Icon(
                                          controller.expanded
                                              ? Icons.arrow_drop_up
                                              : Icons.arrow_drop_down,
                                          size: 24.sp,
                                          color: LoopsColors.textColor,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                      collapsed: Container(),
                      expanded: Container(

                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 20.h),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: LoopsColors.primaryColor,
                            width: 0.5.sp,
                          ),
                          color: LoopsColors.colorWhite,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10.sp),
                              bottomRight: Radius.circular(10.sp)),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Subscription Price',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w300,
                                    color: LoopsColors.colorBlack,
                                  ),
                                ),
                                Text(
                                  '₹ ${widget.subscriptions.strikedPrice}',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: LoopsColors.colorBlack,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Special Discount Price',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w300,
                                    color: LoopsColors.colorBlack,
                                  ),
                                ),
                                Text(
                                  '₹ ${widget.subscriptions.price}',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: LoopsColors.colorBlack,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Coins Reedemed Discount',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w300,
                                    color: LoopsColors.colorBlack,
                                  ),
                                ),
                                Text(
                                  '₹ ${widget.subscriptions.yourReedemableCoins}',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: LoopsColors.colorBlack,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            if ((provider.couponEntity.value ?? 0) != 0)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Coupon Discount',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w300,
                                      color: LoopsColors.colorBlack,
                                    ),
                                  ),
                                  Text(
                                    '₹ ${provider.couponEntity.value}',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color: LoopsColors.colorBlack,
                                    ),
                                  ),
                                ],
                              ),
                            if ((provider.couponEntity.value ?? 0) != 0)
                              SizedBox(
                                height: 4.h,
                              ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Internet Hadling Charges',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w300,
                                    color: LoopsColors.colorBlack,
                                  ),
                                ),
                                Text(
                                  '₹ ${provider.subscriptionEntity.internetHandling}',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: LoopsColors.colorBlack,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'G.S.T.(18%)',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w300,
                                    color: LoopsColors.colorBlack,
                                  ),
                                ),
                                Text(
                                  '₹ ${widget.subscriptions.gstAmount}',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: LoopsColors.colorBlack,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomButton(
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PhonePayApp(
                                amount: (widget.subscriptions.youPay! -
                                    (provider.couponEntity.value ?? 0)),
                                coins: provider
                                    .subscriptionEntity.internetHandling
                                    .toString(),
                                subId: widget.subscriptions.subsId!.toString(),
                                coupenId:
                                    provider.couponEntity.couponId.toString(),
                                userId: "1",
                              )));
                  // await PhonePayServices.initPayemnt(
                  //      'com.google.android.apps.walletnfcrel',
                  //      subscriptions.price! - (provider.couponEntity.value ?? 0),context);
                  // add payment here.
                  // paymentProvider
                  //     .fpayment(
                  //         // coins: subscriptions.maxReedemableCoins,
                  //         coins: provider.subscriptionEntity.internetHandling,
                  //         subsId: subscriptions.subsId!,
                  //         couponId: provider.couponEntity.couponId,
                  //         paymentMethod: 'upi')
                  //     .onError((error, stackTrace) => handleError(error))
                  //     .then((value) => paymentProvider
                  //         .initPlatformState(r'order_1626945143520')
                  //         .onError((error, stackTrace) => handleError(error))
                  //         .then((value) => showSuccessPopup(context, (value) {},
                  //             'Payment Successful!') /* ) */));
                },
                color: LoopsColors.primaryColor,
                child: Text(
                  'Proceed to Pay',
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: LoopsColors.colorWhite,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                /* child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Pay ',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: LoopsColors.primaryColor,
                      ),
                    ),
                    Text(
                      '₹ ${subscriptions.youPay! - (provider.couponEntity.value ?? 0)}',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: LoopsColors.colorWhite,
                      ),
                    ),
                  ],
                ), */
              ),
              SizedBox(
                height: 22.h,
              ),
              /* Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Text(
                  //   '*One loops test is equal to 5 normal tests',
                  //   style:
                  //       appTheme.textTheme.bodyMedium!.copyWith(fontSize: 8.sp),
                  // ),
                  // Text(
                  //   ' | ',
                  //   style:
                  //       appTheme.textTheme.bodyMedium!.copyWith(fontSize: 8.sp),
                  // ),

                  InkWell(
                    onTap: () {
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
                        'Terms and Conditions',
                      );
                    },
                    child: Text(
                      'Terms & Conditions',
                      style: appTheme.textTheme.titleLarge!
                          .copyWith(fontSize: 10.sp, color: LoopsColors.colorRed),
                    ),
                  ),
                ],
              ), */
            ],
          ),
        ),
      ),
    );
  }
}
