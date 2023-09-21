import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:island_tour_planner/models/event_booking_model.dart';

class EventBookingCard extends StatelessWidget {
  final EventBookingModel eventBooking;
  final void Function()? onTap;

  const EventBookingCard({
    super.key,
    required this.eventBooking,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: size.width,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: size.height * 0.010,
          ),
          child: Container(
            width: size.width,
            padding: EdgeInsets.symmetric(
              vertical: size.height * 0.010,
              horizontal: size.width * 0.030,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: const Offset(0.0, 0.0),
                  blurRadius: 5,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  eventBooking.eventName,
                  style: GoogleFonts.poppins(
                    fontSize: size.width * 0.040,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.010,
                ),
                Text(
                  "Payment Ref - ${eventBooking.paymentReference}",
                  style: GoogleFonts.poppins(
                    fontSize: size.width * 0.035,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.010,
                ),
                Text(
                  "No of Ticket - ${eventBooking.noOfTickets}",
                  style: GoogleFonts.poppins(
                    fontSize: size.width * 0.035,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.010,
                ),
                Text(
                  "Rs.${eventBooking.price}",
                  style: GoogleFonts.poppins(
                    fontSize: size.width * 0.035,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.010,
                ),
                Container(
                  padding: EdgeInsets.all(size.width * 0.012),
                  decoration: const BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Text(
                    "Paid",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
