class ValidateReferalEntity {
  ValidateReferalEntity({this.referrerId, this.valid});
  ValidateReferalEntity.fromJson(Map<String, dynamic> json) {
    referrerId = json['ReferrerId'] as num?;
    valid = json['valid'] as bool?;
  }
  num? referrerId;
  bool? valid;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ReferrerId'] = referrerId;
    data['valid'] = valid;
    return data;
  }
}
