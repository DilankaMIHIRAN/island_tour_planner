import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:island_tour_planner/models/event_model.dart';

class EventService {
  //collection referance
  final CollectionReference eventCollection =
      FirebaseFirestore.instance.collection('events');

  final String? eventId;

  EventService({this.eventId});

  //event list from snapshot
  List<EventModel> _eventListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs
        .map((doc) => EventModel(
              id: doc.id,
              name: doc.get('name'),
              image: doc.get('image'),
              location: doc.get('location'),
              date: doc.get('date'),
              description: doc.get('description'),
              ticketPrice: doc.get('ticketPrice').toString(),
            ))
        .toList();
  }

  //get events stream
  Stream<List<EventModel>> get events {
    return eventCollection.snapshots().map(_eventListFromSnapshot);
  }

  Stream<EventModel> get getEventByEventId {
    return eventCollection
        .doc(eventId)
        .snapshots()
        .map(_eventFromSnapshot);
  }

  EventModel _eventFromSnapshot(DocumentSnapshot snapshot) {
    return EventModel(
      id: snapshot.id,
      name: snapshot.get('name'),
      image: snapshot.get('image'),
      location: snapshot.get('location'),
      date: snapshot.get('date'),
      description: snapshot.get('description'),
      ticketPrice: snapshot.get('ticketPrice'),
    );
  }
}
