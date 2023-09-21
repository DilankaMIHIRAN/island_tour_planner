import 'package:flutter/material.dart';
import 'package:island_tour_planner/models/popular_destination_model.dart';
import 'package:provider/provider.dart';

import 'popular_card.dart';

class PopularDestinationSlider extends StatelessWidget {
  const PopularDestinationSlider({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final popularDestinations =
        Provider.of<List<PopularDestinationModel>>(context);
    return SizedBox(
      height: size.height * 0.25,
      child: ListView.builder(
        itemCount: popularDestinations.length,
        shrinkWrap: false,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.01,
        ),
        itemBuilder: (context, index) => PopularCard(
          popularDestination: popularDestinations[index],
        ),
      ),
    );
  }
}
