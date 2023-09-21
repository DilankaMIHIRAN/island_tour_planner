import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/cab_driver_model.dart';

class CabService {
  final CollectionReference cabsCollection =
      FirebaseFirestore.instance.collection('cab_drivers');

  final String? uid;

  CabService({this.uid});

  Stream<List<CabDriverModel>> get cabDrivers {
    return cabsCollection.snapshots().map(_cabsListFromSnapshot);
  }

  Stream<CabDriverModel> get cabDriver {
    return cabsCollection.doc(uid).snapshots().map(_cabFromSnapshot);
  }

  Stream<List<CabDriverModel>> getCabDrivers(List<dynamic> cabIds) {
    return cabsCollection
        .where(FieldPath.documentId, whereIn: cabIds)
        .snapshots()
        .map(_cabsListFromSnapshot);
  }


  List<CabDriverModel> _cabsListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs
        .map(
          (doc) => CabDriverModel(
            id: doc.id,
            name: doc.get('name'),
            email: doc.get('email'),
            phoneNumber: doc.get('phoneNumber'),
            bio: doc.get('bio'),
            languages: doc.get('languages'),
            avatar: doc.get('avatar')
          ),
        )
        .toList();
  }

  CabDriverModel _cabFromSnapshot(DocumentSnapshot snapshot) {
    return CabDriverModel(
      id: snapshot.id,
      name: snapshot.get('name'),
      email: snapshot.get('email'),
      phoneNumber: snapshot.get('phoneNumber'),
      bio: snapshot.get('bio'),
      languages: snapshot.get('languages'),
      avatar: snapshot.get('avatar'),
    );
  }
}
