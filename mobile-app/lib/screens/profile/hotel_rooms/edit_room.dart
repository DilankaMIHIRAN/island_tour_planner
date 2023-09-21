import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:island_tour_planner/models/room_model.dart';
import 'package:island_tour_planner/screens/widgets/custom_input.dart';
import 'package:island_tour_planner/services/accomodation_service.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/custom_loading.dart';

class EditHotelRoom extends StatefulWidget {
  final String uid;
  final RoomModel room;

  const EditHotelRoom({
    super.key,
    required this.uid,
    required this.room,
  });

  @override
  State<EditHotelRoom> createState() => _EditHotelRoomState();
}

class _EditHotelRoomState extends State<EditHotelRoom> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _roomTitleController = TextEditingController();
  final TextEditingController _roomDescriptionController =
      TextEditingController();
  final TextEditingController _roomPriceController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _roomTitleController.dispose();
    _roomDescriptionController.dispose();
    _roomPriceController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _roomTitleController.text = widget.room.roomTitle;
    _roomDescriptionController.text = widget.room.roomDescription;
    _roomPriceController.text = widget.room.roomPrice;
  }

  Future onHandleForm() async {
    if (_formKey.currentState!.validate()) {
      LoadingIndicatorDialog().show(context);

      Map<String, dynamic> response =
          await AccomodationService(uid: widget.uid).updateHotelRoom(
        title: _roomTitleController.text,
        description: _roomDescriptionController.text,
        price: _roomPriceController.text, 
        roomId: widget.room.id.toString(),
      );

      if (response['status'] == true) {
        LoadingIndicatorDialog().dismiss();
        Navigator.of(context).pop();
      } else {
        LoadingIndicatorDialog().dismiss();
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response['message']),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Room',
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
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.height * 0.020,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.040,
                ),
                Text(
                  'Room Title',
                  style: GoogleFonts.poppins(
                    fontSize: size.width * 0.040,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.012,
                ),
                CustomInput(
                  hintLabel: 'Room Title',
                  controller: _roomTitleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Room title is required';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: size.height * 0.030,
                ),
                Text(
                  'Room Description',
                  style: GoogleFonts.poppins(
                    fontSize: size.width * 0.040,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.012,
                ),
                CustomInput(
                  hintLabel: 'Room Description',
                  maxLines: 5,
                  controller: _roomDescriptionController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Room description is required';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: size.height * 0.030,
                ),
                Text(
                  'Price',
                  style: GoogleFonts.poppins(
                    fontSize: size.width * 0.040,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.012,
                ),
                CustomInput(
                  hintLabel: 'Room Price',
                  controller: _roomPriceController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Room price is required';
                    }
                    return null;
                  },
                  textInputType: TextInputType.number,
                ),
                SizedBox(
                  height: size.height * 0.030,
                ),
                CustomButton(
                  title: 'Update',
                  onPressed: onHandleForm,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
