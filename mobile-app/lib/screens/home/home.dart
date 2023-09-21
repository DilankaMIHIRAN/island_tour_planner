import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:island_tour_planner/models/event_model.dart';
import 'package:island_tour_planner/models/popular_destination_model.dart';
import 'package:island_tour_planner/models/user_model.dart';
import 'package:island_tour_planner/screens/home/widgets/event_carousel.dart';
import 'package:island_tour_planner/screens/home/widgets/popular_destination_slider.dart';
import 'package:island_tour_planner/services/auth_service.dart';
import 'package:island_tour_planner/services/event_service.dart';
import 'package:island_tour_planner/services/popular_destination_service.dart';
import 'package:provider/provider.dart';

import 'widgets/post_slider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  String greetings() {
    final hour = TimeOfDay.now().hour;
    if (hour <= 12) {
      return 'Morning';
    } else if (hour <= 17) {
      return 'Afternoon';
    }
    return 'Evening';
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: size.height * 0.020,
              horizontal: size.width * 0.050,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Good ${greetings()} 👋",
                      style: GoogleFonts.poppins(
                        fontSize: size.width * 0.048,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.003,
                    ),
                    Text(
                      'Explore More with iTrip Planner',
                      style: GoogleFonts.poppins(
                        fontSize: size.width * 0.032,
                        letterSpacing: 0.5,
                        color: Colors.black54,
                      ),
                    )
                  ],
                ),
                StreamBuilder<UserModel>(
                  stream: AuthService().authUser,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      UserModel? authUser = snapshot.data;
                      return CircleAvatar(
                        radius: size.width * 0.055,
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(100)),
                          child: authUser!.avatar!.isNotEmpty
                              ? Image.network(
                                  authUser.avatar.toString(),
                                  fit: BoxFit.cover,
                                  width: size.width,
                                  height: size.height,
                                )
                              : Image.asset(
                                  'assets/images/avatar.jpg',
                                  fit: BoxFit.cover,
                                  width: size.width,
                                ),
                        ),
                      );
                    } else {
                      return CircleAvatar(
                        radius: size.width * 0.055,
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(100)),
                          child: Image.asset(
                            'assets/images/avatar.jpg',
                            fit: BoxFit.cover,
                            width: size.width,
                          ),
                        ),
                      );
                    }
                  },
                )
              ],
            ),
          ),
          Divider(
            color: Colors.black12.withOpacity(0.1),
            thickness: 0.2,
            height: 0.1,
          ),
          SizedBox(
            height: size.height * 0.020,
          ),
          StreamProvider<List<EventModel>>.value(
            initialData: const [],
            value: EventService().events,
            child: const EventCarousel(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: size.height * 0.020,
              horizontal: size.width * 0.050,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Show Post",
                  style: GoogleFonts.poppins(
                    fontSize: size.width * 0.04,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                InkWell(
                  onTap: () {
                  },
                  child: Row(
                    children: [
                      Text(
                        "View All",
                        style: GoogleFonts.poppins(
                          fontSize: size.width * 0.04,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.010,
                      ),
                      const Icon(Iconsax.arrow_right_1)
                    ],
                  ),
                )
              ],
            ),
          ),
          const PostSlider(),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: size.height * 0.020,
              horizontal: size.width * 0.050,
            ),
            child: Text(
              "Popular Destinations",
              style: TextStyle(
                fontSize: size.width * 0.04,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          StreamProvider<List<PopularDestinationModel>>.value(
            value: PopularDestinationService().popularDestinations,
            initialData: const [],
            child: const PopularDestinationSlider(),
          ),
        ],
      ),
    );
  }
}
