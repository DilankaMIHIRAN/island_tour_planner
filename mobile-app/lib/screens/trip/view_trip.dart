import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:island_tour_planner/models/cab_driver_model.dart';
import 'package:island_tour_planner/models/tour_guide_model.dart';
import 'package:island_tour_planner/models/tripe_model.dart';
import 'package:island_tour_planner/screens/trip/view_options.dart';
import 'package:island_tour_planner/screens/trip/widgets/booked_cab_drivers.dart';
import 'package:island_tour_planner/screens/trip/widgets/booked_tour_guide.dart';
import 'package:island_tour_planner/services/cab_service.dart';
import 'package:island_tour_planner/services/tour_guide_service.dart';
import 'package:island_tour_planner/services/tripe_service.dart';
import 'package:provider/provider.dart';

import '../../models/hotel_model.dart';
import '../../services/accomodation_service.dart';
import 'widgets/booked_hotels.dart';

class ViewTrip extends StatefulWidget {
  final TripModel trip;

  const ViewTrip({
    super.key,
    required this.trip,
  });

  @override
  State<ViewTrip> createState() => _ViewTripState();
}

class _ViewTripState extends State<ViewTrip> {
  final TripService tripService = TripService();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'View Trip Plan',
          style: GoogleFonts.poppins(
            fontSize: size.width * 0.050,
          ),
        ),
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(Iconsax.arrow_left),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              AlertDialog alert = AlertDialog(
                actionsAlignment: MainAxisAlignment.center,
                backgroundColor: Colors.white,
                title: Text(
                  "Are You Sure",
                  style: GoogleFonts.poppins(
                    fontSize: size.width * 0.040,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                content: Text(
                  "Are you sure to mark this trip plan as complete?",
                  style: GoogleFonts.poppins(
                    fontSize: size.width * 0.040,
                  ),
                  textAlign: TextAlign.center,
                ),
                actions: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent.shade200,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        side: BorderSide.none,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      "No",
                      style: GoogleFonts.poppins(
                        fontSize: size.width * 0.040,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent.shade700,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        side: BorderSide.none,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      "Yes",
                      style: GoogleFonts.poppins(
                        fontSize: size.width * 0.040,
                      ),
                    ),
                    onPressed: () async {
                      Map<String, dynamic> results = await tripService
                          .updateTripPlanStatus(widget.trip.id.toString());
                      if (results['status'] == true) {
                        Navigator.of(context).pop();
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(results['message']),
                        ),
                      );
                    },
                  )
                ],
              );

              showDialog(
                context: context,
                builder: (BuildContext context) => alert,
              );
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.040,
              ),
              child: Icon(
                Iconsax.tick_circle,
                size: size.width * 0.060,
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            width: size.width,
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.020,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.020,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Trip Name',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: size.width * 0.040),
                      ),
                      Text(
                        widget.trip.tripName,
                        style: GoogleFonts.poppins(
                          fontSize: size.width * 0.040,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.020,
                      ),
                      Text(
                        'Trip Note',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: size.width * 0.040,
                        ),
                      ),
                      Text(
                        widget.trip.note,
                        style: GoogleFonts.poppins(
                          fontSize: size.width * 0.040,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.020,
                      ),
                      Text(
                        "Plnned Date",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: size.width * 0.040,
                        ),
                      ),
                      Text(
                        widget.trip.date,
                        style: GoogleFonts.poppins(
                          fontSize: size.width * 0.040,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.020,
                      ),
                      Text(
                        "Total Days",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: size.width * 0.040,
                        ),
                      ),
                      Text(
                        widget.trip.totalDays,
                        style: GoogleFonts.poppins(
                          fontSize: size.width * 0.040,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.020,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Estimated Budget",
                                style: GoogleFonts.poppins(
                                  fontSize: size.width * 0.040,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "Rs.${widget.trip.budgetLimit}",
                                style: GoogleFonts.poppins(
                                  fontSize: size.width * 0.040,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              widget.trip.status == "planned"
                                  ? Container(
                                      padding:
                                          EdgeInsets.all(size.width * 0.012),
                                      decoration: BoxDecoration(
                                        color: Colors.deepOrangeAccent,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(size.width * 0.010),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Iconsax.verify,
                                            color: Colors.white,
                                            size: size.width * 0.050,
                                          ),
                                          SizedBox(
                                            width: size.width * 0.010,
                                          ),
                                          Text(
                                            widget.trip.status[0]
                                                    .toUpperCase() +
                                                widget.trip.status.substring(1),
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(
                                      padding:
                                          EdgeInsets.all(size.width * 0.012),
                                      decoration: BoxDecoration(
                                        color: Colors.greenAccent.shade700,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(size.width * 0.010),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Iconsax.verify,
                                            color: Colors.white,
                                            size: size.width * 0.050,
                                          ),
                                          SizedBox(
                                            width: size.width * 0.010,
                                          ),
                                          Text(
                                            widget.trip.status[0]
                                                    .toUpperCase() +
                                                widget.trip.status.substring(1),
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.020,
                      ),
                      Text(
                        "Choose Accomodations, Tour guide & Cabs",
                        style: GoogleFonts.poppins(
                            fontSize: size.width * 0.040,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.020,
                ),
                widget.trip.hotels!.isNotEmpty ||
                        widget.trip.cabDrivers!.isNotEmpty ||
                        widget.trip.tourGuides!.isNotEmpty
                    ? Column(
                        children: [
                          widget.trip.hotels!.isNotEmpty
                              ? StreamProvider<List<HotelModel>>.value(
                                  value: AccomodationService().getHotels(
                                      widget.trip.hotels as List<dynamic>),
                                  initialData: const [],
                                  child: const BookedHotels(),
                                )
                              : Container(),
                          widget.trip.tourGuides!.isNotEmpty
                              ? StreamProvider<List<TourGuideModel>>.value(
                                  value: TourGuideService().getTourGuides(
                                      widget.trip.tourGuides as List<dynamic>),
                                  initialData: const [],
                                  child: const BookedTourGuides(),
                                )
                              : Container(),
                          widget.trip.cabDrivers!.isNotEmpty
                              ? StreamProvider<List<CabDriverModel>>.value(
                                  value: CabService().getCabDrivers(
                                      widget.trip.cabDrivers as List<dynamic>),
                                  initialData: const [],
                                  child: const BookedCabDrivers(),
                                )
                              : Container(),
                        ],
                      )
                    : Container(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: size.height * 0.10,
                            ),
                            Icon(
                              Iconsax.additem,
                              size: size.width * 0.10,
                            ),
                            Text(
                              'No hotels, Tour guides & Cabs not assigned',
                              style: GoogleFonts.poppins(),
                            ),
                          ],
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ViewTripOptions(
                tripPlanId: widget.trip.id.toString(),
              ),
            ),
          );
        },
      ),
    );
  }
}
