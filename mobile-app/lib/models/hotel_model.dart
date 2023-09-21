class HotelModel {

  final String? id;
  final String hotelName;
  final String managerName;
  final String phoneNumber;
  final String bio;
  final String? logo;

  HotelModel({
    this.id,
    required this.hotelName,
    required this.managerName,
    required this.phoneNumber,
    required this.bio,
    this.logo,
  });
}