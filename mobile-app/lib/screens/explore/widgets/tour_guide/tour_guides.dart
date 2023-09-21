import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:island_tour_planner/models/tour_guide_model.dart';
import 'package:island_tour_planner/screens/explore/view_tour_guide.dart';
import 'package:provider/provider.dart';

import 'tour_guide_card.dart';

class TourGuides extends StatefulWidget {
  final void Function(List<String>)? onSelectedTourGuides;
  final bool? isEnableLongPress;

  const TourGuides({
    super.key,
    this.isEnableLongPress,
    this.onSelectedTourGuides,
  });

  @override
  State<TourGuides> createState() => _TourGuidesState();
}

class _TourGuidesState extends State<TourGuides> {

  List<String> selectedTourGuides = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final tourGuides = Provider.of<List<TourGuideModel>>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: size.height * 0.010,
            horizontal: size.width * 0.030,
          ),
          child: Text(
            "Tour Guides",
            style: GoogleFonts.poppins(
              fontSize: size.width * 0.040,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(
          height: size.height * 0.25,
          child: tourGuides.isNotEmpty
              ? ListView.builder(
                  itemCount: tourGuides.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => TourGuideCard(
                    tourGuide: tourGuides[index],
                     selectedTourGuide: selectedTourGuides.contains(tourGuides[index].id)
                            ? 2.5
                            : 0,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewTourGuide(
                            tourGuide: tourGuides[index],
                          ),
                        ),
                      );
                    },
                    onLongPress: () {
                      if (widget.isEnableLongPress == true) {
                        if (selectedTourGuides.contains(tourGuides[index].id)) {
                          selectedTourGuides.remove(tourGuides[index].id.toString());
                        } else {
                          selectedTourGuides.add(tourGuides[index].id.toString());
                        }
                        setState(() {});
                        widget.onSelectedTourGuides!(selectedTourGuides);
                      }
                    },
                  ),
                )
              : Center(
                  child: Text(
                    'No Tour Guides found',
                    style: GoogleFonts.poppins(),
                  ),
                ),
        ),
      ],
    );
  }
}
