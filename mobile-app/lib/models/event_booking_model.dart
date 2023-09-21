class EventBookingModel {
  final String uid;
  final String eventId;
  final String eventName;
  final int noOfTickets;
  final String paymentReference;
  final String price;

  EventBookingModel({
    required this.uid,
    required this.eventName,
    required this.eventId,
    required this.noOfTickets,
    required this.paymentReference,
    required this.price,
  });
}
