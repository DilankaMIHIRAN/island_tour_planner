import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../models/room_model.dart';

class HotelRoomList extends StatelessWidget {
  const HotelRoomList({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final rooms = Provider.of<List<RoomModel>>(context);
    return rooms.isNotEmpty
        ? Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.015,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(
                rooms.length,
                (index) => Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: size.height * 0.010,
                  ),
                  child: Container(
                    width: size.width,
                    padding: EdgeInsets.symmetric(
                      vertical: size.height * 0.005,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
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
                          Text(
                            rooms[index].roomTitle,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.010,
                          ),
                          Text(
                            rooms[index].roomDescription,
                            style: GoogleFonts.poppins(),
                          ),
                          SizedBox(
                            height: size.height * 0.010,
                          ),
                          Text(
                            'Rs.${rooms[index].roomPrice}',
                            style: GoogleFonts.poppins(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        : Text(
            'No Rooms Found',
            style: GoogleFonts.poppins(),
          );
  }
}
