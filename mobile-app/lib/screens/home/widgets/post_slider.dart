import 'package:flutter/material.dart';
import 'package:island_tour_planner/screens/home/widgets/post_card.dart';

class PostSlider extends StatelessWidget {
  const PostSlider({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.10,
      child: ListView.builder(
        itemCount: 8,
        shrinkWrap: false,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.01,
        ),
        itemBuilder: (context, index) => const PostCard(),
      ),
    );
  }
}
