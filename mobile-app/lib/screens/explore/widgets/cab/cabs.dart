import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:island_tour_planner/screens/explore/view_cab.dart';
import 'package:provider/provider.dart';

import '../../../../models/cab_driver_model.dart';
import 'cab_card.dart';

class Cabs extends StatefulWidget {
  final void Function(List<String>)? onSelectedCabDrivers;
  final bool? isEnableLongPress;

  const Cabs({
    super.key,
    this.isEnableLongPress,
    this.onSelectedCabDrivers,
  });

  @override
  State<Cabs> createState() => _CabsState();
}

class _CabsState extends State<Cabs> {
  List<String> selectedCabDrivers = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final cabDrivers = Provider.of<List<CabDriverModel>>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: size.height * 0.010,
            horizontal: size.width * 0.030,
          ),
          child: Text(
            "Cabs",
            style: GoogleFonts.poppins(
              fontSize: size.width * 0.040,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(
          height: size.height * 0.25,
          child: cabDrivers.isNotEmpty
              ? ListView.builder(
                  itemCount: cabDrivers.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => CabCard(
                    cabDriver: cabDrivers[index],
                    selectedCabDriver:
                        selectedCabDrivers.contains(cabDrivers[index].id)
                            ? 2.5
                            : 0,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewCab(
                            cab: cabDrivers[index],
                          ),
                        ),
                      );
                    },
                    onLongPress: () {
                      if (widget.isEnableLongPress == true) {
                        if (selectedCabDrivers.contains(cabDrivers[index].id)) {
                          selectedCabDrivers.remove(cabDrivers[index].id.toString());
                        } else {
                          selectedCabDrivers.add(cabDrivers[index].id.toString());
                        }
                        setState(() {});
                        widget.onSelectedCabDrivers!(selectedCabDrivers);
                      }
                    },
                  ),
                )
              : Center(
                  child: Text(
                    'No Cabs found',
                    style: GoogleFonts.poppins(),
                  ),
                ),
        )
      ],
    );
  }
}
