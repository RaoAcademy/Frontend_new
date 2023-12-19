class UserTests {
  UserTests({
    this.id,
  });
  factory UserTests.fromMap(Map<String, dynamic> map) {
    return UserTests(
      id: map['id'] as num?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
    };
  }

  num? id;
}
