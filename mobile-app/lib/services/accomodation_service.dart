import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:island_tour_planner/models/hotel_model.dart';
import 'package:island_tour_planner/models/room_model.dart';
import 'package:path/path.dart' as path;

class AccomodationService {
  final CollectionReference hotelsCollection =
      FirebaseFirestore.instance.collection('hotels');

  final storage = FirebaseStorage.instance;

  final String? uid;

  AccomodationService({this.uid});

  Stream<List<HotelModel>> get hotels {
    return hotelsCollection.snapshots().map(_hotelListFromSnapshot);
  }

  Stream<HotelModel> get hotel {
    return hotelsCollection.doc(uid).snapshots().map(_hotelFromSnapshot);
  }

  Stream<List<RoomModel>> get rooms {
    return hotelsCollection
        .doc(uid)
        .collection('rooms')
        .snapshots()
        .map(_hotelRoomsFromSnapshot);
  }

  Stream<List<HotelModel>> getHotels(List<dynamic> hotelIds) {
    return hotelsCollection
        .where(FieldPath.documentId, whereIn: hotelIds)
        .snapshots()
        .map(_hotelListFromSnapshot);
  }

  List<HotelModel> _hotelListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs
        .map((doc) => HotelModel(
              id: doc.id,
              hotelName: doc.get('hotelName'),
              managerName: doc.get('managerName'),
              phoneNumber: doc.get('phoneNumber'),
              bio: doc.get('bio'),
              logo: doc.get('logo'),
            ))
        .toList();
  }

  HotelModel _hotelFromSnapshot(DocumentSnapshot snapshot) {
    return HotelModel(
      hotelName: snapshot.get('hotelName'),
      managerName: snapshot.get('managerName'),
      phoneNumber: snapshot.get('phoneNumber'),
      bio: snapshot.get('bio'),
      logo: snapshot.get('logo'),
    );
  }

  List<RoomModel> _hotelRoomsFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs
        .map((doc) => RoomModel(
              id: doc.id,
              roomTitle: doc.get('roomTitle'),
              roomDescription: doc.get('roomDescription'),
              roomPrice: doc.get('roomPrice'),
            ))
        .toList();
  }

  Future<Map<String, dynamic>> updateHotelProfile(
    String hotelName,
    String bio,
    String phoneNumber,
    String managerName,
    XFile? avatar,
  ) async {
    late Map<String, dynamic> results = {
      'status': false,
      'message': null,
    };
    try {
      Map<String, dynamic> hotelData = {
        'hotelName': hotelName,
        'bio': bio,
        'phoneNumber': phoneNumber,
        'managerName': managerName,
      };

      if (avatar != null) {
        String fileName = path.basename(avatar.path);
        final Reference storageRef = storage.ref().child('hotels/$fileName');
        final UploadTask uploadTask = storageRef.putFile(File(avatar.path));

        final TaskSnapshot snapshot = await uploadTask;
        final String downloadUrl = await snapshot.ref.getDownloadURL();
        hotelData['logo'] = downloadUrl;
      }

      await hotelsCollection.doc(uid).set(hotelData, SetOptions(merge: true));
      results['status'] = true;
      results['message'] = "Hotel Profile successfully updated";
    } catch (e) {
      results['status'] = false;
      results['message'] = e.toString();
    }
    return results;
  }

  Future<Map<String, dynamic>> createHotelRoom({
    required String title,
    required String description,
    required String price,
  }) async {
    late Map<String, dynamic> results = {
      'status': false,
      'message': null,
    };
    try {
      await hotelsCollection.doc(uid).collection('rooms').add({
        'roomTitle': title,
        'roomDescription': description,
        'roomPrice': price
      }).then((value) {
        results['status'] = true;
        results['message'] = "Room successfully created";
      });
    } catch (e) {
      results['status'] = false;
      results['message'] = e.toString();
    }
    return results;
  }

  Future<Map<String, dynamic>> updateHotelRoom({
    required String roomId,
    required String title,
    required String description,
    required String price,
  }) async {
    late Map<String, dynamic> results = {
      'status': false,
      'message': null,
    };
    try {
      await hotelsCollection.doc(uid).collection('rooms').doc(roomId).set({
        'roomTitle': title,
        'roomDescription': description,
        'roomPrice': price
      }).then((value) {
        results['status'] = true;
        results['message'] = "Room successfully updated";
      });
    } catch (e) {
      results['status'] = false;
      results['message'] = e.toString();
    }
    return results;
  }

  Future<Map<String, dynamic>> deleteHotelRoom(String roomId) async {
    late Map<String, dynamic> results = {
      'status': false,
      'message': null,
    };
    try {
      await hotelsCollection
          .doc(uid)
          .collection('rooms')
          .doc(roomId)
          .delete()
          .then((value) {
        results['status'] = true;
        results['message'] = "Room successfully deleted";
      });
    } catch (e) {
      results['status'] = false;
      results['message'] = e.toString();
    }
    return results;
  }
}
