import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:island_tour_planner/models/hotel_model.dart';
import 'package:island_tour_planner/models/user_model.dart';
import 'package:island_tour_planner/screens/profile/edit_profile.dart';
import 'package:island_tour_planner/screens/profile/event_bookings.dart';
import 'package:island_tour_planner/screens/profile/widgets/menu_item.dart';
import 'package:island_tour_planner/services/accomodation_service.dart';
import 'package:island_tour_planner/services/auth_service.dart';
import 'package:skeletons/skeletons.dart';
import '../widgets/custom_loading.dart';
import 'edit_hotel_profile.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  AuthService authService = AuthService();

  Future<void> onSignOut() async {
    LoadingIndicatorDialog().show(context);

    Map<String, dynamic> response = await authService.logout();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(response['message']),
      ),
    );

    LoadingIndicatorDialog().dismiss();
  }

  String getRole(role) {
    if (role == "traveller") {
      return "Traveller";
    } else if (role == "tour_guide") {
      return "Tour Guide";
    } else if (role == "cab_driver") {
      return "Cab Driver";
    } else if (role == "hotel") {
      return "Hotel";
    }
    return role;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          child: StreamBuilder<UserModel>(
            stream: AuthService().authUser,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                UserModel? userData = snapshot.data;
                return Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.030,
                    ),
                    CircleAvatar(
                      radius: size.width * 0.14,
                      backgroundColor: Colors.orangeAccent,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(100)),
                        child: userData!.avatar!.isNotEmpty
                            ? Image.network(
                                userData.avatar.toString(),
                                fit: BoxFit.cover,
                                width: size.width,
                                height: size.height,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return const Center(
                                    child: SkeletonAvatar(
                                      style: SkeletonAvatarStyle(
                                        width: double.infinity,
                                        height: double.infinity,
                                      ),
                                    ),
                                  );
                                },
                              )
                            : Image.asset(
                                'assets/images/avatar.jpg',
                                fit: BoxFit.cover,
                                width: size.width,
                              ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.010,
                    ),
                    Text(
                      userData.name.toString(),
                      style: GoogleFonts.poppins(
                        fontSize: size.width * 0.050,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                      ),
                    ),
                    Text(
                      getRole(userData.role).toString(),
                      style: GoogleFonts.poppins(
                        fontSize: size.width * 0.035,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                        color: Colors.black38,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.030,
                    ),
                    SizedBox(
                      width: size.width * 0.90,
                      child: Column(
                        children: [
                          Divider(
                            color: Colors.grey[200],
                          ),
                          SizedBox(
                            height: size.height * 0.020,
                          ),
                          MenuItem(
                            label: "Edit My Profile",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditProfile(
                                    user: userData,
                                  ),
                                ),
                              );
                            },
                            icon: Iconsax.edit,
                          ),
                          userData.role == "hotel"
                              ? StreamBuilder<HotelModel>(
                                  stream: AccomodationService(uid: userData.uid)
                                      .hotel,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      HotelModel? hotelData = snapshot.data;
                                      return Column(
                                        children: [
                                          SizedBox(
                                            height: size.height * 0.020,
                                          ),
                                          MenuItem(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditHotelProfile(
                                                    hotel: hotelData,
                                                    uid: userData.uid,
                                                  ),
                                                ),
                                              );
                                            },
                                            label: "Update Hotel Profile",
                                            icon: Iconsax.building,
                                          ),
                                          SizedBox(
                                            height: size.height * 0.020,
                                          ),
                                        ],
                                      );
                                    } else {
                                      return Container();
                                    }
                                  },
                                )
                              : SizedBox(
                                  height: size.height * 0.020,
                                ),
                          MenuItem(
                            label: "Change Password",
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed('/change_password');
                            },
                            icon: Iconsax.lock,
                          ),
                          SizedBox(
                            height: size.height * 0.020,
                          ),
                          MenuItem(
                            label: 'Event Bookings',
                            icon: Iconsax.ticket,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const EventBookings(),
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: size.height * 0.020,
                          ),
                          MenuItem(
                            label: 'Customer support',
                            icon: Iconsax.message,
                            onTap: () {},
                          ),
                          SizedBox(
                            height: size.height * 0.020,
                          ),
                          MenuItem(
                            label: 'Frequently asked questions',
                            icon: Iconsax.message_question,
                            onTap: () {},
                          ),
                          SizedBox(
                            height: size.height * 0.020,
                          ),
                          MenuItem(
                            label: 'Privacy Policy',
                            icon: Iconsax.info_circle,
                            onTap: () {},
                          ),
                          SizedBox(
                            height: size.height * 0.020,
                          ),
                          MenuItem(
                            label: "Logout",
                            onTap: onSignOut,
                            icon: Iconsax.logout,
                          ),
                          SizedBox(
                            height: size.height * 0.040,
                          ),
                        ],
                      ),
                    )
                  ],
                );
              } else {
                return Center(
                  child: SkeletonListView(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
