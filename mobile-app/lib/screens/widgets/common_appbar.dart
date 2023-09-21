import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class CommonAppBar extends StatelessWidget {
  final String title;

  const CommonAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AppBar(
      title: Text(
        title.toString(),
        style: GoogleFonts.poppins(
          fontSize: size.width * 0.050,
        ),
      ),
      leading: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: const Icon(Iconsax.arrow_left),
      ),
    );
  }
}
