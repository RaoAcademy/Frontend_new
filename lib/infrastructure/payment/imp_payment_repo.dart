import 'dart:async';
import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:ippo_pay/ippo_pay.dart';
import 'package:EdTestz/core/utli/api_client.dart';
import 'package:EdTestz/core/utli/error_handle.dart';
import 'package:EdTestz/core/utli/logger.dart';
// import 'package:EdTestz/core/utli/loops_urls.dart';
import 'package:EdTestz/domain/payment/payment_repo.dart';

import '../../core/utli/loops_urls.dart';

@LazySingleton(as: PaymentsRepo)
class ImpPaymentRepo implements PaymentsRepo {
  final APIClient _apiClient = APIClient();
  @override
  Future<void> fpayment(
      {required num? couponId,
      required num? coins,
      required num subsId,
      required String paymentMethod}) async {
    final result = await _apiClient.post(LoopsUrls.fpayment, data: {
      'userId': await _apiClient.getUserId(),
      'couponId': couponId,
      'coins': coins,
      'subsId': subsId,
      'paymentMethod': paymentMethod
    });
    if (result.statusCode == 200 || result.statusCode == 201) {
      return;
    } else {
      throw result.statusMessage!;
    }
  }

  @override
  Future<void> initPlatformState({
    required String orderId,
  }) async {
    try {
      IppoPay.initSdk('pk_test_yor2XNSAzGm0');
      IppoPay.setLogVisible(true);
      final result =
          await IppoPay.makePayment(json.encode({'order_id': orderId}));
      logger.d(result);
    } on Exception catch (exception) {
      await handleError(exception);
    }

    // Platform messages may fail, so we use a try/catch PlatformException.

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
  }
}
