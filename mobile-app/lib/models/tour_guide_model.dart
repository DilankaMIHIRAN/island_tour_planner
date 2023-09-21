class TourGuideModel {
  final String? id;
  final String bio;
  final List<dynamic> languages;
  final String? image;
  final String name;
  final String email;
  final String phoneNumber;

  TourGuideModel({
    this.id,
    required this.bio,
    required this.languages,
    required this.email,
    required this.name,
    required this.phoneNumber,
    this.image,
  });
}
