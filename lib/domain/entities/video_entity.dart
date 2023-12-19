// To parse this JSON data, do
//
//     final videoModel = videoModelFromJson(jsonString);

import 'dart:convert';

VideoModel videoModelFromJson(String str) => VideoModel.fromJson(json.decode(str) as Map<String,dynamic>);

String videoModelToJson(VideoModel data) => json.encode(data.toJson());

class VideoModel {
  List<VideoM>? videos;

  VideoModel({
    this.videos,
  });

 VideoModel.fromJson(Map<String, dynamic> json) {
    if (json['videos'] != null) {
      videos = <VideoM>[];
      (json['videos'] as List).forEach((v) {
        videos!.add(VideoM.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  Map<String, dynamic> toJson() => {
    "videos": List<dynamic>.from(videos!.map((x) => x.toJson())),
  };
}

class VideoM {
  String? imagePath;
  String? name;
  String? url;

  VideoM({
    this.imagePath,
    this.name,
    this.url,
  });

  factory VideoM.fromJson(Map<String, dynamic> json) => VideoM(
    imagePath: json["imagePath"] as String?,
    name: json["name"] as String?,
    url: json["url"] as String?,
  );

  Map<String, dynamic> toJson() => {
    "imagePath": imagePath,
    "name": name,
    "url": url,
  };
}



