class Sprint {
  Sprint({this.achieved, this.coins, this.target, this.timetaken});

  Sprint.fromJson(Map<String, dynamic> json) {
    achieved = json['achieved'] as num?;
    coins = json['coins'] as num?;
    target = json['target'] as num?;
    timetaken = json['timetaken'] as num?;
    userTestId = json['userTestId'] as num?;
  }

  num? achieved;
  num? coins;
  num? target;
  num? timetaken;
  num? userTestId;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['achieved'] = achieved;
    data['coins'] = coins;
    data['target'] = target;
    data['timetaken'] = timetaken;
    data['userTestId'] = userTestId;
    return data;
  }
}
