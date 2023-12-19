class AppVersionEntity {
  AppVersionEntity({this.version,this.update,this.status,this.forced});

  AppVersionEntity.fromJson(Map<String, dynamic> json) {
    version = json['version'] as num?;
    status = json['status'] as num?;
    forced = json['forced'] as bool?;
    update = json['update'] as bool?;
  }
  num? version;
  num? status;
  bool? forced;
  bool? update;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['version'] = version;
    data['status'] = status;
    data['forced'] = forced;
    data['update'] = update;
    return data;
  }
}


/*
{
    "forced": true,
    "status": 1,
    "update": true,
    "version": 0
}
*/
