import 'package:flutter/material.dart';
import 'package:island_tour_planner/models/tour_guide_model.dart';
import 'package:island_tour_planner/screens/trip/widgets/book_tour_guide_card.dart';
import 'package:provider/provider.dart';

class BookedTourGuides extends StatelessWidget {
  const BookedTourGuides({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final tourGuides = Provider.of<List<TourGuideModel>>(context);
    return SizedBox(
      height: size.height * 0.16,
      width: size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tourGuides.length,
        itemBuilder: (context, index) => BookTourGuideCard(
          tourGuide: tourGuides[index],
        ),
      ),
    );
  }
}
