import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:island_tour_planner/common/theme.dart';
import 'package:island_tour_planner/models/tripe_model.dart';
import 'package:island_tour_planner/services/tripe_service.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_input.dart';
import '../widgets/custom_loading.dart';

class CreateTrip extends StatefulWidget {
  const CreateTrip({super.key});

  @override
  State<CreateTrip> createState() => _CreateTripState();
}

class _CreateTripState extends State<CreateTrip> {
  int days = 1;
  late TripModel trip;
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = const TimeOfDay(hour: 00, minute: 00);

  final TextEditingController _tripNameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _totalDaysController = TextEditingController();
  final TextEditingController _estimateBudgetController =
      TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  final TripService tripService = TripService();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime(2015),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMMMMEEEEd().format(selectedDate);
      });
    }
  }

  @override
  void initState() {
    _dateController.text = DateFormat.yMMMMEEEEd().format(DateTime.now());
    super.initState();
  }

  @override
  void dispose() {
    _tripNameController.dispose();
    _dateController.dispose();
    _totalDaysController.dispose();
    _estimateBudgetController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void handleForm() async {
    if (_formKey.currentState!.validate()) {
      LoadingIndicatorDialog().show(context);

      trip = TripModel(
        tripName: _tripNameController.text,
        date: _dateController.text,
        totalDays: days.toString(),
        budgetLimit: _estimateBudgetController.text,
        note: _noteController.text,
        status: 'planned'
      );

      Map<String, dynamic> results = await tripService.createTripPlan(trip);

      if (results['status'] == true) {
        Navigator.of(context).pop();
      }

      LoadingIndicatorDialog().dismiss();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(results['message']),
        ),
      );
    }
  }

  void clearForm() {
    _tripNameController.clear();
    _estimateBudgetController.clear();
    _noteController.clear();
    _dateController.text = DateFormat.yMMMMEEEEd().format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Trip Plan',
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
            horizontal: size.width * 0.060,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.030,
                ),
                Text(
                  "Trip Name",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: size.width * 0.040,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.010,
                ),
                CustomInput(
                  hintLabel: 'Trip Name',
                  controller: _tripNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Trip Name is required';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: size.height * 0.020,
                ),
                Text(
                  "Date",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: size.width * 0.040,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.010,
                ),
                InkWell(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: CustomInput(
                      hintLabel: 'Date',
                      enabled: false,
                      controller: _dateController,
                      suffixIcon: const Icon(Iconsax.calendar),
                      textAlignVertical: TextAlignVertical.center,
                      style: const TextStyle(
                        color: Colors.black87,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Date is required';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.020,
                ),
                Text(
                  "Total Days",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: size.width * 0.040,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.002,
                ),
                Text(
                  'Total days you spent in this trip',
                  style: GoogleFonts.poppins(
                    color: Colors.black54,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.015,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: primaryColor,
                      child: IconButton(
                        color: Colors.black,
                        onPressed: () {
                          setState(() {
                            days++;
                          });
                        },
                        icon: const Icon(
                          Iconsax.add,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.040,
                    ),
                    SizedBox(
                      width: size.width * 0.060,
                      child: Text(
                        days.toString(),
                        style: GoogleFonts.poppins(
                          fontSize: size.width * 0.050,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.020,
                    ),
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: primaryColor,
                      child: IconButton(
                        color: Colors.black,
                        onPressed: () {
                          if (days != 1) {
                            setState(() {
                              days--;
                            });
                          }
                        },
                        icon: const Icon(
                          Iconsax.minus,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.020,
                ),
                Text(
                  "Estimated Budget Limit",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: size.width * 0.040,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.010,
                ),
                CustomInput(
                  hintLabel: 'Estimated Budget Limit',
                  textInputType: TextInputType.number,
                  controller: _estimateBudgetController,
                  prefixIcon: const Icon(
                    Iconsax.dollar_circle,
                    color: Colors.black54,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Estimated Budget Limit is required';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: size.height * 0.010,
                ),
                Text(
                  "Note",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: size.width * 0.040,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.010,
                ),
                CustomInput(
                  hintLabel: 'Note',
                  maxLines: 5,
                  controller: _noteController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Note is requred';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: size.height * 0.030,
                ),
                CustomButton(
                  title: 'Save',
                  onPressed: handleForm,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
