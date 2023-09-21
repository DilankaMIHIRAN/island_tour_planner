import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:island_tour_planner/models/room_model.dart';
import 'package:island_tour_planner/screens/profile/hotel_rooms/create_hotel_room.dart';
import 'package:island_tour_planner/screens/profile/hotel_rooms/room_list.dart';
import 'package:island_tour_planner/services/accomodation_service.dart';
import 'package:provider/provider.dart';

class HotelRooms extends StatelessWidget {
  final String uid;

  const HotelRooms({
    super.key,
    required this.uid,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Rooms',
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
        padding: const EdgeInsets.all(10.0),
        child: StreamProvider<List<RoomModel>>.value(
          value: AccomodationService(uid: uid).rooms,
          initialData: const [],
          child: RoomList(
            uid: uid,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateHotelRoom(
                uid: uid,
              ),
            ),
          );
        },
        child: const Icon(Iconsax.add),
      ),
    );
  }
}
