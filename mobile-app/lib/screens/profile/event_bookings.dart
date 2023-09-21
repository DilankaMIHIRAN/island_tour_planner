import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:island_tour_planner/screens/profile/widgets/event_booking_list.dart';
import 'package:island_tour_planner/services/booking_service.dart';
import 'package:provider/provider.dart';

import '../../models/event_booking_model.dart';

class EventBookings extends StatelessWidget {
  const EventBookings({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final user = Provider.of<User?>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Event Bookings',
          style: GoogleFonts.poppins(
            fontSize: size.width * 0.050,
          ),
        ),
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(Iconsax.arrow_left),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamProvider<List<EventBookingModel>>.value(
          value: BookingService(uid: user!.uid).userBookedEvents,
          initialData: const[],
          child: const EventBookingList(),
        ),
      ),
    );
  }
}