class CouponEntity {
  CouponEntity({this.couponId, this.value});

  CouponEntity.fromJson(Map<String, dynamic> json) {
    couponId = json['couponId'] as num?;
    error = json['error'] as String?;
    value = json['value'] != null ? json['value'] as num : 0;
  }
  num? couponId;
  String? error;
  num? value;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['couponId'] = couponId;
    data['value'] = value;
    return data;
  }
}
