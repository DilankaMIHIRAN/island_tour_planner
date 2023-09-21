import 'package:flutter/material.dart';
import 'package:island_tour_planner/models/room_model.dart';

class RoomCard extends StatelessWidget {
  final RoomModel room;
  final void Function()? onTap;

  const RoomCard({
    super.key,
    required this.room,
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
          height: size.height * 0.17,
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
                Text(
                  room.roomTitle,
                  style: TextStyle(
                    fontSize: size.width * 0.040,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.015,
                ),
                Text(
                  'Rs. ${room.roomPrice}',
                  style: TextStyle(
                    fontSize: size.width * 0.035,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.015,
                ),
                Expanded(
                  child: Text(
                    room.roomDescription,
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                    maxLines: 5,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
