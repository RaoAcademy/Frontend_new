import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_share/flutter_share.dart';
import 'package:provider/provider.dart';
import 'package:rao_academy/application/home/home_provider.dart';
import 'package:rao_academy/application/other/other_provider.dart';
import 'package:rao_academy/core/utli/copy_text.dart';
import 'package:rao_academy/core/utli/loops_urls.dart';
import 'package:rao_academy/core/widgets/container_with_border.dart';
import 'package:rao_academy/core/widgets/earned_rewards.dart';
import 'package:share_plus/share_plus.dart';
// import 'package:rao_academy/core/widgets/pie_chart.dart';

// bool _showEarned = false;

class Refer extends StatelessWidget {
  const Refer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeProvider>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            ContainerWithBorder(
              height: 64.h,
              margin: EdgeInsets.all(8.sp),
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
                    'Refer a Friend',
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: LoopsColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
            ContainerWithBorder(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.25,
              margin: EdgeInsets.all(8.sp),
              padding: EdgeInsets.all(8.sp),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              // showDialog(
                              //     context: context,
                              //     builder: (context2) {
                              //       return AlertDialog(
                              //         content: SizedBox(
                              //           /*  boxColor:
                              //               LoopsColors.colorWhite.withOpacity(0.0),
                              //           borderColor: LoopsColors.primaryColor,
                              //           padding: EdgeInsets.all(12.sp), */
                              //           width:
                              //               MediaQuery.of(context2).size.width,
                              //           height: 220.h,
                              //           child: Column(
                              //             children: [
                              //               Row(
                              //                 mainAxisAlignment:
                              //                     MainAxisAlignment
                              //                         .spaceBetween,
                              //                 children: [
                              //                   Text(
                              //                     'How it works',
                              //                     style: TextStyle(
                              //                       color: LoopsColors
                              //                           .primaryColor,
                              //                       fontSize: 14.sp,
                              //                       fontWeight: FontWeight.w600,
                              //                     ),
                              //                   ),
                              //                   IconButton(
                              //                     onPressed: () {
                              //                       Navigator.pop(context);
                              //                     },
                              //                     icon: Icon(
                              //                       Icons.close,
                              //                       color: LoopsColors
                              //                           .tertiaryColor,
                              //                       size: 24.sp,
                              //                     ),
                              //                   )
                              //                 ],
                              //               ),
                              //               SizedBox(
                              //                 height: 22.h,
                              //               ),
                              //               Row(
                              //                 mainAxisAlignment:
                              //                     MainAxisAlignment
                              //                         .spaceBetween,
                              //                 crossAxisAlignment:
                              //                     CrossAxisAlignment.start,
                              //                 children: [
                              //                   Text(
                              //                     'Step 1:',
                              //                     style: TextStyle(
                              //                       color:
                              //                           LoopsColors.textColor,
                              //                       fontSize: 12.sp,
                              //                       fontWeight: FontWeight.w600,
                              //                     ),
                              //                   ),
                              //                   SizedBox(
                              //                     width: MediaQuery.of(context2)
                              //                             .size
                              //                             .width /
                              //                         2,
                              //                     child: Text(
                              //                       'Share the app link with your friend',
                              //                       style: TextStyle(
                              //                         color:
                              //                             LoopsColors.textColor,
                              //                         fontSize: 12.sp,
                              //                         fontWeight:
                              //                             FontWeight.w600,
                              //                       ),
                              //                       maxLines: 3,
                              //                     ),
                              //                   ),
                              //                 ],
                              //               ),
                              //               Row(
                              //                 mainAxisAlignment:
                              //                     MainAxisAlignment
                              //                         .spaceBetween,
                              //                 crossAxisAlignment:
                              //                     CrossAxisAlignment.start,
                              //                 children: [
                              //                   Text(
                              //                     'Step 2:',
                              //                     style: TextStyle(
                              //                       color:
                              //                           LoopsColors.textColor,
                              //                       fontSize: 12.sp,
                              //                       fontWeight: FontWeight.w600,
                              //                     ),
                              //                   ),
                              //                   SizedBox(
                              //                     width: MediaQuery.of(context2)
                              //                             .size
                              //                             .width /
                              //                         2,
                              //                     child: Text(
                              //                       'Once your friend registers and purchase any pack ',
                              //                       style: TextStyle(
                              //                         color:
                              //                             LoopsColors.textColor,
                              //                         fontSize: 12.sp,
                              //                         fontWeight:
                              //                             FontWeight.w600,
                              //                       ),
                              //                       maxLines: 3,
                              //                     ),
                              //                   ),
                              //                 ],
                              //               ),
                              //               Row(
                              //                 mainAxisAlignment:
                              //                     MainAxisAlignment
                              //                         .spaceBetween,
                              //                 crossAxisAlignment:
                              //                     CrossAxisAlignment.start,
                              //                 children: [
                              //                   Text(
                              //                     'Step 3:',
                              //                     style: TextStyle(
                              //                       color:
                              //                           LoopsColors.textColor,
                              //                       fontSize: 12.sp,
                              //                       fontWeight: FontWeight.w600,
                              //                     ),
                              //                   ),
                              //                   SizedBox(
                              //                     width: MediaQuery.of(context2)
                              //                             .size
                              //                             .width /
                              //                         2,
                              //                     child: Text(
                              //                       'You will receive reward of 10 Tests to your account. ',
                              //                       style: TextStyle(
                              //                         color:
                              //                             LoopsColors.textColor,
                              //                         fontSize: 12.sp,
                              //                         fontWeight:
                              //                             FontWeight.w600,
                              //                       ),
                              //                       maxLines: 3,
                              //                     ),
                              //                   ),
                              //                 ],
                              //               ),
                              //               Row(
                              //                 mainAxisAlignment:
                              //                     MainAxisAlignment
                              //                         .spaceBetween,
                              //                 crossAxisAlignment:
                              //                     CrossAxisAlignment.start,
                              //                 children: [
                              //                   Text(
                              //                     'Step 4:',
                              //                     style: TextStyle(
                              //                       color:
                              //                           LoopsColors.textColor,
                              //                       fontSize: 12.sp,
                              //                       fontWeight: FontWeight.w600,
                              //                     ),
                              //                   ),
                              //                   SizedBox(
                              //                     width: MediaQuery.of(context2)
                              //                             .size
                              //                             .width /
                              //                         2,
                              //                     child: Text(
                              //                       'To earn more such rewards, you can share it with all your friends',
                              //                       style: TextStyle(
                              //                         color:
                              //                             LoopsColors.textColor,
                              //                         fontSize: 12.sp,
                              //                         fontWeight:
                              //                             FontWeight.w600,
                              //                       ),
                              //                       maxLines: 3,
                              //                     ),
                              //                   ),
                              //                 ],
                              //               )
                              //             ],
                              //           ),
                              //         ),
                              //       );
                              //     });
                            },
                            child: Padding(
                              padding:
                                  EdgeInsets.only(left: 8.sp, bottom: 0.sp),
                              child: Column(
                                children: [
                                  Text(
                                    'How it works',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: LoopsColors.colorBlack.withOpacity(0.6),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 2.sp),
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    height: 1.sp,
                                    color: LoopsColors.tertiaryColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // if (!_showEarned)
                          ContainerWithBorder(
                            // boxColor: LoopsColors.secondaryColor.withOpacity(0.05),
                            width: 120.w,
                            height: 38.h,
                            borderRadius: 10.sp,
                            /*  child: InkWell(
                                onTap: () {
                                  _showEarned = true;
                                },
                                child: Text(
                                  'Earned Rewards',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: LoopsColors.primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ) */
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        children: [
                          ContainerWithBorder(
                            borderColor: LoopsColors.textColor.withOpacity(0.5),
                            borderRadius: 100.sp,
                            width: 35.sp,
                            height: 35.sp,
                            child: Text(
                              '1',
                              style: TextStyle(
                                color: LoopsColors.primaryColor,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 21.sp),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Invite your friends',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'Just share the link',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(left: (35 / 2).sp),
                        width: 1.sp,
                        height: 30.h,
                        color: LoopsColors.textColor.withOpacity(0.4),
                      ),
                      Row(
                        children: [
                          ContainerWithBorder(
                            borderColor: LoopsColors.textColor.withOpacity(0.5),
                            borderRadius: 100.sp,
                            width: 35.sp,
                            height: 35.sp,
                            child: Text(
                              '2',
                              style: TextStyle(
                                color: LoopsColors.primaryColor,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 21.sp),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'They hit the road',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'With some free tests',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(left: (35 / 2).sp),
                        width: 1.sp,
                        height: 30.h,
                        color: LoopsColors.textColor.withOpacity(0.4),
                      ),
                      Row(
                        children: [
                          ContainerWithBorder(
                            borderColor: LoopsColors.textColor.withOpacity(0.5),
                            borderRadius: 100.sp,
                            width: 35.sp,
                            height: 35.sp,
                            child: Text(
                              '3',
                              style: TextStyle(
                                color: LoopsColors.primaryColor,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 21.sp),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'You earn Free tests',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'Once your firend subscribes',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(left: (35 / 2).sp),
                        width: 1.sp,
                        height: 30.h,
                        color: LoopsColors.textColor.withOpacity(0.4),
                      ),
                      Row(
                        children: [
                          ContainerWithBorder(
                            borderColor: LoopsColors.textColor.withOpacity(0.5),
                            borderRadius: 100.sp,
                            width: 35.sp,
                            height: 35.sp,
                            child: Text(
                              '4',
                              style: TextStyle(
                                color: LoopsColors.primaryColor,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 21.sp),
                            child: InkWell(
                              onTap: () {
                                earnedRewards(
                                    context,
                                    provider.referralEntity.rewards,
                                    provider.referralEntity
                                        .numberOfPeopleSubscribed,
                                    provider
                                        .referralEntity.numberOfSignedPeople);
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Earned rewards',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: LoopsColors.primaryColor,
                                    ),
                                  ),
                                  Text(
                                    'Check all rewards',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      ContainerWithBorder(
                        borderColor: LoopsColors.textColor.withOpacity(1),
                        borderRadius: 4.sp,
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                        ),
                        height: 37.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Provider.of<HomeProvider>(context, listen: false)
                                  .referralEntity
                                  .referral!,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                copyToClipboard(
                                    context,
                                    Provider.of<HomeProvider>(context,
                                            listen: false)
                                        .referralEntity
                                        .referral!);
                              },
                              child: Text(
                                'COPY',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      // if (_showEarned)

                      ContainerWithBorder(
                        height: 44.h,
                        boxColor: LoopsColors.tertiaryColor,
                        borderRadius: 10.sp,
                        child: InkWell(
                            onTap: () async {
                              // share();
                              await Share.share(
                                  "Hey, I have been using this Rao Academy app for Test taking. It is very fun to take tests on this app. \n Download the app from following link: https://play.google.com/store/apps/details?id=com.app.raoacademy",
                                  subject: 'Share with your friend');

                              //  Share.text(
                              // 'Refer & Earn', 'AFKPYR', 'text/plain');
                              // Future<void> share() async {
                              //   await FlutterShare.share(
                              //       title: 'Example share',
                              //       text: 'Example share text',84
                              //       linkUrl: 'https://flutter.dev/',
                              //       chooserTitle: 'Example Chooser Title');
                              // }
                            },
                            child: Text(
                              'Refer friends now',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: LoopsColors.primaryColor,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.sp,
                              ),
                            )),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            /* const PieChart(
              height: 400,
              title: 'Title',
              subTitle: 'Subtitle',
              map: {
                'One': 89,
                'Two': 74,
                'Three': 56,
                'Four': 32,
              },
              colors: [LoopsColors.colorGreen, LoopsColors.colorRed, LoopsColors.colorGrey, LoopsColors.tertiaryColor],
            ) */
          ],
        ),
      ),
    );
  }
}
