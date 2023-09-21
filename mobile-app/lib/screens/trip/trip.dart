import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:island_tour_planner/models/tripe_model.dart';
import 'package:island_tour_planner/screens/trip/widgets/trip_list.dart';
import 'package:island_tour_planner/services/tripe_service.dart';
import 'package:provider/provider.dart';

class Trip extends StatelessWidget {
  const Trip({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Trips',
          style: GoogleFonts.poppins(
            fontSize: size.width * 0.050,
          ),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: StreamProvider<List<TripModel>>.value(
          value: TripService().tripPlans, 
          initialData: const [],
          child: const TripList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Iconsax.add),
        onPressed: () => Navigator.of(context).pushNamed('/create_trip'),
      ),
    );
  }
}
