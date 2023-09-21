class TripModel {
  final String? id;
  final String tripName;
  final String date;
  final String totalDays;
  final String budgetLimit;
  final String note;
  final String status;
  final List<dynamic>? hotels;
  final List<dynamic>? cabDrivers;
  final List<dynamic>? tourGuides;

  TripModel({
    this.id,
    required this.tripName,
    required this.date,
    required this.totalDays,
    required this.budgetLimit,
    required this.note,
    required this.status,
    this.hotels,
    this.cabDrivers,
    this.tourGuides,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tripName': tripName,
      'date': date,
      'totalDays': totalDays,
      'budgetLimit': budgetLimit,
      'note': note,
      'status': status,
      'hotels': hotels,
      'cabDrivers': cabDrivers,
      'tourGuides': tourGuides,
    };
  }

  factory TripModel.fromJson(Map<String, dynamic> json) {
    return TripModel(
      id: json['id'].toString(),
      tripName: json['tripName'].toString(),
      date: json['date'].toString(),
      totalDays: json['totalDays'].toString(),
      budgetLimit: json['budgetLimit'].toString(),
      note: json['note'].toString(),
      status: json['status'].toString(),
      tourGuides: json['tourGuides'] as List<dynamic>,
      cabDrivers: json['cabDrivers'] as List<dynamic>,
      hotels: json['hotels'] as List<dynamic>,
    );
  }
}
