import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class BottomNavbar extends StatelessWidget {

  final int currentIndex;
  final void Function(int)? onTap;

  const BottomNavbar({
    super.key,
    required this.currentIndex,
    this.onTap,
  });

  static List<IconData> navIcons = [
     Iconsax.home,
     Iconsax.shop,
     Iconsax.triangle,
     Iconsax.profile_circle,
  ];

  static List<String> navLabels = [
    'Home',
    'Explore',
    'My Trips',
    'Profile'
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      items: List.generate(
        navIcons.length,
        (index) => BottomNavigationBarItem(
          icon: Icon(navIcons[index]),
          label: navLabels[index],
        ),
      ),
    );
  }
}
