class Performance {
  Performance(
      {this.fri, this.mon, this.sat, this.sun, this.thu, this.tue, this.wed});

  Performance.fromJson(Map<String, dynamic> json) {
    mon = json['Mon'] as num?;
    tue = json['Tue'] as num?;
    wed = json['Wed'] as num?;
    thu = json['Thu'] as num?;
    fri = json['Fri'] as num?;
    sat = json['Sat'] as num?;
    sun = json['Sun'] as num?;
  }
  num? fri;
  num? mon;
  num? sat;
  num? sun;
  num? thu;
  num? tue;
  num? wed;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Mon'] = mon;
    data['Tue'] = tue;
    data['Wed'] = wed;
    data['Thu'] = thu;
    data['Fri'] = fri;
    data['Sat'] = sat;
    data['Sun'] = sun;
    return data;
  }
}
