import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:island_tour_planner/models/user_model.dart';
import 'package:island_tour_planner/services/onboard_service.dart';
import 'package:path/path.dart' as path;

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final storage = FirebaseStorage.instance;
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Stream<User?> get user {
    return _auth.authStateChanges();
  }

  UserModel _userFromFirebaseUser(DocumentSnapshot snapshot) {
    return UserModel(
      uid: _auth.currentUser!.uid,
      name: snapshot.get('name'),
      email: snapshot.get('email'),
      phoneNumber: snapshot.get('phoneNumber'),
      role: snapshot.get('role'),
      avatar: snapshot.get('avatar'),
    );
  }

  Stream<UserModel> get authUser {
    return userCollection
        .doc(_auth.currentUser!.uid)
        .snapshots()
        .map(_userFromFirebaseUser);
  }

  Future<Map<String, dynamic>> loginUser(String email, String password) async {
    late Map<String, dynamic> results = {
      'status': false,
      'message': null,
    };
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      results['status'] = true;
      results['message'] = "Successfully logged";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        results['status'] = false;
        results['message'] = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        results['status'] = false;
        results['message'] = 'Wrong password provided for that user.';
      }
    } catch (e) {
      results['status'] = false;
      results['message'] = e.toString();
    }
    return results;
  }

  Future<Map<String, dynamic>> createUser(Map<String, dynamic> data) async {
    late Map<String, dynamic> results = {
      'status': false,
      'message': null,
    };
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: data['email'],
        password: data['password'],
      );

      await OnboardService(uid: userCredential.user!.uid).updateUserProfile(
        data['name'],
        data['email'],
        data['phoneNumber'],
        data['role'],
        data['avatar'],
      );

      if (userCredential.user != null) {
        if (data['role'] == "tour_guide") {
          await OnboardService(uid: userCredential.user!.uid).onboardTourGuide(
            data['name'],
            data['email'],
            data['phoneNumber'],
            data['bio'],
            data['languages'],
          );
        } else if (data['role'] == "hotel") {
          await OnboardService(uid: userCredential.user!.uid).onboardHotel(
            data['hotelName'],
            data['bio'],
            data['phoneNumber'],
            data['managerName'],
            data['avatar'],
          );
        } else if (data['role'] == "cab_driver") {
          await OnboardService(uid: userCredential.user!.uid).onboardCabDriver(
            data['name'],
            data['email'],
            data['phoneNumber'],
            data['bio'],
            data['languages'],
          );
        }
      }
      results['status'] = true;
      results['message'] = "Successfully registered";

      // await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        results['status'] = false;
        results['message'] = "The password provided is too weak.";
      } else if (e.code == 'email-already-in-use') {
        results['status'] = false;
        results['message'] = "The account already exists for that email.";
      }
    } catch (e) {
      results['status'] = false;
      results['message'] = e.toString();
    }
    return results;
  }

  Future<Map<String, dynamic>> logout() async {
    late Map<String, dynamic> results = {
      'status': false,
      'message': null,
    };
    try {
      await _auth.signOut();
      results['status'] = true;
      results['message'] = "Successfully Logged out";
    } catch (e) {
      results['status'] = false;
      results['message'] = e.toString();
    }
    return results;
  }

  Future<Map<String, dynamic>> updateUserAccount(
    String name,
    String email,
    String phoneNumber,
    XFile? avatar,
    String bio,
    List languages,
    String role,
  ) async {
    late Map<String, dynamic> results = {
      'status': false,
      'message': null,
    };
    try {
      Map<String, dynamic> userData = {
        'name': name,
        'email': email,
        'phoneNumber': phoneNumber,
      };

      String downloadUrl = "";

      if (avatar != null) {
        String fileName = path.basename(avatar.path);
        final Reference storageRef = storage.ref().child('avatars/$fileName');
        final UploadTask uploadTask = storageRef.putFile(File(avatar.path));

        final TaskSnapshot snapshot = await uploadTask;
        downloadUrl = await snapshot.ref.getDownloadURL();

        userData['avatar'] = downloadUrl;
      }

      await userCollection
          .doc(_auth.currentUser!.uid)
          .set(userData, SetOptions(merge: true))
          .then((value) async {
        if (role == "cab_driver") {
          CollectionReference cabDriverCollection =
              FirebaseFirestore.instance.collection('cab_drivers');
          await cabDriverCollection.doc(_auth.currentUser!.uid).set({
            'name': name,
            'email': email,
            'phoneNumber': phoneNumber,
            'bio': bio,
            'languages': languages,
            'avatar': downloadUrl,
          }, SetOptions(merge: true));
        } else if (role == "tour_guide") {
          CollectionReference tourGuideCollection =
              FirebaseFirestore.instance.collection('tour_guides');
          await tourGuideCollection.doc(_auth.currentUser!.uid).set({
            'name': name,
            'email': email,
            'phoneNumber': phoneNumber,
            'bio': bio,
            'languages': languages,
            'avatar': downloadUrl,
          }, SetOptions(merge: true));
        }
      });

      results['status'] = true;
      results['message'] = "Successfully updated.";
    } catch (e) {
      results['status'] = false;
      results['message'] = e.toString();
    }
    return results;
  }

  Future<Map<String, dynamic>> changePassword(
    String currentPassword,
    String newPassword,
  ) async {
    late Map<String, dynamic> results = {
      'status': false,
      'message': null,
    };
    try {
      User? user = _auth.currentUser;

      AuthCredential credential = EmailAuthProvider.credential(
        email: user!.email.toString(),
        password: currentPassword,
      );
      await user.reauthenticateWithCredential(credential).then((value) async {
        await user.updatePassword(newPassword).then((value) async {
          results['status'] = true;
          results['message'] = "Password Successfully updated.";
        });
      });
    } catch (e) {
      results['status'] = false;
      results['message'] = e.toString();
    }
    return results;
  }

  Future<Map<String, dynamic>> signInWithGoogle() async {
    late Map<String, dynamic> results = {
      'status': false,
      'message': null,
    };
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await _auth
          .fetchSignInMethodsForEmail(googleUser!.email)
          .then((value) async {
        if (value[0].isNotEmpty) {
          return await _auth.signInWithCredential(credential);
        } else {
          results['status'] = false;
          results['message'] = 'No user account found related to this email';
        }
      });
    } catch (e) {
      results['status'] = false;
      results['message'] = 'No user account found related to this email';
    }
    return results;
  }

  Future<Map<String, dynamic>> forgotPassword(String email) async {
    late Map<String, dynamic> results = {
      'status': false,
      'message': null,
    };
    try {
      await _auth.sendPasswordResetEmail(email: email).then((value) {
        results['status'] = true;
        results['message'] = "Please check your email. Password reset email successfuly sent.";
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        results['status'] = false;
        results['message'] = "No user found for that email.";
      }
    } catch (e) {
      results['status'] = false;
      results['message'] = e.toString();
    }
    return results;
  }
}
