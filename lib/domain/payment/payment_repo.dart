abstract class PaymentsRepo {
  // Future<SubscriptionEntity> fsubscription({num? couponId});
  Future<void> fpayment({
    required num? couponId,
    required num? coins,
    required num subsId,
    required String paymentMethod,
  });

  Future<void> initPlatformState({
    required String orderId,
  });
}
