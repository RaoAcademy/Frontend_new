class Subscriptions {
  Subscriptions(
      {this.comment,
      this.gstAmount,
      this.maxReedemableCoins,
      this.numberOfTests,
      this.price,
      this.strikedPrice,
      this.subsId,
      this.subsName,
      this.validity,
      this.youPay,
      this.yourReedemableCoins});

  Subscriptions.fromJson(Map<String, dynamic> json) {
    comment = json['comment'] as String?;
    gstAmount = json['gstAmount'] as num?;
    maxReedemableCoins = json['maxRedeemableCoins'] as num?;
    numberOfTests = json['numberOfTests'] as num?;
    price = json['price'] as num?;
    strikedPrice = json['strikedPrice'] as num?;
    subsId = json['subsId'] as num?;
    subsName = json['subsName'] as String?;
    validity = json['validity'] as num?;
    youPay = json['you pay'] as num?;
    yourReedemableCoins = json['yourRedeemableCoins'] as num?;
  }

  String? comment;
  num? gstAmount;
  num? maxReedemableCoins;
  num? numberOfTests;
  num? price;
  num? strikedPrice;
  num? subsId;
  String? subsName;
  num? validity;
  num? youPay;
  num? yourReedemableCoins;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['comment'] = comment;
    data['gstAmount'] = gstAmount;
    data['maxRedeemableCoins'] = maxReedemableCoins;
    data['numberOfTests'] = numberOfTests;
    data['price'] = price;
    data['strikedPrice'] = strikedPrice;
    data['subsId'] = subsId;
    data['subsName'] = subsName;
    data['validity'] = validity;
    data['you pay'] = youPay;
    data['yourRedeemableCoins'] = yourReedemableCoins;
    return data;
  }
}
