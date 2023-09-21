import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:island_tour_planner/models/popular_destination_model.dart';

class PopularDestinationService {
  final CollectionReference popularDestinationCollection =
      FirebaseFirestore.instance.collection('popular_destinations');

  List<PopularDestinationModel> _popularDestinationListFromSnapshot(
      QuerySnapshot querySnapshot) {
    return querySnapshot.docs
        .map((doc) => PopularDestinationModel(
              name: doc.get('name'),
              image: doc.get('image'),
            ))
        .toList();
  }

  Stream<List<PopularDestinationModel>> get popularDestinations {
    return popularDestinationCollection.snapshots().map(_popularDestinationListFromSnapshot);
  }
}
