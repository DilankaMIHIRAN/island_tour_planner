import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:island_tour_planner/models/cab_driver_model.dart';
import 'package:skeletons/skeletons.dart';

class CabCard extends StatelessWidget {
  final CabDriverModel cabDriver;
  final double selectedCabDriver;
  final void Function()? onTap;
  final void Function()? onLongPress;

  const CabCard({
    super.key,
    required this.cabDriver,
    this.onTap,
    this.onLongPress,
    required this.selectedCabDriver,
  });

  Widget getImage() {
    if (cabDriver.avatar!.isNotEmpty) {
      return Image.network(
        cabDriver.avatar.toString(),
        fit: BoxFit.cover,
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
      );
    } else {
      return Image.asset(
        'assets/images/avatar.jpg',
        fit: BoxFit.cover,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        width: size.width * 0.40,
        height: size.height * 0.60,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(16),
          ),
          border: Border.all(
            width: selectedCabDriver,
            color: Colors.orangeAccent,
          ),
        ),
        margin: EdgeInsets.symmetric(
          horizontal: size.width * 0.010,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: size.width * 0.40,
              height: size.height * 0.40,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: getImage(),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: size.width * 0.40,
                height: size.height * 0.050,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: Text(
                  cabDriver.name,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
