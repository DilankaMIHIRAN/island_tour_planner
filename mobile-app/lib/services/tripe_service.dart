import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:island_tour_planner/models/tripe_model.dart';

class TripService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final CollectionReference tripPlanCollection =
      FirebaseFirestore.instance.collection('trips');

  List<TripModel> _tripPlanListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((doc) {
      return TripModel(
        id: doc.id,
        tripName: doc.get('tripName'),
        date: doc.get('date'),
        totalDays: doc.get('totalDays'),
        budgetLimit: doc.get('budgetLimit'),
        note: doc.get('note'),
        status: doc.get('status'),
        hotels: doc.get('hotels') ?? [],
        cabDrivers: doc.get('cabDrivers') ?? [],
        tourGuides: doc.get('tourGuides') ?? [],
      );
    }).toList();
  }

  Stream<List<TripModel>> get tripPlans {
    return tripPlanCollection
        .doc(_auth.currentUser!.uid)
        .collection('plans')
        .snapshots()
        .map(_tripPlanListFromSnapshot);
  }

  Future<Map<String, dynamic>> createTripPlan(TripModel tripModel) async {
    late Map<String, dynamic> results = {
      'status': false,
      'message': null,
    };
    try {
      Map<String, dynamic> dataMap = tripModel.toJson();
      await tripPlanCollection
          .doc(_auth.currentUser!.uid)
          .collection('plans')
          .add(dataMap)
          .then((value) {
        results['status'] = true;
        results['message'] = "Successfully added your trip plan";
      });
    } catch (e) {
      results['status'] = false;
      results['message'] = e.toString();
    }
    return results;
  }

  Future<Map<String, dynamic>> deleteTripPlan(String tripPlanId) async {
    late Map<String, dynamic> results = {
      'status': false,
      'message': null,
    };
    try {
      await tripPlanCollection
          .doc(_auth.currentUser!.uid)
          .collection('plans')
          .doc(tripPlanId)
          .delete();
      results['status'] = true;
      results['message'] = "Successfully added your trip plan";
    } catch (e) {
      results['status'] = false;
      results['message'] = e.toString();
    }
    return results;
  }

  Future<Map<String, dynamic>> updateTripPlanStatus(String tripPlanId) async {
    late Map<String, dynamic> results = {
      'status': false,
      'message': null,
    };
    try {
      await tripPlanCollection
          .doc(_auth.currentUser!.uid)
          .collection('plans')
          .doc(tripPlanId)
          .set({'status': 'completed'}, SetOptions(merge: true));
      results['status'] = true;
      results['message'] = "Successfully update trip plan status.";
    } catch (e) {
      results['status'] = false;
      results['message'] = e.toString();
    }
    return results;
  }

  Future<Map<String, dynamic>> updateTripPlan(
    String tripPlanId,
    List<String> hotels,
    List<String> tourGuides,
    List<String> cabDrivers,
  ) async {
    late Map<String, dynamic> results = {
      'status': false,
      'message': null,
    };

    try {
      await tripPlanCollection
          .doc(_auth.currentUser!.uid)
          .collection('plans')
          .doc(tripPlanId)
          .set(
        {
          'hotels': hotels,
          'tourGuides': tourGuides,
          'cabDrivers': cabDrivers,
        },
        SetOptions(merge: true),
      );
      results['status'] = true;
      results['message'] = "Successfully update trip plan.";
    } catch (e) {
      results['status'] = false;
      results['message'] = e.toString();
    }
    return results;
  }
}
