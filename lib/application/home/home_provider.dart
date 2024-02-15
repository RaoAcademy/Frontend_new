import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:EdTestz/domain/entities/app_version_entity.dart';
import 'package:EdTestz/domain/entities/coupon_entity.dart';
import 'package:EdTestz/domain/entities/faqs_entity.dart';
import 'package:EdTestz/domain/entities/home_entity.dart';
import 'package:EdTestz/domain/entities/home_reports_entity.dart';
import 'package:EdTestz/domain/entities/referal_validate_entity.dart';
import 'package:EdTestz/domain/entities/referral_entity.dart';
import 'package:EdTestz/domain/entities/subscription_entity.dart';
import 'package:EdTestz/domain/entities/notification_history_entity.dart';
import 'package:EdTestz/domain/entities/video_entity.dart';

import 'package:EdTestz/domain/home/home_repo.dart';
import 'package:version/version.dart';

@injectable
class HomeProvider with ChangeNotifier {
  HomeProvider(
    this.repo,
  );
  final HomeRepo repo;
  void setState() {
    notifyListeners();
  }

  AppVersionEntity appVersionEntity = AppVersionEntity();
  CouponEntity couponEntity = CouponEntity();
  ValidateReferalEntity validateReferalEntity = ValidateReferalEntity();
  SubscriptionEntity subscriptionEntity = SubscriptionEntity();
  ReferralEntity referralEntity = ReferralEntity();
  HomeEntity homeEntity = HomeEntity();
  VideoModel videoEntity = VideoModel();
  // ReportsEntity reportsEntity = ReportsEntity();
  HomeReportsEntity homeReportsEntity = HomeReportsEntity();
  NotificationHistoryEntity notificationHistoryEntity =
      NotificationHistoryEntity();
  List<FAQsEntity> homefaQsEntity = [];
  List<FAQsEntity> allfaQsEntity = [];
  final List<List<FAQsEntity>> faqs = [];
  final List<List<FAQsEntity>> allfaqs = [];
  List<FAQsEntity> subscriptionfaQsEntity = [];

  Version currentVersion = Version(1, 0, 0);

  bool _isBottomOpen = false;
  bool get isBottomOpen => _isBottomOpen;
  bool _isSubscriptionBottomOpen = false;
  bool get isSubscrptionBottomOpen => _isSubscriptionBottomOpen;

  changeBottomSheet(bool val){
    _isBottomOpen = val;
    notifyListeners();
  }
  changeSubscriptionBottomSheet(bool val){
    _isSubscriptionBottomOpen = val;
    notifyListeners();
  }

  Future<void> getCurrentVersion() async {
    await PackageInfo.fromPlatform().then((packageInfo) {
      final String version = packageInfo.version;
      final Version currentVersion = Version.parse(version);
      final Version versionWithBuildNumber = Version(
          currentVersion.major, currentVersion.minor, currentVersion.patch,
          build: packageInfo.buildNumber);
      this.currentVersion = versionWithBuildNumber;
    });
  }

  Future<void> fappVersion() async {
    appVersionEntity = await repo.fappVersion();
    notifyListeners();
  }

  Future<void> fhomeReports(String time) async {
    homeReportsEntity = await repo.fhomeReports(time);
    notifyListeners();
  }

  Future<void> fcoupon(String? coupon) async {
    couponEntity = await repo.fcoupon(
      coupon: coupon,
    );
    notifyListeners();
  }

  Future<void> fvalidateReferral({String? coupon}) async {
    validateReferalEntity = await repo.fvalidateReferral(
      coupon: coupon,
    );
  }

  Future<void> fsubscription({num? couponId}) async {
    subscriptionEntity = await repo.fsubscription(
      couponId: couponId,
    );
  }

  Future<void> freferralPage() async {
    referralEntity = await repo.freferralPage();
  }

  Future<void> fnotificationHistory() async {
    notificationHistoryEntity = await repo.fnotificationHistory();
  }

  Future<void> fhome({
    bool? clickedNewBadge,
    bool? clickedNewWeeklyReports,
    bool? clickedSubscriptionStatus,
    bool? clickedNewTests,
  }) async {
    homeEntity = await repo.fhome(
      clickedNewBadge: clickedNewBadge,
      clickedNewWeeklyReports: clickedNewWeeklyReports,
      clickedSubscriptionStatus: clickedSubscriptionStatus,
      clickedNewTests: clickedNewTests,
    );
  }

  Future<void> fgettingStartedVideos() async {
    videoEntity = await repo.fgettingStartedVideos();

  }

  Future<void> ffaq({String? type}) async {
    allfaqs.clear();
    faqs.clear();
    if (type != null) {
      switch (type) {
        case 'home':
          homefaQsEntity = await repo.ffaq(type: 'home');
          break;
        default:
          allfaQsEntity = await repo.ffaq(type: 'all');
          allfaQsEntity.sort((a, b) {
            return (b.type!).compareTo(a.type!);
          });

          allfaQsEntity.forEach((element) {
            bool added = false;
            if (faqs.isEmpty) {
              faqs.add([element]);
            } else {
              for (final elementY in faqs) {
                if (elementY.isEmpty) {
                  elementY.add(element);
                }
                if (elementY.first.type == element.type) {
                  elementY.add(element);
                  added = true;
                  break;
                }
              }
              if (added == false) {
                faqs.add([element]);
              }
            }

            /* if (allfaQsEntityList.isEmpty) {
              allfaQsEntityList
            } */
          });

          faqs.forEach((elementY) {
            if (elementY.first.type != null && elementY.first.type != 'home') {
              allfaqs.add(elementY);
            }
          });
      }
    } else {
      // customfaQsEntity = await repo.ffaq(type: 'custom');
      allfaQsEntity = await repo.ffaq(type: 'all');
      subscriptionfaQsEntity = await repo.ffaq(type: 'subscription');
      homefaQsEntity = await repo.ffaq(type: 'home');
    }
  }

  Future<void> fnoticeClick({required String clicked}) async {
    await repo.fnoticeClick(clicked: clicked);
    fhome();
  }
}
