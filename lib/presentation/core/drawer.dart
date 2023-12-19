import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rao_academy/application/auth/auth_provider.dart';
import 'package:rao_academy/application/home/home_provider.dart';
import 'package:rao_academy/application/other/other_provider.dart';
import 'package:rao_academy/core/utli/error_handle.dart';
import 'package:rao_academy/core/utli/goto_pages.dart';
import 'package:rao_academy/core/utli/loops_urls.dart';
import 'package:rao_academy/core/widgets/coin.dart';
import 'package:rao_academy/core/widgets/container_with_border.dart';
import 'package:rao_academy/core/widgets/logout_popup.dart';
import 'package:rao_academy/core/widgets/rate_app.dart';
import 'package:rao_academy/presentation/other/widgets/cached_network_image.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerState();
}

class _DrawerState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    final OtherProvider otherProvider = context.watch<OtherProvider>();
    final provider = context.watch<HomeProvider>();

    return Drawer(
      elevation: 240,
      child: Padding(
        padding: EdgeInsets.all(8.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                gotoProfile(context)
                    .onError((error, stackTrace) => handleError(error));
              },
              child: ContainerWithBorder(
                borderRadius: 4.sp,
                height: 120.h,
                child: Row(
                  children: [
                    SizedBox(
                      width: 120.w,
                      child: Center(
                        child:
                        /* InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            gotoProfile(context); */
                            /* Provider.of<AuthProvider>(context, listen: false)
                                .favatar()
                                .onError((error, stackTrace) async {
                              await handleError(error);
                            }).then((_) {
                              showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                context: context,
                                isScrollControlled: true,
                                isDismissible: true,
                                builder: (BuildContext builder) {
                                  return DraggableScrollableSheet(
                                    initialChildSize: 1,
                                    builder: (context, scrollController) {
                                      return SizedBox(
                                        height: MediaQuery.of(context)
                                            .copyWith()
                                            .size
                                            .height,
                                        width: MediaQuery.of(context)
                                            .copyWith()
                                            .size
                                            .width,
                                        child: Column(
                                          children: [
                                            ContainerWithBorder(
                                              height: 80.h,
                                              boxColor: LoopsColors.colorBlack,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Container(
                                                    height: 24.sp,
                                                  ),
                                                  Text(
                                                    'Choose an Avatar.',
                                                    style: TextStyle(
                                                      fontSize: 18.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: LoopsColors
                                                          .colorWhite,
                                                    ),
                                                  ),
                                                  Container(),
                                                ],
                                              ),
                                            ),
                                            ContainerWithBorder(
                                              height: MediaQuery.of(context)
                                                      .copyWith()
                                                      .size
                                                      .height -
                                                  80.h,
                                              boxColor: LoopsColors.colorBlack,
                                              child: SingleChildScrollView(
                                                child: Wrap(
                                                  children: [
                                                    for (int i = 0;
                                                        i <
                                                            Provider.of<AuthProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .avatarsEntity
                                                                .avatars!
                                                                .length;
                                                        i++)
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child:
                                                            ContainerWithBorder(
                                                          width: 100.sp,
                                                          height: 100.sp,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        120.sp),
                                                            gradient:
                                                                const LinearGradient(
                                                              begin: Alignment
                                                                  .topRight,
                                                              end: Alignment
                                                                  .bottomLeft,
                                                              stops: [
                                                                0.1,
                                                                0.4,
                                                                0.6,
                                                                0.9,
                                                              ],
                                                              colors: [
                                                                Colors.yellow,
                                                                Colors.red,
                                                                Colors.indigo,
                                                                Colors.teal,
                                                              ],
                                                            ),
                                                          ),
                                                          child: InkWell(
                                                            onTap: () {
                                                              Provider.of<AuthProvider>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .favatar(
                                                                avatarId: Provider.of<
                                                                            AuthProvider>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .avatarsEntity
                                                                    .avatars![i]
                                                                    .id,
                                                                update: true,
                                                              )
                                                                  .onError((error,
                                                                      stackTrace) async {
                                                                await handleError(
                                                                    error);
                                                              }).then((value) {
                                                                Provider.of<AuthProvider>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .fprofileDetailed()
                                                                    .then((_) {
                                                                  Navigator.pop(
                                                                      context);
                                                                }).onError((error,
                                                                        stackTrace) async {
                                                                  await handleError(
                                                                      error);
                                                                });
                                                              });
                                                            },
                                                            child: ClipOval(
                                                              child: LoopsImage(
                                                                path: Provider.of<
                                                                            AuthProvider>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .avatarsEntity
                                                                    .avatars![i]
                                                                    .imagePath!,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            }); */
                            /*  },
                          child: */
                            SizedBox(
                          height: 92.sp,
                          width: 92.sp,
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(
                              Radius.circular(1000.sp),
                            ),
                            child: LoopsImage(
                              path: Provider.of<AuthProvider>(context)
                                  .profileDetailsEntity
                                  .avatarImagePath!,
                              fit: BoxFit.fill,
                              // scale: 0.2,
                            ),
                          ),
                          // ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            Provider.of<AuthProvider>(context)
                                .profileDetailsEntity
                                .name!,
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: LoopsColors.colorBlack,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Coin(coinSize: 30.sp),
                              Text(
                                Provider.of<AuthProvider>(context)
                                    .profileDetailsEntity
                                    .totalTests!
                                    .toString(),
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                  color: LoopsColors.colorBlack,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    // SizedBox(
                    //   width: 120.w,
                    //   child: Center(
                    //     child: SizedBox(
                    //       width: 70.w,
                    //       height: 80.h,
                    //       child: /*  InkWell(
                    //         onTap: () { */
                    //           /*  showDialog(
                    //             context: context,
                    //             builder: (_) {
                    //               return PopupWithBadge(
                    //                 svgAsset: Provider.of<AuthProvider>(context)
                    //                     .profileDetailsEntity
                    //                     .badgeActivity!,
                    //
                    //                 // index: '',
                    //                 body: Material(
                    //                   color: Colors.transparent,
                    //                   type: MaterialType.transparency,
                    //                   child: Column(
                    //                     mainAxisAlignment:
                    //                         MainAxisAlignment.end,
                    //                     children: [
                    //                       Text(
                    //                         'For winning 2 combats in a row',
                    //                         style: TextStyle(
                    //                           fontSize: 14.sp,
                    //                           fontWeight: FontWeight.w600,
                    //                           color: LoopsColors.textColor,
                    //                         ),
                    //                       ),
                    //                       SizedBox(
                    //                         height: 8.h,
                    //                       ),
                    //                       Text(
                    //                         'March 12,2022',
                    //                         style: TextStyle(
                    //                           fontSize: 10.sp,
                    //                           fontWeight: FontWeight.w600,
                    //                           color: LoopsColors.textColor,
                    //                         ),
                    //                       ),
                    //                       SizedBox(
                    //                         height: 8.h,
                    //                       ),
                    //                       Text(
                    //                         'Share with friends',
                    //                         style: TextStyle(
                    //                           fontSize: 12.sp,
                    //                           fontWeight: FontWeight.w600,
                    //                           color: LoopsColors.textColor,
                    //                         ),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //               );
                    //             },
                    //           ); */
                    //           /* },
                    //         child: */
                    //           ClipRRect(
                    //               // height: 120.h,
                    //               child: LoopsImage(
                    //         path: Provider.of<AuthProvider>(context)
                    //             .profileDetailsEntity
                    //             .badgeActivity!,
                    //       ) /*  AssetSvgImage(
                    //             svgAsset:
                    //                 'assets/images/profile/performance/achiver.png',
                    //             text: '',
                    //           ), */
                    //               // ),
                    //               ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            Expanded(
                child: ListView(
              children: [
                /* ListTile(
                  title: Row(
                    children: [
                      ContainerWithBorder(
                        width: 32.sp,
                        height: 32.sp,
                        borderRadius: 120.sp,
                        boxColor: LoopsColors.primaryColor,
                        child: Icon(
                          Icons.menu_outlined,
                          size: 20.sp,
                          color: LoopsColors.colorWhite,
                        ),
                      ),
                      SizedBox(
                        width: 32.w,
                      ),
                      Text(
                        'Menu',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      '/menu',
                    );
                  },
                ),
                const SizedBox(
                  height: 10,
                ), */
                ListTile(
                  title: Row(
                    children: [
                      ContainerWithBorder(
                        width: 32.sp,
                        height: 32.sp,
                        borderRadius: 120.sp,
                        boxColor: Colors.transparent,
                        child: Icon(
                          Icons.wallet_travel,
                          size: 20.sp,
                          color: LoopsColors.colorBlack,
                        ),
                      ),
                      SizedBox(
                        width: 32.w,
                      ),
                      Text(
                        'Subscription',
                        style: TextStyle(
                          color: LoopsColors.colorBlack,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                  onTap: () {
                    gotoSubscription(context);
                  },
                ),
                ListTile(
                  title: Row(
                    children: [
                      ContainerWithBorder(
                        width: 32.sp,
                        height: 32.sp,
                        borderRadius: 120.sp,
                        boxColor: Colors.transparent,
                        child: Icon(
                          Icons.history,
                          size: 20.sp,
                          color: LoopsColors.colorBlack,
                        ),
                      ),
                      SizedBox(
                        width: 32.w,
                      ),
                      Text(
                        'Test History',
                        style: TextStyle(
                          color: LoopsColors.colorBlack,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                  onTap: () async{

                    await gotoTestHistory(context);
                  },
                ),
                ListTile(
                  title: Row(
                    children: [
                      ContainerWithBorder(
                        width: 32.sp,
                        height: 32.sp,
                        borderRadius: 120.sp,
                        boxColor: Colors.transparent,
                        child: Icon(
                          Icons.menu_outlined,
                          size: 20.sp,
                          color: LoopsColors.colorBlack,
                        ),
                      ),
                      SizedBox(
                        width: 32.w,
                      ),
                      Text(
                        'Reports',
                        style: TextStyle(
                          color: LoopsColors.colorBlack,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                  onTap: () {
                    gotoReports(context,false);
                  },
                ),
                ListTile(
                  title: Row(
                    children: [
                      ContainerWithBorder(
                        width: 32.sp,
                        height: 32.sp,
                        borderRadius: 120.sp,
                        boxColor: Colors.transparent,
                        child: Icon(
                          Icons.bookmark_outline,
                          size: 20.sp,
                          color: LoopsColors.colorBlack,
                        ),
                      ),
                      SizedBox(
                        width: 32.w,
                      ),
                      Text(
                        'Bookmarks',
                        style: TextStyle(
                          color: LoopsColors.colorBlack,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                  onTap: () {
                    Provider.of<AuthProvider>(context, listen: false)
                        .fbookmarkTest()
                        .then((value) => {
                              Navigator.pushNamed(
                                context,
                                '/bookmarks',
                              ),
                            })
                        .onError((error, stackTrace) async {
                      await handleError(error);
                      throw error!;
                    }).then((value) =>
                            Provider.of<OtherProvider>(context, listen: false)
                                .routeNames
                                .add('/bookmarks'));
                  },
                ),
                ListTile(
                  title: Row(
                    children: [
                      ContainerWithBorder(
                        width: 32.sp,
                        height: 32.sp,
                        borderRadius: 120.sp,
                        boxColor: Colors.transparent,
                        child: Icon(
                          Icons.attach_money,
                          size: 20.sp,
                          color: LoopsColors.colorBlack,
                        ),
                      ),
                      SizedBox(
                        width: 32.w,
                      ),
                      Text(
                        'Refer and Earn',
                        style: TextStyle(
                          color: LoopsColors.colorBlack,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                  onTap: () {
                    gotoReferral(context);
                  },
                ),
                ListTile(
                  title: Row(
                    children: [
                      ContainerWithBorder(
                        width: 32.sp,
                        height: 32.sp,
                        borderRadius: 120.sp,
                        boxColor: Colors.transparent,
                        child: Icon(
                          Icons.support_agent_outlined,
                          size: 20.sp,
                          color: LoopsColors.colorBlack,
                        ),
                      ),
                      SizedBox(
                        width: 32.w,
                      ),
                      Text(
                        'Support',
                        style: TextStyle(
                          color: LoopsColors.colorBlack,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      '/support',
                    );
                  },
                ),
                ListTile(
                  title: Row(
                    children: [
                      ContainerWithBorder(
                        width: 32.sp,
                        height: 32.sp,
                        borderRadius: 120.sp,
                        boxColor: Colors.transparent,
                        child: Icon(
                          Icons.star_rate_outlined,
                          size: 20.sp,
                          color: LoopsColors.colorBlack,
                        ),
                      ),
                      SizedBox(
                        width: 32.w,
                      ),
                      Text(
                        'Rate app',
                        style: TextStyle(
                          color: LoopsColors.colorBlack,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                  onTap: () {
                    rateApp(context, otherProvider);
                  },
                ),
                ListTile(
                  title: Row(
                    children: [
                      ContainerWithBorder(
                        width: 32.sp,
                        height: 32.sp,
                        borderRadius: 120.sp,
                        boxColor: Colors.transparent,
                        child: Icon(
                          Icons.question_answer_outlined,
                          size: 20.sp,
                          color: LoopsColors.colorBlack,
                        ),
                      ),
                      SizedBox(
                        width: 32.w,
                      ),
                      Text(
                        'FAQ',
                        style: TextStyle(
                          color: LoopsColors.colorBlack,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                  onTap: () {
                    gotoFAQs(context, 'all');
                  },
                ),
                ListTile(
                  title: Row(
                    children: [
                      ContainerWithBorder(
                        width: 32.sp,
                        height: 32.sp,
                        borderRadius: 120.sp,
                        boxColor: Colors.transparent,
                        child: Icon(
                          Icons.logout,
                          size: 20.sp,
                          color: LoopsColors.colorBlack,
                        ),
                      ),
                      SizedBox(
                        width: 32.w,
                      ),
                      Text(
                        'Log out',
                        style: TextStyle(
                          color: LoopsColors.colorBlack,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    showLogoutPopup(context);
                  },
                ),
                // SizedBox(
                //   width: 55.w,
                // ),
                SizedBox(
                  height: 100,
                ),
                Text(
                  "App ver." +
                      " ${provider.appVersionEntity.version ?? "1.0.0"}",
                  textAlign: TextAlign.center,
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
