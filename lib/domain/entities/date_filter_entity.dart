class DateFilter {
  DateFilter({this.thisMonth, this.thisWeek, this.thisYear});

  DateFilter.fromJson(Map<String, dynamic> json) {
    thisMonth = json['This month'] as String?;
    thisWeek = json['This week'] as String?;
    thisYear = json['This year'] as String?;
  }

  String? thisMonth;
  String? thisWeek;
  String? thisYear;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['This month'] = thisMonth;
    data['This week'] = thisWeek;
    data['This year'] = thisYear;
    return data;
  }
}
