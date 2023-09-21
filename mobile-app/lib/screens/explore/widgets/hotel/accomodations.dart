import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:island_tour_planner/models/hotel_model.dart';
import 'package:island_tour_planner/screens/explore/view_hotel.dart';
import 'package:provider/provider.dart';
import 'hotel_card.dart';

class Accomodations extends StatefulWidget {
  final void Function(List<String>)? onSelectedHotels;
  final bool? isEnableLongPress;

  const Accomodations({
    super.key,
    this.onSelectedHotels,
    this.isEnableLongPress = false,
  });

  @override
  State<Accomodations> createState() => _AccomodationsState();
}

class _AccomodationsState extends State<Accomodations> {
  List<String> selectedHotels = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final hotels = Provider.of<List<HotelModel>>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: size.height * 0.010,
            horizontal: size.width * 0.030,
          ),
          child: Text(
            "Accomodations",
            style: GoogleFonts.poppins(
              fontSize: size.width * 0.040,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(
          height: size.height * 0.25,
          width: size.width,
          child: hotels.isNotEmpty
              ? ListView.builder(
                  itemCount: hotels.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => HotelCard(
                    hotel: hotels[index],
                    selectedHotel:
                        selectedHotels.contains(hotels[index].id) ? 2.5 : 0,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewHotel(
                            hotel: hotels[index],
                          ),
                        ),
                      );
                    },
                    onLongPress: () {
                      if (widget.isEnableLongPress == true) {
                        if (selectedHotels.contains(hotels[index].id)) {
                          selectedHotels.remove(hotels[index].id.toString());
                        } else {
                          selectedHotels.add(hotels[index].id.toString());
                        }
                        setState(() {});
                        widget.onSelectedHotels!(selectedHotels);
                      }
                    },
                  ),
                )
              : Center(
                  child: Text(
                    'No Accomodations found',
                    style: GoogleFonts.poppins(),
                  ),
                ),
        )
      ],
    );
  }
}
