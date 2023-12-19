class ProfileDetailsEntity {
  String? avatarImagePath;
  BadgeActivity? badgeActivity;
  List<BadgeActivityUpcoming>? badgeActivityUpcoming;
  BadgePerformance? badgePerformance;
  List<BadgePerformanceUpcoming>? badgePerformanceUpcoming;
  BadgeProgress? badgeProgress;
  List<BadgeProgressUpcoming>? badgeProgressUpcoming;
  String? name;
  int? numberOfLoopsTaken;
  int? numberOfSignedPeople;
  int? numberOfTestsTaken;
  bool? profileCompletion;
  int? testsRemaining;
  int? totalTests;

  ProfileDetailsEntity({
    this.avatarImagePath,
    this.badgeActivity,
    this.badgeActivityUpcoming,
    this.badgePerformance,
    this.badgePerformanceUpcoming,
    this.badgeProgress,
    this.badgeProgressUpcoming,
    this.name,
    this.numberOfLoopsTaken,
    this.numberOfSignedPeople,
    this.numberOfTestsTaken,
    this.profileCompletion,
    this.testsRemaining,
    this.totalTests,
  });

  Map<String, dynamic> toJson() {
    return {
      'avatarImagePath': avatarImagePath,
      'badgeActivity': badgeActivity,
      'badgeActivityUpcoming': badgeActivityUpcoming,
      'badgePerformance': badgePerformance,
      'badgePerformanceUpcoming': badgePerformanceUpcoming,
      'badgeProgress': badgeProgress,
      'badgeProgressUpcoming': badgeProgressUpcoming,
      'name': name,
      'numberOfLoopsTaken': numberOfLoopsTaken,
      'numberOfSignedPeople': numberOfSignedPeople,
      'numberOfTestsTaken': numberOfTestsTaken,
      'profileCompletion': profileCompletion,
      'testsRemaining': testsRemaining,
      'totalTests': totalTests,
    };
  }

  factory ProfileDetailsEntity.fromJson(Map<String, dynamic> json) {
    return ProfileDetailsEntity(
      avatarImagePath: json['avatarImagePath'] as String?,
      badgeActivity: json['badgeActivity'] == null
          ? null
          : BadgeActivity.fromJson(
              json['badgeActivity'] as Map<String, dynamic>),
      badgeActivityUpcoming: (json['badgeActivityUpcoming'] as List<dynamic>?)
          ?.map(
              (e) => BadgeActivityUpcoming.fromJson(e as Map<String, dynamic>))
          .toList(),
      badgePerformance: json['badgePerformance'] == null
          ? null
          : BadgePerformance.fromJson(
              json['badgePerformance'] as Map<String, dynamic>),
      badgePerformanceUpcoming:
          (json['badgePerformanceUpcoming'] as List<dynamic>?)
              ?.map((e) =>
                  BadgePerformanceUpcoming.fromJson(e as Map<String, dynamic>))
              .toList(),
      badgeProgress: json['badgeProgress'] == null
          ? null
          : BadgeProgress.fromJson(
              json['badgeProgress'] as Map<String, dynamic>),
      badgeProgressUpcoming: (json['badgeProgressUpcoming'] as List<dynamic>?)
          ?.map(
              (e) => BadgeProgressUpcoming.fromJson(e as Map<String, dynamic>))
          .toList(),
      name: json['name'] as String?,
      numberOfLoopsTaken: json['numberOfLoopsTaken'] as int?,
      numberOfSignedPeople: json['numberOfSignedPeople'] as int?,
      numberOfTestsTaken: json['numberOfTestsTaken'] as int?,
      profileCompletion: json['profileCompletion'] as bool?,
      testsRemaining: json['testsRemaining'] as int?,
      totalTests: json['totalTests'] as int?,
    );
  }
}

class BadgeActivity {
  String? date;
  String? imagePath;
  String? message;

  BadgeActivity({
    this.date,
    this.imagePath,
    this.message,
  });

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'imagePath': imagePath,
      'message': message,
    };
  }

  factory BadgeActivity.fromJson(Map<String, dynamic> json) {
    return BadgeActivity(
      date: json['date'] as String?,
      imagePath: json['imagePath'] as String?,
      message: json['message'] as String?,
    );
  }
}

class BadgeActivityUpcoming {
  String? date;
  String? imagePath;
  String? message;

  BadgeActivityUpcoming({
    this.date,
    this.imagePath,
    this.message,
  });

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'imagePath': imagePath,
      'message': message,
    };
  }

  factory BadgeActivityUpcoming.fromJson(Map<String, dynamic> json) {
    return BadgeActivityUpcoming(
      date: json['date'] as String?,
      imagePath: json['imagePath'] as String?,
      message: json['message'] as String?,
    );
  }
}

class BadgePerformance {
  String? date;
  String? imagePath;
  String? message;

