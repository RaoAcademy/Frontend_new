import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:provider/provider.dart';
import 'package:rao_academy/core/utli/api_client.dart';
import 'package:rao_academy/core/utli/loops_urls.dart';
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
import 'package:rao_academy/domain/home/home_repo.dart';
import 'package:rao_academy/main.dart';

import '../../application/auth/auth_provider.dart';
import '../../application/other/other_provider.dart';

@LazySingleton(as: HomeRepo)
class ImpHomeRepo extends HomeRepo {
  ImpHomeRepo(this._apiClient);
  final APIClient _apiClient;

  @override
  Future<CouponEntity> fcoupon({String? coupon}) async {
    final result = await _apiClient.post(LoopsUrls.fcoupon, data: {
      'userId': await _apiClient.getUserId(),
      'coupon': coupon,
    });
    if (result.statusCode == 200 || result.statusCode == 201) {
      return CouponEntity.fromJson(result.data as Map<String, dynamic>);
    } else {
      throw result.statusMessage!;
    }
  }

  @override
  Future<AppVersionEntity> fappVersion() async {
    final result = await _apiClient.post(LoopsUrls.fappVersion);
    if (result.statusCode == 200 || result.statusCode == 201) {
      return AppVersionEntity.fromJson(result.data as Map<String, dynamic>);
    } else {
      throw result.statusMessage!;
    }
  }

  @override
  Future<HomeEntity> fhome(
      {bool? clickedNewBadge,
      bool? clickedNewWeeklyReports,
      bool? clickedSubscriptionStatus,
      bool? clickedNewTests}) async {

    var userId = await _apiClient.getUserId();
    final result = await _apiClient.post(LoopsUrls.fhome, data: {
      'userId': userId,
      if (clickedNewBadge != null) 'clickedNewBadge': clickedNewBadge,
      if (clickedNewWeeklyReports != null)
        'clickedNewWeeklyReports': clickedNewWeeklyReports,
      if (clickedSubscriptionStatus != null)
        'clickedSubscriptionStatus': clickedSubscriptionStatus,
      if (clickedNewTests != null) 'clickedNewTests': clickedNewTests,
    });
    if (result.statusCode == 200 || result.statusCode == 201) {
      if(result.data['message'] != "good"){
        Provider.of<AuthAppProvider>(navigatorKey.currentContext!, listen: false)
            .logout()
            .then(
              (value) {
            Provider.of<OtherProvider>(navigatorKey.currentContext!, listen: false)
                .routeNames
                .add('/signIn');
            Navigator.pushNamedAndRemoveUntil(
              navigatorKey.currentContext!,
              '/signIn',
                  (route) => false,
            );
          },
        );
      }
      return HomeEntity.fromJson(result.data as Map<String, dynamic>);
    } else {
      throw result.statusMessage!;
    }
  }

  @override
  Future<ValidateReferalEntity> fpayment(int couponId) async {
    final result = await _apiClient.post(LoopsUrls.fpayment, data: {
      'userId': await await _apiClient.getUserId(),
      'couponId': couponId,
    });
    if (result.statusCode == 200 || result.statusCode == 201) {
      return ValidateReferalEntity.fromJson(
          result.data as Map<String, dynamic>);
    } else {
      throw result.statusMessage!;
    }
  }

  @override
  Future<ReferralEntity> freferralPage() async {
    final result = await _apiClient.post(LoopsUrls.freferralPage, data: {
      'userId': await _apiClient.getUserId(),
    });
    if (result.statusCode == 200 || result.statusCode == 201) {
      return ReferralEntity.fromJson(result.data as Map<String, dynamic>);
    } else {
      throw result.statusMessage!;
    }
  }

  @override
  Future<NotificationHistoryEntity> fnotificationHistory() async {
    final result = await _apiClient.post(LoopsUrls.fnotificationHistory, data: {
      'userId': await _apiClient.getUserId(),
    });
    if (kDebugMode) {
      print("YOMAYG");
    }
    if (result.statusCode == 200 || result.statusCode == 201) {
      if (kDebugMode) {
        print("WAIT");
      }
      return NotificationHistoryEntity.fromJson(
          result.data as Map<String, dynamic>);
    } else {
      throw result.statusMessage!;
    }
  }

  @override
  Future<SubscriptionEntity> fsubscription({num? couponId}) async {
    final result = await _apiClient.post(LoopsUrls.fsubscription, data: {
      'userId': await _apiClient.getUserId(),
      'couponId': couponId ?? '',
    });
    if (result.statusCode == 200 || result.statusCode == 201) {
      return SubscriptionEntity.fromJson(result.data as Map<String, dynamic>);
    } else {
      throw result.statusMessage!;
    }
  }

  @override
  Future<ValidateReferalEntity> fvalidateReferral({String? coupon}) async {
    final result = await _apiClient.post(LoopsUrls.fvalidateReferral, data: {
      'coupon': coupon,
    });
    if (result.statusCode == 200 || result.statusCode == 201) {
      return ValidateReferalEntity.fromJson(
          result.data as Map<String, dynamic>);
    } else {
      throw result.statusMessage!;
    }
  }

  @override
  Future<List<FAQsEntity>> ffaq({required String type}) async {
    final result = await _apiClient.post(LoopsUrls.ffaq, data: {
      'type': type,
    });
    if (result.statusCode == 200 || result.statusCode == 201) {
      final List<FAQsEntity> list = [];

      // ignore: avoid_dynamic_calls
      (result.data['faqs'] as List).forEach((element) {
        list.add(FAQsEntity.fromJson(element as Map<String, dynamic>));
      });
      return list;
    } else {
      throw result.statusMessage!;
    }
  }

  @override
  Future<void> fnoticeClick({required String clicked}) async {
    final result = await _apiClient.post(LoopsUrls.fnoticeClick, data: {
      'userId': await _apiClient.getUserId(),
      'clicked': clicked,
    });
    if (result.statusCode == 200 || result.statusCode == 201) {
      return;
    } else {
      throw result.statusMessage!;
    }
  }

  @override
  Future<VideoModel> fgettingStartedVideos() async {
    final result = await _apiClient.post(LoopsUrls.fgettingStartedVideos);
    if (result.statusCode == 200 || result.statusCode == 201) {
      return VideoModel.fromJson(
          result.data as Map<String, dynamic>);
    } else {
      throw result.statusMessage!;
    }
  }

  @override
  Future<HomeReportsEntity> fhomeReports(String time) async{
    final result = await _apiClient.post(LoopsUrls.freports, data: {
      'userId': await _apiClient.getUserId(),
      'time': time,
       'home':'home'
    });
    if (result.statusCode == 200 || result.statusCode == 201) {
      return HomeReportsEntity.fromJson(result.data as Map<String, dynamic>);
    } else {
      throw result.statusMessage!;
    }
  }
}
