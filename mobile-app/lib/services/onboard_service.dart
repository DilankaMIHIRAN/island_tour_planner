import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class OnboardService {
  final String? uid;

  OnboardService({this.uid});

  final CollectionReference tourGuideCollection =
      FirebaseFirestore.instance.collection('tour_guides');
  final CollectionReference hotelCollection =
      FirebaseFirestore.instance.collection('hotels');
  final CollectionReference cabDriverCollection =
      FirebaseFirestore.instance.collection('cab_drivers');
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  final storage = FirebaseStorage.instance;

  Future updateUserProfile(
    String name,
    String email,
    String phoneNumber,
    String role,
    XFile? avatar,
  ) async {
    String downloadUrl = "";
    if (avatar != null) {
      String fileName = path.basename(avatar.path);
      final Reference storageRef = storage.ref().child('avatars/$fileName');
      final UploadTask uploadTask = storageRef.putFile(File(avatar.path));

      final TaskSnapshot snapshot = await uploadTask;
      downloadUrl = await snapshot.ref.getDownloadURL();
    }

    return userCollection.doc(uid).set({
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'role': role,
      'avatar': downloadUrl
    });
  }

  Future onboardTourGuide(
    String name,
    String email,
    String phoneNumber,
    String bio,
    List<String> languages,
  ) async {
    return tourGuideCollection.doc(uid).set({
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'bio': bio,
      'languages': languages,
      'avatar': ''
    });
  }

  Future onboardCabDriver(
    String name,
    String email,
    String phoneNumber,
    String bio,
    List<String> languages,
  ) {
    return cabDriverCollection.doc(uid).set({
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'bio': bio,
      'languages': languages,
      'avatar': ''
    });
  }

  Future onboardHotel(
    String hotelName,
    String bio,
    String phoneNumber,
    String managerName,
    XFile? avatar,
  ) async {
    Map<String, dynamic> hotelData = {
      'hotelName': hotelName,
      'bio': bio,
      'phoneNumber': phoneNumber,
      'managerName': managerName,
      'logo': ''
    };

    if (avatar != null) {
      String fileName = path.basename(avatar.path);
      final Reference storageRef = storage.ref().child('hotels/$fileName');
      final UploadTask uploadTask = storageRef.putFile(File(avatar.path));

      final TaskSnapshot snapshot = await uploadTask;
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      hotelData['logo'] = downloadUrl;
    }

    return hotelCollection.doc(uid).set(hotelData);
  }
}
