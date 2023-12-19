class TestEntity {
  TestEntity(
      {this.noOfQs,
      this.coins,
      this.imagePath,
      this.leftTop,
      this.rightTop,
      this.testId,
      this.text1,
      this.text2,
      this.text3,
      this.time,
      this.userTestId});

  TestEntity.fromJson(Map<String, dynamic> json) {
    noOfQs = json['NoOfQs'] as num?;
    coins = json['coins'] as num?;
    imagePath = json['imagePath'] as String?;
    leftTop = json['leftTop'] as String?;
    rightTop = json['rightTop'] as String?;
    testId = json['testId'] as num?;
    text1 = json['text1'] as String?;
    text2 = json['text2'] as String?;
    text3 = json['text3'] as String?;
    time = json['time'] as num?;
    userTestId = json['userTestId'] as num?;
  }
  num? noOfQs;
  num? coins;
  String? imagePath;
  String? leftTop;
  String? rightTop;
  num? testId;
  String? text1;
  String? text2;
  String? text3;
  num? time;
  num? userTestId;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['NoOfQs'] = noOfQs;
    data['coins'] = coins;
    data['imagePath'] = imagePath;
    data['leftTop'] = leftTop;
    data['rightTop'] = rightTop;
    data['testId'] = testId;
    data['text1'] = text1;
    data['text2'] = text2;
    data['text3'] = text3;
    data['time'] = time;
    data['userTestId'] = userTestId;
    return data;
  }
}
