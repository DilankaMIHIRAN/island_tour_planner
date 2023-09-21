import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:island_tour_planner/screens/widgets/custom_input.dart';

class CustomDropDown extends StatelessWidget {
  
  final String? hintLabel;
  final List<Map<String, String>> items;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(Map<String, String>)? onSelectedValue;

  const CustomDropDown({
    super.key,
    this.controller,
    this.onSelectedValue,
    required this.items,
    this.hintLabel,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return CustomInput(
      controller: controller,
      hintLabel: hintLabel,
      enabled: true,
      validator: validator,
      textInputType: TextInputType.none,
      readOnly: true,
      suffixIcon: PopupMenuButton<Map<String, String>>(
        icon: const Icon(Icons.arrow_drop_down),
        onSelected: onSelectedValue,
        itemBuilder: (BuildContext context) => items
            .map<PopupMenuItem<Map<String, String>>>(
              (Map<String, String> value) => PopupMenuItem(
                value: value,
                child: Text(
                  value['name']!,
                  style: GoogleFonts.poppins(),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
