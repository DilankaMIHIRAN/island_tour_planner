import 'package:flutter/material.dart';
import 'package:island_tour_planner/screens/trip/widgets/book_hotel_card.dart';
import 'package:provider/provider.dart';

import '../../../models/hotel_model.dart';

class BookedHotels extends StatelessWidget {
  const BookedHotels({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final hotels = Provider.of<List<HotelModel>>(context);
    return SizedBox(
      height: size.height * 0.16,
      width: size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: hotels.length,
        itemBuilder: (context, index) => BookHotelCard(
          hotel: hotels[index],
        ),
      ),
    );

  }
}
