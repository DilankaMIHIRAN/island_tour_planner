import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/event_model.dart';
import '../../event/view_event.dart';
import 'event_card.dart';

class EventCarousel extends StatelessWidget {
  const EventCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final events = Provider.of<List<EventModel>>(context);
    return CarouselSlider(
      items: List.generate(
        events.length,
        (index) => EventCard(
          image: events[index].image,
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ViewEvent(
                event: events[index],
              ),
            ),
          ),
        ),
      ),
      options: CarouselOptions(
        autoPlay: true,
        initialPage: 0,
        viewportFraction: 0.85,
        enlargeFactor: 0.2,
        height: size.height * 0.22,
        enlargeCenterPage: true,
        autoPlayInterval: const Duration(
          seconds: 2,
        ),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
