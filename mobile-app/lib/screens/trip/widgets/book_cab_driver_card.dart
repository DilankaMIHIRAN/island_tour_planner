import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:island_tour_planner/models/cab_driver_model.dart';
import 'package:skeletons/skeletons.dart';

class BookCabDriverCard extends StatelessWidget {
  final CabDriverModel cabDriver;

  const BookCabDriverCard({
    super.key,
    required this.cabDriver,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.95,
      height: size.height * 0.14,
      margin: EdgeInsets.symmetric(
        vertical: size.height * 0.006,
        horizontal: size.width * 0.020,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
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
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              bottomLeft: Radius.circular(16),
            ),
            child: cabDriver.avatar!.isNotEmpty
                ? ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                    ),
                    child: Image.network(
                      cabDriver.avatar.toString(),
                      fit: BoxFit.cover,
                      width: size.width * 0.29,
                      height: size.height,
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
                  )
                : Image.asset(
                    'assets/images/avatar.jpg',
                    fit: BoxFit.cover,
                    width: size.width * 0.25,
                    height: size.height,
                  ),
          ),
          SizedBox(
            width: size.width * 0.010,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    cabDriver.name,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: size.width * 0.040,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.002,
                  ),
                  Text(
                    'Cab Driver',
                    style: GoogleFonts.poppins(),
                  ),
                  SizedBox(
                    height: size.height * 0.005,
                  ),
                  Text(
                    cabDriver.bio,
                    style: GoogleFonts.poppins(
                      fontSize: size.width * 0.035,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
