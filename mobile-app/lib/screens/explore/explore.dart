import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:island_tour_planner/models/cab_driver_model.dart';
import 'package:island_tour_planner/models/hotel_model.dart';
import 'package:island_tour_planner/models/tour_guide_model.dart';
import 'package:island_tour_planner/services/accomodation_service.dart';
import 'package:island_tour_planner/services/cab_service.dart';
import 'package:island_tour_planner/services/tour_guide_service.dart';
import 'package:provider/provider.dart';

import 'widgets/cab/cabs.dart';
import 'widgets/hotel/accomodations.dart';
import 'widgets/tour_guide/tour_guides.dart';
class Explore extends StatelessWidget {
  const Explore({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Explore',
          style: GoogleFonts.poppins(
            fontSize: size.width * 0.050,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StreamProvider<List<HotelModel>>.value(
                value: AccomodationService().hotels,
                initialData: const [],
                child: const Accomodations(),
              ),
              SizedBox(
                height: size.height * 0.010,
              ),
              StreamProvider<List<TourGuideModel>>.value(
                value: TourGuideService().tourGuides,
                initialData: const [],
                child: const TourGuides(),
              ),
              SizedBox(
                height: size.height * 0.010,
              ),
              StreamProvider<List<CabDriverModel>>.value(
                value: CabService().cabDrivers,
                initialData: const [],
                child: const Cabs(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
