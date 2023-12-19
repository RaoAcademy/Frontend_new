import 'package:rao_academy/domain/entities/app_version_entity.dart';
import 'package:rao_academy/domain/entities/coupon_entity.dart';
import 'package:rao_academy/domain/entities/faqs_entity.dart';
import 'package:rao_academy/domain/entities/home_entity.dart';
import 'package:rao_academy/domain/entities/home_reports_entity.dart';
import 'package:rao_academy/domain/entities/notification_history_entity.dart';
import 'package:rao_academy/domain/entities/referal_validate_entity.dart';
import 'package:rao_academy/domain/entities/referral_entity.dart';
import 'package:rao_academy/domain/entities/subscription_entity.dart';
import 'package:rao_academy/domain/entities/video_entity.dart';

abstract class HomeRepo {
  Future<CouponEntity> fcoupon({String? coupon});
  Future<VideoModel> fgettingStartedVideos();
  Future<ValidateReferalEntity> fvalidateReferral({String? coupon});
  Future<SubscriptionEntity> fsubscription({num? couponId});
  Future<ReferralEntity> freferralPage();
  Future<NotificationHistoryEntity> fnotificationHistory();
  Future<HomeEntity> fhome({
    bool? clickedNewBadge,
    bool? clickedNewWeeklyReports,
    bool? clickedSubscriptionStatus,
    bool? clickedNewTests,
  });
  Future<AppVersionEntity> fappVersion();
  Future<HomeReportsEntity> fhomeReports(String time);
  Future<List<FAQsEntity>> ffaq({required String type});
  Future<void> fnoticeClick({required String clicked});
}
