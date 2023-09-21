import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:island_tour_planner/models/event_booking_model.dart';
import 'package:qr_flutter/qr_flutter.dart';

class BookingTicket extends StatefulWidget {
  final EventBookingModel eventBookingModel;

  const BookingTicket({
    super.key,
    required this.eventBookingModel,
  });

  @override
  State<BookingTicket> createState() => _BookingTicketState();
}

class _BookingTicketState extends State<BookingTicket> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Event Ticket',
          style: GoogleFonts.poppins(
            fontSize: size.width * 0.050,
          ),
        ),
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(Iconsax.arrow_left),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.eventBookingModel.eventName,
              style: GoogleFonts.poppins(
                fontSize: size.width * 0.055,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: size.height * 0.020,
            ),
            QrImageView(
              data:
                  '${widget.eventBookingModel.eventId}-${widget.eventBookingModel.uid}',
              version: QrVersions.auto,
              size: size.width * 0.60,
            ),
            SizedBox(
              height: size.height * 0.020,
            ),
            Text(
              "Scan this QR \nfor your Ticket",
              style: GoogleFonts.poppins(
                fontSize: size.width * 0.045,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
