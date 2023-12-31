const String tableNotes = 'user_info';

class UserFields {
  static final List<String> values = [
    /// Add all fields
    id, loginRequired, masterpswd
  ];

  static const String id = '_id';
  static const String loginRequired = 'loginRequired';
  static const String masterpswd = 'masterpswd';
}

class User {
  final int? id;
  final bool loginRequired;
  final String masterpswd;


  const User({
    this.id,
    required this.loginRequired,
    required this.masterpswd,
  });

  User copy({
    int? id,
    bool? loginRequired,
    String? masterpswd,
  }) =>
      User(
        id: id ?? this.id,
        loginRequired: loginRequired ?? this.loginRequired,
        masterpswd: masterpswd ?? this.masterpswd,
      );

  static User fromJson(Map<String, Object?> json) => User(
    id: json[UserFields.id] as int?,
    loginRequired: json[UserFields.loginRequired] == 0,
    masterpswd: json[UserFields.masterpswd] as String,
  );

  Map<String, Object?> toJson() => {
    UserFields.id: id,
    UserFields.loginRequired: loginRequired ? 1 : 0,
    UserFields.masterpswd: masterpswd,
  };
}