import 'package:flutter/material.dart';
import 'package:island_tour_planner/models/cab_driver_model.dart';
import 'package:provider/provider.dart';

import 'book_cab_driver_card.dart';

class BookedCabDrivers extends StatelessWidget {
  const BookedCabDrivers({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final cabDrivers = Provider.of<List<CabDriverModel>>(context);
    return SizedBox(
      height: size.height * 0.16,
      width: size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cabDrivers.length,
        itemBuilder: (context, index) => BookCabDriverCard(
          cabDriver: cabDrivers[index],
        ),
      ),
    );
  }
}