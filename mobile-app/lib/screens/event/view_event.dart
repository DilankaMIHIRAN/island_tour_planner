import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:island_tour_planner/models/event_model.dart';
import 'package:island_tour_planner/models/user_model.dart';
import 'package:island_tour_planner/screens/widgets/custom_button.dart';
import 'package:island_tour_planner/services/auth_service.dart';
import 'package:island_tour_planner/services/booking_service.dart';
import 'package:payhere_mobilesdk_flutter/payhere_mobilesdk_flutter.dart';
import 'package:skeletons/skeletons.dart';
import '../../common/theme.dart';

class ViewEvent extends StatefulWidget {
  final EventModel event;

  const ViewEvent({
    super.key,
    required this.event,
  });

  @override
  State<ViewEvent> createState() => _ViewEventState();
}

class _ViewEventState extends State<ViewEvent> {
  int noOfTickets = 1;

  BookingService bookingService = BookingService();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.event.name.toString(),
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: size.width,
                height: size.height * 0.30,
                child: Image.network(
                  widget.event.image.toString(),
                  fit: BoxFit.contain,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(
                      child: SkeletonAvatar(
                        style: SkeletonAvatarStyle(
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.020),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(Iconsax.calendar),
                        SizedBox(
                          width: size.width * 0.020,
                        ),
                        Text(
                          widget.event.date.toString(),
                          style: GoogleFonts.poppins(
                            fontSize: size.width * 0.040,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.020,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(Iconsax.building),
                        SizedBox(
                          width: size.width * 0.020,
                        ),
                        Expanded(
                          child: Text(
                            widget.event.location.toString(),
                            style: GoogleFonts.poppins(
                              fontSize: size.width * 0.040,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            softWrap: false,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.020,
                    ),
                    Center(
                      child: SizedBox(
                        width: size.width * 0.90,
                        child: Divider(
                          color: Colors.grey.withOpacity(0.3),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.010,
                    ),
                    Text(
                      'What we\'ll be doing',
                      style: GoogleFonts.poppins(
                        fontSize: size.width * 0.045,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.010,
                    ),
                    Text(
                      widget.event.description.toString(),
                      style: GoogleFonts.poppins(
                        fontSize: size.width * 0.040,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.020,
                    ),
                    Text(
                      'Tickets',
                      style: GoogleFonts.poppins(
                        fontSize: size.width * 0.045,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.010,
                    ),
                    Text(
                      'Rs.${widget.event.ticketPrice.toString()}/= for per person ',
                      style: GoogleFonts.poppins(
                        fontSize: size.width * 0.040,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.025,
                    ),
                    Text(
                      'No of Tickets',
                      style: GoogleFonts.poppins(
                        fontSize: size.width * 0.040,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.020,
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: primaryColor,
                          child: IconButton(
                            color: Colors.black,
                            onPressed: () {
                              setState(() {
                                noOfTickets++;
                              });
                            },
                            icon: const Icon(
                              Iconsax.add,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.040,
                        ),
                        SizedBox(
                          width: size.width * 0.060,
                          child: Text(
                            noOfTickets.toString(),
                            style: GoogleFonts.poppins(
                              fontSize: size.width * 0.050,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.020,
                        ),
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: primaryColor,
                          child: IconButton(
                            color: Colors.black,
                            onPressed: () {
                              if (noOfTickets != 1) {
                                setState(() {
                                  noOfTickets--;
                                });
                              }
                            },
                            icon: const Icon(
                              Iconsax.minus,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.030,
                    ),
                    StreamBuilder<UserModel>(
                      stream: AuthService().authUser,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          UserModel? user = snapshot.data;
                          return SizedBox(
                            width: size.width * 0.40,
                            height: size.height * 0.050,
                            child: CustomButton(
                              title: 'Buy Ticket',
                              fontSize: size.width * 0.038,
                              onPressed: () async {
                                Map<String, dynamic> paymentObject = {
                                  "sandbox": true,
                                  "merchant_id": "1220933",
                                  "notify_url": "",
                                  "order_id": widget.event.id,
                                  "items": widget.event.name,
                                  "amount":
                                      double.parse(widget.event.ticketPrice*noOfTickets)
                                          .toStringAsFixed(2),
                                  "currency": "LKR",
                                  "first_name": user!.name,
                                  "last_name": "",
                                  "email": user.email,
                                  "phone": user.phoneNumber,
                                  "address": "",
                                  "city": "Colombo",
                                  "country": "Sri Lanka",
                                };

                                PayHere.startPayment(paymentObject,
                                    (paymentId) async {
                                  Map<String, dynamic> results =
                                      await bookingService.buyTicket(
                                    user.uid,
                                    widget.event.id,
                                    widget.event.name,
                                    noOfTickets,
                                    double.parse(widget.event.ticketPrice) *
                                        noOfTickets,
                                    paymentId,
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(results['message']),
                                    ),
                                  );
                                }, (error) {
                                  print(
                                      "One Time Payment Failed. Error: $error");
                                }, () {
                                  print("One Time Payment Dismissed");
                                });
                              },
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}