  BadgePerformance({
    this.date,
    this.imagePath,
    this.message,
  });

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'imagePath': imagePath,
      'message': message,
    };
  }

  factory BadgePerformance.fromJson(Map<String, dynamic> json) {
    return BadgePerformance(
      date: json['date'] as String?,
      imagePath: json['imagePath'] as String?,
      message: json['message'] as String?,
    );
  }
}

class BadgePerformanceUpcoming {
  String? date;
  String? imagePath;
  String? message;

  BadgePerformanceUpcoming({
    this.date,
    this.imagePath,
    this.message,
  });

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'imagePath': imagePath,
      'message': message,
    };
  }

  factory BadgePerformanceUpcoming.fromJson(Map<String, dynamic> json) {
    return BadgePerformanceUpcoming(
      date: json['date'] as String?,
      imagePath: json['imagePath'] as String?,
      message: json['message'] as String?,
    );
  }
}

class BadgeProgress {
  String? date;
  String? imagePath;
  String? message;

  BadgeProgress({
    this.date,
    this.imagePath,
    this.message,
  });

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'imagePath': imagePath,
      'message': message,
    };
  }

  factory BadgeProgress.fromJson(Map<String, dynamic> json) {
    return BadgeProgress(
      date: json['date'] as String?,
      imagePath: json['imagePath'] as String?,
      message: json['message'] as String?,
    );
  }
}

class BadgeProgressUpcoming {
  String? date;
  String? imagePath;
  String? message;

  BadgeProgressUpcoming({
    this.date,
    this.imagePath,
    this.message,
  });

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'imagePath': imagePath,
      'message': message,
    };
  }

  factory BadgeProgressUpcoming.fromJson(Map<String, dynamic> json) {
    return BadgeProgressUpcoming(
      date: json['date'] as String?,
      imagePath: json['imagePath'] as String?,
      message: json['message'] as String?,
    );
  }
}

// class ProfileDetailsEntity {
//   ProfileDetailsEntity(
//       {this.avatarImagePath,
//       this.badgeActivity,
//       this.badgeActivityUpcoming,
//       this.badgePerformance,
//       this.badgePerformanceUpcoming,
//       // this.badgeProgress,
//       this.badgeProgressUpcoming,
//       this.name,
//       this.numberOfLoopsTaken,
//       this.numberOfSignedPeople,
//       this.numberOfTestsTaken,
//       this.profileCompletion,
//       this.testsRemaining,
//       this.totalTests});
//
//   ProfileDetailsEntity.fromJson(Map<String, dynamic> json) {
//     avatarImagePath = json['avatarImagePath'] as String?;
//     badgeActivity = json['badgeActivity'] as String?;
//     badgeActivityUpcoming =
//         (json['badgeActivityUpcoming'] as List).cast<String>();
//     badgePerformance = json['badgePerformance'] as String?;
//     badgePerformanceUpcoming =
//         (json['badgePerformanceUpcoming'] as List).cast<String>();
//     // badgeProgress = json['badgeProgress'] as String?;
//     badgeProgressUpcoming =
//         (json['badgeProgressUpcoming'] as List).cast<String>();
//        /*  badgeProgress =
//         (json['badgeProgress'] as List).cast<String>(); */
//     name = json['name'] as String?;
//     numberOfLoopsTaken = json['numberOfLoopsTaken'] as num?;
//     numberOfSignedPeople = json['numberOfSignedPeople'] as num?;
//     numberOfTestsTaken = json['numberOfTestsTaken'] as num?;
//     profileCompletion = json['profileCompletion'] as bool?;
//     testsRemaining = json['testsRemaining'] as num?;
//     totalTests = json['totalTests'] as num?;
//   }
//
//   String? avatarImagePath;
//   String? badgeActivity;
//   List<String>? badgeActivityUpcoming;
//   String? badgePerformance;
//   List<String>? badgePerformanceUpcoming;
//   // List<String>? badgeProgress;
//   List<String>? badgeProgressUpcoming;
//   String? name;
//   num? numberOfLoopsTaken;
//   num? numberOfSignedPeople;
//   num? numberOfTestsTaken;
//   bool? profileCompletion;
//   num? testsRemaining;
//   num? totalTests;
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['avatarImagePath'] = avatarImagePath;
//     data['badgeActivity'] = badgeActivity;
//     data['badgeActivityUpcoming'] = badgeActivityUpcoming;
//     data['badgePerformance'] = badgePerformance;
//     data['badgePerformanceUpcoming'] = badgePerformanceUpcoming;
//     // data['badgeProgress'] = badgeProgress;
//     data['badgeProgressUpcoming'] = badgeProgressUpcoming;
//     data['name'] = name;
//     data['numberOfLoopsTaken'] = numberOfLoopsTaken;
//     data['numberOfSignedPeople'] = numberOfSignedPeople;
//     data['numberOfTestsTaken'] = numberOfTestsTaken;
//     data['profileCompletion'] = profileCompletion;
//     data['testsRemaining'] = testsRemaining;
//     data['totalTests'] = totalTests;
//     return data;
//   }
// }
