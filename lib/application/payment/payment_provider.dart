import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:rao_academy/domain/payment/payment_repo.dart';

@injectable
class PaymentProvider extends ChangeNotifier {
  PaymentProvider(this.repo);

  final PaymentsRepo repo;

  Future<void> fpayment({
    required num? couponId,
    required num? coins,
    required num subsId,
    required String paymentMethod,
  }) async {
    await repo.fpayment(
      couponId: couponId,
      coins: coins,
      subsId: subsId,
      paymentMethod: paymentMethod,
    );
  }

  Future<void> initPlatformState(String orderId) async {
    await repo.initPlatformState(orderId: orderId);
  }
}
