class ReferralEntity {
  ReferralEntity(
      {this.numberOfPeopleSubscribed,
      this.numberOfSignedPeople,
      this.referral,
      this.rewards});

  ReferralEntity.fromJson(Map<String, dynamic> json) {
    numberOfPeopleSubscribed = json['numberOfPeopleSubscribed'] as num?;
    numberOfSignedPeople = json['numberOfSignedPeople'] as num?;
    referral = json['referral'] as String?;
    rewards = json['rewards'] as num?;
  }
  num? numberOfPeopleSubscribed;
  num? numberOfSignedPeople;
  String? referral;
  num? rewards;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['numberOfPeopleSubscribed'] = numberOfPeopleSubscribed;
    data['numberOfSignedPeople'] = numberOfSignedPeople;
    data['referral'] = referral;
    data['rewards'] = rewards;
    return data;
  }
}
