import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:island_tour_planner/models/tripe_model.dart';

class TripCard extends StatelessWidget {
  final TripModel trip;
  final void Function()? onTap;

  const TripCard({
    super.key,
    required this.trip,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: size.height * 0.010,
        ),
        child: Container(
          width: size.width,
          height: size.height * 0.20,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(1),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(0.0, 0.0),
                blurRadius: 5,
                spreadRadius: 1,
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      trip.tripName,
                      style: TextStyle(
                        fontSize: size.width * 0.040,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trip.status == "planned"
                        ? Container(
                            padding: EdgeInsets.all(size.width * 0.012),
                            decoration: BoxDecoration(
                              color: Colors.deepOrangeAccent,
                              borderRadius: BorderRadius.all(
                                Radius.circular(size.width * 0.010),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
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
                                  trip.status[0].toUpperCase() +
                                      trip.status.substring(1),
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(
                            padding: EdgeInsets.all(size.width * 0.012),
                            decoration: BoxDecoration(
                              color: Colors.greenAccent.shade700,
                              borderRadius: BorderRadius.all(
                                Radius.circular(size.width * 0.010),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
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
                                  trip.status[0].toUpperCase() +
                                      trip.status.substring(1),
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.010,
                ),
                Expanded(
                  child: Text(
                    trip.note,
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                    maxLines: 5,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.010,
                ),
                Row(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Iconsax.calendar,
                          size: size.width * 0.055,
                        ),
                        SizedBox(
                          width: size.width * 0.010,
                        ),
                        Text(trip.date)
                      ],
                    ),
                    SizedBox(
                      width: size.width * 0.020,
                    ),
                    const Text("|"),
                    SizedBox(
                      width: size.width * 0.020,
                    ),
                    Row(
                      children: [
                        Icon(
                          Iconsax.timer_start,
                          size: size.width * 0.055,
                        ),
                        SizedBox(
                          width: size.width * 0.010,
                        ),
                        Text('${trip.totalDays} Days'),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: size.height * 0.010,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Iconsax.dollar_circle),
                    SizedBox(
                      width: size.width * 0.010,
                    ),
                    Text("Rs. ${trip.budgetLimit}")
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
