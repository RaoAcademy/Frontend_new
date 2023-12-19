class NotificationHistoryEntity {
  List<Notifications>? notifications;

  NotificationHistoryEntity({
    this.notifications,
  });

  NotificationHistoryEntity copyWith({
    List<Notifications>? notifications,
  }) {
    return NotificationHistoryEntity(
      notifications: notifications ?? this.notifications,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'notifications': notifications,
    };
  }

  factory NotificationHistoryEntity.fromJson(Map<String, dynamic> json) {
    return NotificationHistoryEntity(
      notifications: (json['notifications'] as List<dynamic>?)
          ?.map((e) => Notifications.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Notifications {
  String? imagePath;
  String? message;
  String? title;

  Notifications({
    this.imagePath,
    this.message,
    this.title,
  });

  Notifications copyWith({
    String? imagePath,
    String? message,
    String? title,
  }) {
    return Notifications(
      imagePath: imagePath ?? this.imagePath,
      message: message ?? this.message,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imagePath': imagePath,
      'message': message,
      'title': title,
    };
  }

  factory Notifications.fromJson(Map<String, dynamic> json) {
    return Notifications(
      imagePath: json['imagePath'] as String?,
      message: json['message'] as String?,
      title: json['title'] as String?,
    );
  }
}
