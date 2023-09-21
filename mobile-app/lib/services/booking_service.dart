import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:island_tour_planner/models/event_booking_model.dart';

class BookingService {
  final CollectionReference eventBookingCollection =
      FirebaseFirestore.instance.collection('event_booking');

  final String? uid;

  BookingService({this.uid});

  Future<Map<String, dynamic>> buyTicket(
    String uid,
    String eventId,
    String eventName,
    int noOfTickets,
    double price,
    String paymentReference,
  ) async {
    late Map<String, dynamic> results = {
      'status': false,
      'message': null,
    };
    try {
      await eventBookingCollection.add({
        'uid': uid,
        'eventId': eventId,
        'eventName': eventName,
        'noOfTickets': noOfTickets,
        'price': price,
        'paymentReference': paymentReference
      });
      results['status'] = true;
      results['message'] = "Booking Successfully";
    } catch (e) {
      results['status'] = false;
      results['message'] = e.toString();
    }
    return results;
  }

  Stream<List<EventBookingModel>> get userBookedEvents {
    return eventBookingCollection
        .where('uid', isEqualTo: uid)
        .snapshots()
        .map(_eventBookingListFromSnapshot);
  }

  List<EventBookingModel> _eventBookingListFromSnapshot(
      QuerySnapshot querySnapshot) {
    return querySnapshot.docs
        .map((doc) => EventBookingModel(
              uid: doc.get('uid'),
              eventId: doc.get('eventId'),
              eventName: doc.get('eventName'),
              noOfTickets: doc.get('noOfTickets'),
              paymentReference: doc.get('paymentReference'),
              price: doc.get('price').toString(),
            ))
        .toList();
  }
}
