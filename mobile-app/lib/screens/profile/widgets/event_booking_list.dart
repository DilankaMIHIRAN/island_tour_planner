import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:island_tour_planner/models/event_booking_model.dart';
import 'package:island_tour_planner/screens/profile/view_ticket.dart';
import 'package:island_tour_planner/screens/profile/widgets/event_booking_card.dart';
import 'package:provider/provider.dart';

class EventBookingList extends StatelessWidget {
  const EventBookingList({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final eventBookings = Provider.of<List<EventBookingModel>>(context);
    return eventBookings.isNotEmpty
        ? SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: List.generate(
                eventBookings.length,
                (index) => EventBookingCard(
                  eventBooking: eventBookings[index],
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookingTicket(
                        eventBookingModel: eventBookings[index],
                      ),
                    ),
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
                  'There\'s no event booking.',
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
                  'Let\'s book your first event',
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
