class SplashScreenEntity {
  SplashScreenEntity({this.imagePath, this.text1, this.text2});

  SplashScreenEntity.fromJson(Map<String, dynamic> json) {
    imagePath = json['imagePath'] as String?;
    text1 = json['text1'] as String?;
    text2 = json['text2'] as String?;
  }
  String? imagePath;
  String? text1;
  String? text2;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imagePath'] = imagePath;
    data['text1'] = text1;
    data['text2'] = text2;
    return data;
  }
}
