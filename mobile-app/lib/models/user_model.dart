class UserModel {
  final String uid;
  final String name;
  final String email;
  final String role;
  final String phoneNumber;
  final String? avatar;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.role,
    this.avatar,
  });
}
