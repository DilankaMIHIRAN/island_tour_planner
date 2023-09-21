import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:island_tour_planner/common/theme.dart';
import 'package:island_tour_planner/models/cab_driver_model.dart';
import 'package:skeletons/skeletons.dart';

class ViewCab extends StatelessWidget {
  final CabDriverModel cab;

  const ViewCab({
    super.key,
    required this.cab,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cab',
          style: GoogleFonts.poppins(
            fontSize: size.width * 0.050,
          ),
        ),
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(Iconsax.arrow_left),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.020,
            ),
            CircleAvatar(
              radius: size.width * 0.15,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(100)),
                child: cab.avatar!.isNotEmpty
                    ? Image.network(
                        cab.avatar.toString(),
                        fit: BoxFit.cover,
                        width: size.width,
                        height: size.height,
                        loadingBuilder: (context, child, loadingProgress) {
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
                        height: size.height,
                      ),
              ),
            ),
            SizedBox(
              height: size.height * 0.030,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.030,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      cab.name,
                      style: GoogleFonts.poppins(
                        fontSize: size.width * 0.045,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.010,
                  ),
                  Text(
                    cab.bio,
                    style: GoogleFonts.poppins(
                      fontSize: size.width * 0.040,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.030,
                  ),
                  Text(
                    'Languages',
                    style: GoogleFonts.poppins(
                      fontSize: size.width * 0.040,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.020,
                  ),
                  Wrap(
                    runSpacing: 1.0,
                    spacing: 6.0,
                    children: List.generate(
                      cab.languages.length,
                      (index) => FilterChip(
                        label: Text(
                          cab.languages[index].toString(),
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                          ),
                        ),
                        backgroundColor: primaryColor,
                        selected: false,
                        shape: StadiumBorder(
                          side: BorderSide(color: primaryColor),
                        ),
                        onSelected: (bool value) {},
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.020,
                  ),
                  Text(
                    'Contact Info',
                    style: GoogleFonts.poppins(
                      fontSize: size.width * 0.040,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.020,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'E-mail - ',
                        style: GoogleFonts.poppins(),
                      ),
                      GestureDetector(
                        onTap: () async {},
                        child: Text(
                          cab.email,
                          style: GoogleFonts.poppins(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.025,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Phone Number - ',
                        style: GoogleFonts.poppins(),
                      ),
                      GestureDetector(
                        onTap: () async {},
                        child: Text(
                          cab.phoneNumber,
                          style: GoogleFonts.poppins(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
