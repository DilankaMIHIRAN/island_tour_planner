import 'package:flutter/material.dart';
import 'package:island_tour_planner/screens/explore/explore.dart';
import 'package:island_tour_planner/screens/home/home.dart';
import 'package:island_tour_planner/screens/profile/profile.dart';
import 'package:island_tour_planner/screens/trip/trip.dart';
import 'package:island_tour_planner/screens/widgets/bottom_navbar.dart';

class Base extends StatefulWidget {
  const Base({super.key});

  @override
  State<Base> createState() => _BaseState();
}

class _BaseState extends State<Base> {

  int currentIndex = 0;

  List<Widget> children = [
    const Home(),
    const Explore(),
    const Trip(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: children[currentIndex],
      bottomNavigationBar: BottomNavbar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        } ,
      ),
    );
  }
}
