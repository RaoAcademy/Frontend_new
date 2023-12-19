class AuthEntity {
  AuthEntity({
    required this.userId,
  });
  int userId;

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
    };
  }
}
