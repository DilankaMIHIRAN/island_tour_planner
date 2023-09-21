import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../../models/cab_driver_model.dart';
import '../../models/hotel_model.dart';
import '../../models/tour_guide_model.dart';
import '../../services/accomodation_service.dart';
import '../../services/cab_service.dart';
import '../../services/tour_guide_service.dart';
import '../../services/tripe_service.dart';
import '../explore/widgets/cab/cabs.dart';
import '../explore/widgets/hotel/accomodations.dart';
import '../explore/widgets/tour_guide/tour_guides.dart';

class ViewTripOptions extends StatefulWidget {
  final String tripPlanId;

  const ViewTripOptions({
    super.key,
    required this.tripPlanId,
  });

  @override
  State<ViewTripOptions> createState() => _ViewTripOptionsState();
}

class _ViewTripOptionsState extends State<ViewTripOptions> {
  List<String> selectedHotels = [];
  List<String> selectedCabDrivers = [];
  List<String> selectedTourGuides = [];

  final TripService tripService = TripService();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'View Options',
          style: GoogleFonts.poppins(
            fontSize: size.width * 0.050,
          ),
        ),
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(Iconsax.arrow_left),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              StreamProvider<List<HotelModel>>.value(
                value: AccomodationService().hotels,
                initialData: const [],
                child: Accomodations(
                  isEnableLongPress: true,
                  onSelectedHotels: (hotels) {
                    setState(() {
                      selectedHotels = hotels;
                    });
                  },
                ),
              ),
              StreamProvider<List<TourGuideModel>>.value(
                value: TourGuideService().tourGuides,
                initialData: const [],
                child: TourGuides(
                  isEnableLongPress: true,
                  onSelectedTourGuides: (tourGuides) {
                    setState(() {
                      selectedTourGuides = tourGuides;
                    });
                  },
                ),
              ),
              StreamProvider<List<CabDriverModel>>.value(
                value: CabService().cabDrivers,
                initialData: const [],
                child: Cabs(
                  isEnableLongPress: true,
                  onSelectedCabDrivers: (cabDrivers) {
                    setState(() {
                      selectedCabDrivers = cabDrivers;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          Map<String, dynamic> results = await tripService.updateTripPlan(
            widget.tripPlanId.toString(),
            selectedHotels,
            selectedTourGuides,
            selectedCabDrivers,
          );

          if(results['status'] == true) {
            Navigator.of(context).pop();
          }

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(results['message']),
            ),
          );
        },
      ),
    );
  }
}
