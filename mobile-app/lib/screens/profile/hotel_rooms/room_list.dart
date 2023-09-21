import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:island_tour_planner/models/room_model.dart';
import 'package:island_tour_planner/screens/profile/hotel_rooms/edit_room.dart';
import 'package:island_tour_planner/services/accomodation_service.dart';
import 'package:provider/provider.dart';

import '../../widgets/custom_loading.dart';
import 'widgets/room_card.dart';

class RoomList extends StatefulWidget {
  final String uid;

  const RoomList({
    super.key,
    required this.uid,
  });

  @override
  State<RoomList> createState() => _RoomListState();
}

class _RoomListState extends State<RoomList> {
  Future deleteRoom(String roomId) async {
    LoadingIndicatorDialog().show(context);
    Map<String, dynamic> results =
        await AccomodationService(uid: widget.uid).deleteHotelRoom(roomId);
    LoadingIndicatorDialog().dismiss();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(results['message']),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final rooms = Provider.of<List<RoomModel>>(context);
    return rooms.isNotEmpty
        ? SingleChildScrollView(
            child: Column(
              children: List.generate(
                rooms.length,
                (index) => Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) =>
                      deleteRoom(rooms[index].id.toString()),
                  background: Container(
                    width: size.width,
                    height: size.height * 0.5,
                    alignment: Alignment.centerRight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.orangeAccent.withOpacity(0.6),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.040,
                      ),
                      child: const Icon(
                        Iconsax.trash,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  child: RoomCard(
                    room: rooms[index],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditHotelRoom(
                            uid: widget.uid,
                            room: rooms[index],
                          ),
                        ),
                      );
                    },
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
                  'There\'s no rooms.',
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
                  'Let\'s create your first room',
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
