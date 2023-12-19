import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rao_academy/application/other/other_provider.dart';
import 'package:rao_academy/core/utli/error_handle.dart';
import 'package:rao_academy/core/utli/goto_pages.dart';
import 'package:rao_academy/core/utli/logger.dart';
import 'package:rao_academy/core/utli/loops_urls.dart';
import 'package:rao_academy/presentation/core/loader_popup.dart';

Widget bottomNavigationBar(BuildContext context) {
  final OtherProvider provider = context.watch<OtherProvider>();
  return Container(
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: LoopsColors.colorWhite,
      boxShadow: const [
        BoxShadow(
          color: Color.fromARGB(43, 158, 158, 158),
          spreadRadius: 1,
          blurRadius: 0.5,
          offset: Offset(0, -2),
        ),
      ],
    ),
    constraints: BoxConstraints(
      maxHeight: 60.h,
    ),
    child: BottomNavigationBar(
      showUnselectedLabels: true,
      backgroundColor: Colors.transparent,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      unselectedItemColor: LoopsColors.colorGrey,
      selectedItemColor: LoopsColors.primaryColor,
      unselectedLabelStyle: TextStyle(
        fontSize: 10.sp,
        fontWeight: FontWeight.w600,
        fontFamily: 'HGS_light'
      ),
      selectedLabelStyle: TextStyle(
        fontFamily: 'HGS_semi',
        fontSize: 10.sp,
        fontWeight: FontWeight.w700,
      ),
      onTap: (int value) async {
        // int x = 0;
        bool hasError = false;
        final int temp = provider.currentTab;
        if (value != provider.currentTab) {
          late BuildContext buildContextX;
          unawaited(showLoaderPopup(context, (value) {
            buildContextX = value;
          }));
          // while (value != provider.currentTab && x < 3) {
          //   x++;
          switch (value) {
            case 0:
              await Future.delayed(const Duration(milliseconds: 500))
                  .then((_) async {
                await gotoHomePage(context).then((_) {
                  Navigator.pop(buildContextX);
                  provider.currentTab = value;
                  logger.i('current_page_index:$value');
                  provider.setState();
                }).onError((error, stackTrace) async {
                  Navigator.pop(buildContextX);
                  hasError = true;
                  provider.currentTab = temp;
                  provider.setState();
                  await handleError(error);
                });
              });

              break;
            case 1:
              await Future.delayed(const Duration(milliseconds: 500))
                  .then((_) async {
                await gotoTestHome(context).then((_) {
                  Navigator.pop(buildContextX);
                  provider.currentTab = value;
                  logger.i('current_page_index:$value');
                  provider.setState();
                }).onError((error, stackTrace) async {
                  Navigator.pop(buildContextX);
                  hasError = true;
                  provider.currentTab = temp;
                  provider.setState();
                  await handleError(error);
                });
              });

              break;
            case 2:
              await Future.delayed(const Duration(milliseconds: 500))
                  .then((_) async {
                await gotoLoops(context).then((_) {
                  Navigator.pop(buildContextX);
                  provider.currentTab = value;
                  logger.i('current_page_index:$value');
                  provider.setState();
                }).onError((error, stackTrace) async {
                  Navigator.pop(buildContextX);
                  hasError = true;
                  provider.currentTab = temp;
                  provider.setState();
                  await handleError(error);
                });
              });

              break;
            case 3:
              await Future.delayed(const Duration(milliseconds: 500))
                  .then((_) async {
                await gotoAnalyticsPage(context).then((_) {
                  Navigator.pop(buildContextX);
                  provider.currentTab = value;
                  logger.i('current_page_index:$value');
                  provider.setState();
                }).onError((error, stackTrace) async {
                  Navigator.pop(buildContextX);
                  hasError = true;
                  provider.currentTab = temp;
                  provider.setState();
                  await handleError(error);
                });
              });

              break;
            case 4:
              await Future.delayed(const Duration(milliseconds: 500))
                  .then((_) async {
                await gotoProfile(context).then((_) {
                  Navigator.pop(buildContextX);
                  provider.currentTab = value;
                  logger.i('current_page_index:$value');
                  provider.setState();
                }).onError((error, stackTrace) async {
                  Navigator.pop(buildContextX);
                  hasError = true;
                  provider.currentTab = temp;
                  provider.setState();
                  await handleError(error);
                });
              });

              break;
            default:
          }
          if (value != provider.currentTab && hasError == false) {
            provider.currentTab = value;
            provider.setState();
          }
          // }
        }
      },
      currentIndex: provider.currentTab,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.edit_note_rounded),
          label: 'Tests',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.loop_outlined),
          label: 'Loops',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.analytics_outlined),
          label: 'Analytics',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline_outlined),
          label: 'Profile',
        ),
      ],
    ),
  );
}
