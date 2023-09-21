class CabDriverModel {

  final String? id;
  final String name;
  final String email;
  final String phoneNumber;
  final String bio;
  final String? avatar;
  final List<dynamic> languages;

  CabDriverModel({
    this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.bio,
    required this.languages,
    this.avatar
  });
}
