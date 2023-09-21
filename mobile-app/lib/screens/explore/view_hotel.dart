import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:island_tour_planner/models/hotel_model.dart';
import 'package:island_tour_planner/screens/explore/widgets/hotel/room_list.dart';
import 'package:provider/provider.dart';
import 'package:skeletons/skeletons.dart';

import '../../models/room_model.dart';
import '../../services/accomodation_service.dart';

class ViewHotel extends StatelessWidget {
  final HotelModel hotel;

  const ViewHotel({
    super.key,
    required this.hotel,
  });

  Widget getImage() {
    if (hotel.logo!.isNotEmpty) {
      return Image.network(
        hotel.logo.toString(),
        fit: BoxFit.cover,
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
      );
    }
    return Image.asset(
      'assets/images/hotel.jpeg',
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          hotel.hotelName.toString(),
          style: GoogleFonts.poppins(
            fontSize: size.width * 0.050,
          ),
        ),
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(Iconsax.arrow_left),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: size.width,
              height: size.height * 0.35,
              child: getImage(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.025,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.020,
                  ),
                  Center(
                    child: Text(
                      hotel.hotelName,
                      style: GoogleFonts.poppins(
                        fontSize: size.width * 0.045,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.020,
                  ),
                  Text(
                    hotel.bio,
                    style: GoogleFonts.poppins(
                      fontSize: size.width * 0.040,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.020,
                  ),
                  Text(
                    'Manager - ${hotel.managerName}',
                    style: GoogleFonts.poppins(
                      fontSize: size.width * 0.040,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.010,
                  ),
                  Text(
                    'Contact - ${hotel.phoneNumber}',
                    style: GoogleFonts.poppins(
                      fontSize: size.width * 0.040,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.015,
            ),
            Text(
              "Rooms",
              style: GoogleFonts.poppins(
                fontSize: size.width * 0.045,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: size.height * 0.010,
            ),
            StreamProvider<List<RoomModel>>.value(
              value: AccomodationService(uid: hotel.id).rooms, 
              initialData: const [],
              child: const HotelRoomList(),
            ),
             SizedBox(
              height: size.height * 0.10,
            ),
          ],
        ),
      ),
    );
  }
}
