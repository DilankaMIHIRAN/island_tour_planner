import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:island_tour_planner/models/tripe_model.dart';
import 'package:island_tour_planner/screens/trip/view_trip.dart';
import 'package:island_tour_planner/screens/trip/widgets/trip_card.dart';
import 'package:provider/provider.dart';

import '../../../services/tripe_service.dart';
import '../../widgets/custom_loading.dart';

class TripList extends StatefulWidget {
  const TripList({super.key});

  @override
  State<TripList> createState() => _TripListState();
}

class _TripListState extends State<TripList> {
  TripService tripService = TripService();

  Future deleteTripPlan(String tripPlanId) async {
    LoadingIndicatorDialog().show(context);

    Map<String, dynamic> results = await tripService.deleteTripPlan(tripPlanId);

    LoadingIndicatorDialog().dismiss();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(results['message']),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final tripPlans = Provider.of<List<TripModel>>(context);
    return tripPlans.isNotEmpty
        ? SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: List.generate(
                tripPlans.length,
                (index) => Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) =>
                      deleteTripPlan(tripPlans[index].id.toString()),
                  background: Container(
                    width: size.width,
                    height: size.height * 0.5,
                    alignment: Alignment.centerRight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.orangeAccent.withOpacity(0.6),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.040,
                      ),
                      child: const Icon(
                        Iconsax.trash,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  child: TripCard(
                    trip: tripPlans[index],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewTrip(
                            trip: tripPlans[index],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          )
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'There\'s no trip plans.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: size.width * 0.040,
                    letterSpacing: 1,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.010,
                ),
                Text(
                  'Let\'s plan your first trip',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: size.width * 0.040,
                    letterSpacing: 1,
                  ),
                )
              ],
            ),
          );
  }
}
