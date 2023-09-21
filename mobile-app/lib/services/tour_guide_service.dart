import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:island_tour_planner/models/tour_guide_model.dart';

class TourGuideService {
  final CollectionReference tourGuideCollection =
      FirebaseFirestore.instance.collection('tour_guides');

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  final String? uid;

  TourGuideService({this.uid});

  Stream<List<TourGuideModel>> get tourGuides {
    return tourGuideCollection.snapshots().map(_tourGuideListFromSnapshot);
  }

  Stream<TourGuideModel> get tourGuide {
    return tourGuideCollection.doc(uid).snapshots().map(_tourGuideFromSnapshot);
  }

   Stream<List<TourGuideModel>> getTourGuides(List<dynamic> tourGuideIds) {
    return tourGuideCollection
        .where(FieldPath.documentId, whereIn: tourGuideIds)
        .snapshots()
        .map(_tourGuideListFromSnapshot);
  }

  List<TourGuideModel> _tourGuideListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs
        .map(
          (doc) => TourGuideModel(
            id: doc.id,
            bio: doc.get('bio'),
            languages: doc.get('languages'),
            name: doc.get('name'),
            email: doc.get('email'),
            phoneNumber: doc.get('phoneNumber'),
            image: doc.get('avatar')
          ),
        )
        .toList();
  }

  TourGuideModel _tourGuideFromSnapshot(DocumentSnapshot snapshot) {
    return TourGuideModel(
      id: snapshot.id,
      bio: snapshot.get('bio'),
      languages: snapshot.get('languages'),
      name: snapshot.get('name'),
      email: snapshot.get('email'),
      phoneNumber: snapshot.get('phoneNumber'),
      image: snapshot.get('avatar'),
    );
  }
}
