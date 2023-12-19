class Time {
  String? name;
  DateTime? time;

  Time({
    this.name,
    this.time,
  });

  factory Time.fromJson(Map<String, dynamic> json) => Time(
    name: json["name"] as String?,
    time: DateTime.parse(json["time"] as String),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "time": "${time?.year.toString().padLeft(4, '0')}-${time?.month.toString().padLeft(2, '0')}-${time?.day.toString().padLeft(2, '0')}",
  };
}