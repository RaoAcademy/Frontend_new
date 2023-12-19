import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rao_academy/application/auth/auth_provider.dart';
import 'package:rao_academy/application/other/other_provider.dart';
import 'package:rao_academy/core/theme/custom_scroll_behaviour.dart';
import 'package:rao_academy/core/utli/custom_progress.dart';
import 'package:rao_academy/core/utli/error_handle.dart';
import 'package:rao_academy/core/utli/goto_pages.dart';
import 'package:rao_academy/core/utli/loops_urls.dart';
import 'package:rao_academy/core/utli/svg_image_util.dart';
import 'package:rao_academy/core/widgets/container_with_border.dart';
import 'package:rao_academy/presentation/auth/signup_form.dart';
import 'package:rao_academy/presentation/auth/widgets/popup_with_badge.dart';
// import 'package:rao_academy/presentation/auth/widgets/popup_with_badge.dart';
import 'package:rao_academy/presentation/core/bottom_bar.dart';
import 'package:rao_academy/presentation/core/drawer.dart';
import 'package:rao_academy/presentation/home/homescreen.dart';
import 'package:rao_academy/presentation/other/widgets/cached_network_image.dart';
import 'package:share_plus/share_plus.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  double _val = 0;
  @override
  void initState() {
    Provider.of<OtherProvider>(context, listen: false).currentTab = 4;
    final provider = Provider.of<AuthProvider>(context, listen: false);
    final double val = (provider.profileDetailsEntity.totalTests == null ||
            provider.profileDetailsEntity.totalTests == 0)
        ? 0
        : (provider.profileDetailsEntity.testsRemaining == null ||
                provider.profileDetailsEntity.testsRemaining == 0)
            ? 1
            : ((provider.profileDetailsEntity.testsRemaining!) /
                        provider.profileDetailsEntity.totalTests!)
                    .isNaN
                ? 1
                : (provider.profileDetailsEntity.testsRemaining!) /
                    provider.profileDetailsEntity.totalTests!;

    if ((val < 0 ? val * -1 : val) > 1) {
      _val = 0;
    } else {
      _val = val < 0 ? val * -1 : val;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<OtherProvider>();
    int presscount = 0;

    return WillPopScope(
      onWillPop: () async {
        presscount++;

        if (presscount == 2) {
          exit(0);
        } else {
          const snackBar = SnackBar(
            content: Text('Press again to exit'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          return false;
        }
      },
      child: Scaffold(
        key: scaffoldKey05,
        bottomNavigationBar: bottomNavigationBar(context),
        drawer: const DrawerWidget(),
        backgroundColor: LoopsColors.lightGrey,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.sp),
          child: ScrollConfiguration(
            behavior: MyBehavior(),
            child: ListView(
              children: [
                SizedBox(
                  height: 8.h,
                ),
                SizedBox(
                  height: 240.h,
                  child: Stack(
                    children: [
                      ContainerWithBorder(
                        height: 130.h,
                        boxColor: LoopsColors.primaryColor.withOpacity(0),
                        borderRadius: 12.sp,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.sp),
                            topRight: Radius.circular(8.sp),
                          ),
                          child: const SvgPictureUL(
                            asset: 'assets/images/profile/top_bg.svg',
                            colorCode: '003ECB',
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: ContainerWithBorder(
                          height: 120.h,
                          width: MediaQuery.of(context).size.width,
                          // margin: EdgeInsets.symmetric(horizontal: 8.sp),
                          borderR: BorderRadius.only(
                            topLeft: Radius.circular(12.sp),
                            topRight: Radius.circular(12.sp),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(),
                              Text(
                                Provider.of<AuthProvider>(context)
                                        .profileDetailsEntity
                                        .name ??
                                    '',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                  color: LoopsColors.colorBlack,
                                ),
                              ),
                              ContainerWithBorder(
                                height: 1.sp,
                                boxColor: LoopsColors.lightGrey,
                                margin: EdgeInsets.symmetric(horizontal: 24.w),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                        Icons.bookmarks_outlined,
                                        size: 24.sp,
                                        color: LoopsColors.primaryColor,
                                      ),
                                      SizedBox(
                                        width: 4.w,
                                      ),
                                      Text(
                                        Provider.of<AuthProvider>(context,
                                                listen: false)
                                            .profileDetailsEntity
                                            .numberOfTestsTaken!
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w600,
                                          color: LoopsColors.colorRed,
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                        Icons.loop,
                                        size: 24.sp,
                                        color: LoopsColors.primaryColor,
                                      ),
                                      SizedBox(
                                        width: 4.w,
                                      ),
                                      Text(
                                        Provider.of<AuthProvider>(context,
                                                listen: false)
                                            .profileDetailsEntity
                                            .numberOfLoopsTaken!
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w600,
                                          color: LoopsColors.colorRed,
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                        Icons.people_outline,
                                        size: 24.sp,
                                        color: LoopsColors.primaryColor,
                                      ),
                                      SizedBox(
                                        width: 4.w,
                                      ),
                                      Text(
                                        Provider.of<AuthProvider>(context,
                                                listen: false)
                                            .profileDetailsEntity
                                            .numberOfSignedPeople!
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w600,
                                          color: LoopsColors.colorRed,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Container(),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 18.h,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(),
                              InkWell(
                                onTap: () {
                                  Provider.of<AuthProvider>(context,
                                          listen: false)
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
                                                    boxColor:
                                                        LoopsColors.colorBlack,
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
                                                    height:
                                                        MediaQuery.of(context)
                                                                .copyWith()
                                                                .size
                                                                .height -
                                                            80.h,
                                                    boxColor:
                                                        LoopsColors.colorBlack,
                                                    child:
                                                        SingleChildScrollView(
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
                                                                      Colors
                                                                          .yellow,
                                                                      Colors
                                                                          .red,
                                                                      Colors
                                                                          .indigo,
                                                                      Colors
                                                                          .teal,
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
                                                                      avatarId: Provider.of<AuthProvider>(
                                                                              context,
                                                                              listen:
                                                                                  false)
                                                                          .avatarsEntity
                                                                          .avatars![
                                                                              i]
                                                                          .id,
                                                                      update:
                                                                          true,
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
                                                                          .then(
                                                                              (_) {
                                                                        Navigator.pop(
                                                                            context);
                                                                      }).onError((error,
                                                                              stackTrace) async {
                                                                        await handleError(
                                                                            error);
                                                                      });
                                                                    });
                                                                  },
                                                                  child:
                                                                      ClipOval(
                                                                    child:
                                                                        LoopsImage(
                                                                      path: Provider.of<AuthProvider>(
                                                                              context,
                                                                              listen:
                                                                                  false)
                                                                          .avatarsEntity
                                                                          .avatars![
                                                                              i]
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
                                  });
                                },
                                child: SizedBox(
                                  height: 120.sp,
                                  width: 120.sp,
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
                                ),
                              ),
                              Container(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                ContainerWithBorder(
                  borderRadius: 8.sp,
                  height: 42.h,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 75.w,
                        child: Text(
                          'Tests Available',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: LoopsColors.textColor,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 8.h,
                            ),
                            Expanded(
                              child: CustomProgressBar(
                                  value: _val,
                                  // color: ,
                                  bgColor: LoopsColors.lightGrey,
                                  gradient: LinearGradient(
                                    colors: [
                                      LoopsColors.colorPink,
                                      LoopsColors.primaryColor,
                                    ],
                                    begin: Alignment.centerRight,
                                    end: Alignment.centerLeft,
                                  )),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '',
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w600,
                                    color: LoopsColors.textColor,
                                  ),
                                ),
                                Text(
                                  (Provider.of<AuthProvider>(context)
                                              .profileDetailsEntity
                                              .totalTests! ~/
                                          2)
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w600,
                                    color: LoopsColors.textColor,
                                  ),
                                ),
                                Text(
                                  Provider.of<AuthProvider>(context)
                                      .profileDetailsEntity
                                      .totalTests!
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w600,
                                    color: LoopsColors.textColor,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      InkWell(
                        onTap: () {
                          gotoSubscription(context);
                        },
                        child: SizedBox(
                          width: 60.w,
                          child: Text(
                            'Upgrade',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: LoopsColors.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                ContainerWithBorder(
                  borderRadius: 8.sp,
                  height: 42.h,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 75.w,
                        child: Text(
                          'Profile',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: LoopsColors.textColor,
                          ),
                        ),
                      ),
                      Expanded(
                        child: CustomProgressBar(
                            value: Provider.of<AuthProvider>(context)
                                    .profileDetailsEntity
                                    .profileCompletion!
                                ? 1
                                : 0.5,
                            // color: ,
                            bgColor: LoopsColors.lightGrey,
                            gradient: LinearGradient(
                              colors: [
                                LoopsColors.colorPink,
                                LoopsColors.primaryColor,
                              ],
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft,
                            )),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      SizedBox(
                        width: 60.w,
                        child: InkWell(
                          onTap: () async {
                            // Provider.of<AuthProvider>(context, listen: false)
                            //     .fprofileDetailed()
                            //     .onError((error, stackTrace) async {
                            //   await handleError(error);
                            // });
                            await Provider.of<AuthProvider>(context,
                                    listen: false)
                                .fprofileUpdate(
                                    Provider.of<AuthProvider>(context,
                                            listen: false)
                                        .profileUpdateEntity,
                                    0)
                                .onError((error, stackTrace) async {
                              await handleError(error);
                            }).then((value) => Navigator.push(context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) {
                                      return const SignUpForm(
                                        fromProfile: true,
                                      );
                                    })));
                            // Provider.of<AuthProvider>(context, listen: false)
                            //     .fschool()
                            //     .onError((error, stackTrace) async {
                            //   await handleError(error);
                            //   throw error!;
                            // });
                          },
                          child: Icon(
                            Icons.edit,
                            size: 24.sp,
                            color: LoopsColors.primaryColor,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                ContainerWithBorder(
                  padding:
                      EdgeInsets.symmetric(horizontal: 4.w, vertical: 12.h),
                  borderRadius: 10.sp,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: Text(
                            'Activity badges',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: LoopsColors.textColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 24.w,
                          ),
                          Column(
                            children: [
                              Text(
                                'Present',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: LoopsColors.textColor.withOpacity(0.6),
                                ),
                              ),
                              SizedBox(
                                width: 80.w,
                                height: 100.h,
                                child: InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (_) {
                                        return PopupWithBadge(
                                          svgAsset:
                                              Provider.of<AuthProvider>(context)
                                                  .profileDetailsEntity
                                                  .badgeActivity
                                                  ?.imagePath,
                                          body: Material(
                                            color: Colors.transparent,
                                            type: MaterialType.transparency,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  Provider.of<AuthProvider>(
                                                              context)
                                                          .profileDetailsEntity
                                                          .badgeActivity
                                                          ?.message ??
                                                      '',
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color:
                                                        LoopsColors.textColor,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 8.h,
                                                ),
                                                Text(
                                                  formatDate(Provider.of<
                                                                  AuthProvider>(
                                                              context)
                                                          .profileDetailsEntity
                                                          .badgeActivity
                                                          ?.date ??
                                                      ''),
                                                  style: TextStyle(
                                                    fontSize: 10.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color:
                                                        LoopsColors.textColor,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 8.h,
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                    await Share.share(
                                                        "I just earned a badge in Rao Academy app. Come join me on this app where test taking is fun Link",
                                                        subject:
                                                            'Share with your friend');
                                                  },
                                                  child: Text(
                                                    'Share with friends',
                                                    style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:
                                                          LoopsColors.textColor,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: ClipRRect(
                                    // height: 120.h,
                                    child: LoopsImage(
                                      path: Provider.of<AuthProvider>(context)
                                          .profileDetailsEntity
                                          .badgeActivity
                                          ?.imagePath,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 36.w,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 8.w),
                                  child: Text(
                                    'Upcoming',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: LoopsColors.textColor
                                          .withOpacity(0.6),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 100.h,
                                  child: ScrollConfiguration(
                                    behavior: MyBehavior(),
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            Provider.of<AuthProvider>(context)
                                                .profileDetailsEntity
                                                .badgeActivityUpcoming!
                                                .length,
                                        itemBuilder: (context, i) {
                                          return Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8.w),
                                            child: InkWell(
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (_) {
                                                    return PopupWithBadge(
                                                      svgAsset: Provider.of<
                                                                  AuthProvider>(
                                                              context)
                                                          .profileDetailsEntity
                                                          .badgeActivityUpcoming![
                                                              i]
                                                          .imagePath,
                                                      body: Material(
                                                        color:
                                                            Colors.transparent,
                                                        type: MaterialType
                                                            .transparency,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Text(
                                                              Provider.of<AuthProvider>(
                                                                          context)
                                                                      .profileDetailsEntity
                                                                      .badgeActivityUpcoming?[
                                                                          i]
                                                                      .message ??
                                                                  '',
                                                              style: TextStyle(
                                                                fontSize: 14.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: LoopsColors
                                                                    .textColor,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 8.h,
                                                            ),
                                                            Text(
                                                              formatDate(Provider.of<
                                                                              AuthProvider>(
                                                                          context)
                                                                      .profileDetailsEntity
                                                                      .badgeActivityUpcoming?[
                                                                          i]
                                                                      .date ??
                                                                  ''),
                                                              style: TextStyle(
                                                                fontSize: 10.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: LoopsColors
                                                                    .textColor,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 8.h,
                                                            ),
                                                            InkWell(
                                                              onTap: () async {
                                                                await Share.share(
                                                                    "I just earned a badge in Rao Academy app. Come join me on this app where test taking is fun Link",
                                                                    subject:
                                                                        'Share with your friend');
                                                              },
                                                              child: Text(
                                                                'Share with friends',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      12.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: LoopsColors
                                                                      .textColor,
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                              child: LoopsImage(
                                                path: Provider.of<AuthProvider>(
                                                        context)
                                                    .profileDetailsEntity
                                                    .badgeActivityUpcoming![i]
                                                    .imagePath,
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                ContainerWithBorder(
                  padding:
                      EdgeInsets.symmetric(horizontal: 4.w, vertical: 12.h),
                  borderRadius: 10.sp,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: Text(
                            'Performance badges',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: LoopsColors.textColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 24.w,
                          ),
                          Column(
                            children: [
                              Text(
                                'Present',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: LoopsColors.textColor.withOpacity(0.6),
                                ),
                              ),
                              SizedBox(
                                width: 80.w,
                                height: 100.h,
                                child: InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (_) {
                                        return PopupWithBadge(
                                          svgAsset:
                                              Provider.of<AuthProvider>(context)
                                                  .profileDetailsEntity
                                                  .badgePerformance
                                                  ?.imagePath,
                                          // '${Provider.of<AuthProvider>(context).profileDetailsEntity.badgePerformance}',
                                          body: Material(
                                            color: Colors.transparent,
                                            type: MaterialType.transparency,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  Provider.of<AuthProvider>(
                                                              context)
                                                          .profileDetailsEntity
                                                          .badgePerformance
                                                          ?.message ??
                                                      '',
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color:
                                                        LoopsColors.textColor,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 8.h,
                                                ),
                                                Text(
                                                  formatDate(Provider.of<
                                                                  AuthProvider>(
                                                              context)
                                                          .profileDetailsEntity
                                                          .badgePerformance
                                                          ?.date ??
                                                      ''),
                                                  style: TextStyle(
                                                    fontSize: 10.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color:
                                                        LoopsColors.textColor,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 8.h,
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                    await Share.share(
                                                        "I just earned a badge in Rao Academy app. Come join me on this app where test taking is fun Link",
                                                        subject:
                                                            'Share with your friend');
                                                  },
                                                  child: Text(
                                                    'Share with friends',
                                                    style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:
                                                          LoopsColors.textColor,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: ClipRRect(
                                    // height: 120.h,
                                    child: LoopsImage(
                                      path: Provider.of<AuthProvider>(context)
                                              .profileDetailsEntity
                                              .badgePerformance
                                              ?.imagePath ??
                                          '',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 36.w,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 8.w),
                                  child: Text(
                                    'Upcoming',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: LoopsColors.textColor
                                          .withOpacity(0.6),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 100.h,
                                  child: ScrollConfiguration(
                                    behavior: MyBehavior(),
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: Provider.of<AuthProvider>(
                                                      context)
                                                  .profileDetailsEntity
                                                  .badgePerformanceUpcoming !=
                                              null
                                          ? Provider.of<AuthProvider>(context)
                                              .profileDetailsEntity
                                              .badgePerformanceUpcoming!
                                              .length
                                          : 0,
                                      itemBuilder: (context, i) {
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.w),
                                          child: InkWell(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (_) {
                                                  return PopupWithBadge(
                                                    svgAsset: Provider.of<
                                                                AuthProvider>(
                                                            context)
                                                        .profileDetailsEntity
                                                        .badgePerformanceUpcoming![
                                                            i]
                                                        .imagePath,
                                                    body: Material(
                                                      color: Colors.transparent,
                                                      type: MaterialType
                                                          .transparency,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Text(
                                                            Provider.of<AuthProvider>(
                                                                        context)
                                                                    .profileDetailsEntity
                                                                    .badgePerformanceUpcoming?[
                                                                        i]
                                                                    .message ??
                                                                '',
                                                            style: TextStyle(
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: LoopsColors
                                                                  .textColor,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 8.h,
                                                          ),
                                                          Text(
                                                            formatDate(Provider.of<
                                                                            AuthProvider>(
                                                                        context)
                                                                    .profileDetailsEntity
                                                                    .badgePerformanceUpcoming?[
                                                                        i]
                                                                    .date ??
                                                                ''),
                                                            style: TextStyle(
                                                              fontSize: 10.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: LoopsColors
                                                                  .textColor,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 8.h,
                                                          ),
                                                          InkWell(
                                                            onTap: () async {
                                                              await Share.share(
                                                                  "I just earned a badge in Rao Academy app. Come join me on this app where test taking is fun Link",
                                                                  subject:
                                                                      'Share with your friend');
                                                            },
                                                            child: Text(
                                                              'Share with friends',
                                                              style: TextStyle(
                                                                fontSize: 12.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: LoopsColors
                                                                    .textColor,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            child: LoopsImage(
                                              path: Provider.of<AuthProvider>(
                                                      context)
                                                  .profileDetailsEntity
                                                  .badgePerformanceUpcoming![i]
                                                  .imagePath,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                ContainerWithBorder(
                  padding:
                      EdgeInsets.symmetric(horizontal: 4.w, vertical: 12.h),
                  borderRadius: 10.sp,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: Text(
                            'Progress badges',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: LoopsColors.textColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      if (Provider.of<AuthProvider>(context)
                              .profileDetailsEntity
                              .badgeProgress !=
                          null)
                        Row(
                          children: [
                            SizedBox(
                              width: 24.w,
                            ),
                            Column(
                              children: [
                                Text(
                                  'Present',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color:
                                        LoopsColors.textColor.withOpacity(0.6),
                                  ),
                                ),
                                SizedBox(
                                  width: 80.w,
                                  height: 100.h,
                                  child: ClipRRect(
                                    // height: 120.h,
                                    child: InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (_) {
                                            return PopupWithBadge(
                                              svgAsset:
                                                  Provider.of<AuthProvider>(
                                                          context)
                                                      .profileDetailsEntity
                                                      .badgeProgress
                                                      ?.imagePath,
                                              // '${Provider.of<AuthProvider>(context).profileDetailsEntity.badgeProgress}',
                                              body: Material(
                                                color: Colors.transparent,
                                                type: MaterialType.transparency,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      Provider.of<AuthProvider>(
                                                                  context)
                                                              .profileDetailsEntity
                                                              .badgeProgress
                                                              ?.message ??
                                                          '',
                                                      style: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: LoopsColors
                                                            .textColor,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 8.h,
                                                    ),
                                                    Text(
                                                      formatDate(Provider.of<
                                                                      AuthProvider>(
                                                                  context)
                                                              .profileDetailsEntity
                                                              .badgeProgress
                                                              ?.date ??
                                                          ''),
                                                      style: TextStyle(
                                                        fontSize: 10.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: LoopsColors
                                                            .textColor,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 8.h,
                                                    ),
                                                    InkWell(
                                                      onTap: () async {
                                                        await Share.share(
                                                            "I just earned a badge in Rao Academy app. Come join me on this app where test taking is fun Link",
                                                            subject:
                                                                'Share with your friend');
                                                      },
                                                      child: Text(
                                                        'Share with friends',
                                                        style: TextStyle(
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: LoopsColors
                                                              .textColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: LoopsImage(
                                          path: //TODO: this
                                              Provider.of<AuthProvider>(context)
                                                  .profileDetailsEntity
                                                  .badgeProgress
                                                  ?.imagePath),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 36.w,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 8.w),
                                    child: Text(
                                      'Upcoming',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        color: LoopsColors.textColor
                                            .withOpacity(0.6),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 100.h,
                                    child: ScrollConfiguration(
                                      behavior: MyBehavior(),
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            Provider.of<AuthProvider>(context)
                                                .profileDetailsEntity
                                                .badgeProgressUpcoming!
                                                .length,
                                        itemBuilder: (context, i) {
                                          return Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8.w),
                                            child: InkWell(
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (_) {
                                                    return PopupWithBadge(
                                                      svgAsset: Provider.of<
                                                                  AuthProvider>(
                                                              context)
                                                          .profileDetailsEntity
                                                          .badgeProgressUpcoming![
                                                              i]
                                                          .imagePath,
                                                      body: Material(
                                                        color:
                                                            Colors.transparent,
                                                        type: MaterialType
                                                            .transparency,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Text(
                                                              Provider.of<AuthProvider>(
                                                                          context)
                                                                      .profileDetailsEntity
                                                                      .badgeProgressUpcoming![
                                                                          i]
                                                                      .message ??
                                                                  '',
                                                              style: TextStyle(
                                                                fontSize: 14.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: LoopsColors
                                                                    .textColor,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 8.h,
                                                            ),
                                                            Text(
                                                              Provider.of<AuthProvider>(
                                                                          context)
                                                                      .profileDetailsEntity
                                                                      .badgeProgressUpcoming![
                                                                          i]
                                                                      .date ??
                                                                  '',
                                                              style: TextStyle(
                                                                fontSize: 10.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: LoopsColors
                                                                    .textColor,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 8.h,
                                                            ),
                                                            InkWell(
                                                              onTap: () async {
                                                                await Share.share(
                                                                    "I just earned a badge in Rao Academy app. Come join me on this app where test taking is fun Link",
                                                                    subject:
                                                                        'Share with your friend');
                                                              },
                                                              child: Text(
                                                                'Share with friends',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      12.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: LoopsColors
                                                                      .textColor,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                              child: LoopsImage(
                                                path: Provider.of<AuthProvider>(
                                                        context)
                                                    .profileDetailsEntity
                                                    .badgeProgressUpcoming![i]
                                                    .imagePath,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                    ],
                  ),
                ),

                ////////////////////////
                ///
                ///
                ///
                ///
                ///
                ////////////////////////
                /*  SizedBox(
                  height: 12.h,
                ),
                ContainerWithBorder(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 12.h),
                  borderRadius: 10.sp,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: Text(
                            'Earned badges',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: LoopsColors.textColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 100.h,
                                  child: ScrollConfiguration(
                                    behavior: MyBehavior(),
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 12,
                                      itemBuilder: (context, i) {
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.w),
                                          child: InkWell(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (_) {
                                                  return PopupWithBadge(
                                                    svgAsset:
                                                        'assets/images/profile/performance/achiver.png',
                                                    body: Material(
                                                      color: Colors.transparent,
                                                      type: MaterialType
                                                          .transparency,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment.end,
                                                        children: [
                                                          Text(
                                                            'For winning 2 combats in a row',
                                                            style: TextStyle(
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight.w600,
                                                              color: LoopsColors
                                                                  .textColor,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 8.h,
                                                          ),
                                                          Text(
                                                            'March 12,2022',
                                                            style: TextStyle(
                                                              fontSize: 10.sp,
                                                              fontWeight:
                                                                  FontWeight.w600,
                                                              color: LoopsColors
                                                                  .textColor,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 8.h,
                                                          ),
                                                          Text(
                                                            'Share with friends',
                                                            style: TextStyle(
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  FontWeight.w600,
                                                              color: LoopsColors
                                                                  .textColor,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            child: AssetSvgImage(
                                                svgAsset:
                                                    'assets/images/profile/activity/streak.png',
                                                text: (i + 1).toString()),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ), */
                SizedBox(
                  height: 24.h,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String formatDate(String dateStr) {
    if (dateStr == '') return '';
    final List<String> dateParts = dateStr.split(' ');
    final String newDateStr =
        '${dateParts[0]}, ${dateParts[1]} ${dateParts[2]} ${dateParts[3]}';
    return newDateStr;
  }
}
