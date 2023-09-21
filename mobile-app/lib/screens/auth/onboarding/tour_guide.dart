import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:island_tour_planner/screens/widgets/custom_button.dart';
import 'package:island_tour_planner/screens/widgets/custom_input.dart';
import 'package:island_tour_planner/services/auth_service.dart';

import '../../auth_wrapper.dart';
import '../../widgets/custom_loading.dart';

class TourGuideOnboard extends StatefulWidget {
  final Map<String, dynamic> data;

  const TourGuideOnboard({
    super.key,
    required this.data,
  });

  @override
  State<TourGuideOnboard> createState() => _TourGuideOnboardState();
}

class _TourGuideOnboardState extends State<TourGuideOnboard> {
  List<String> langs = [
    'English',
    'Tamil',
    'Sinhala',
    'Hindi',
    'Spanish',
    'German',
    'French',
    'Italian',
    'Korean',
  ];

  final List<bool> _isSelectedList = List.generate(9, (index) => false);

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  final AuthService _authService = AuthService();

  @override
  void dispose() {
    super.dispose();
    _phoneNumberController.dispose();
    _bioController.dispose();
  }

  Future onCompleteProfile() async {
    if (_formKey.currentState!.validate()) {
      LoadingIndicatorDialog().show(context);

      List<String> selectedLanguages = [];

      for (int i = 0; i < _isSelectedList.length; i++) {
        if (_isSelectedList[i]) {
          selectedLanguages.add(langs[i]);
        }
      }

      Map<String, dynamic> data = {
        'email': widget.data['email'],
        'password': widget.data['password'],
        'name': widget.data['name'],
        'role': widget.data['role'],
        'phoneNumber': _phoneNumberController.text,
        'bio': _bioController.text,
        'languages': selectedLanguages
      };

      Map<String, dynamic> response = await _authService.createUser(data);
      if (response['status'] = true) {
        LoadingIndicatorDialog().dismiss();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response['message']),
          ),
        );
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const AuthWrapper(),
          ),
          (route) => false,
        );
      } else {
        LoadingIndicatorDialog().dismiss();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response['message']),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Complete your profile',
          style: GoogleFonts.poppins(
            fontSize: size.width * 0.050,
          ),
        ),
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(Iconsax.arrow_left),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.050,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.040,
              ),
              Text(
                "Phone Number",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: size.width * 0.040,
                ),
              ),
              SizedBox(
                height: size.height * 0.010,
              ),
              CustomInput(
                hintLabel: 'Phone Number',
                controller: _phoneNumberController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Phone Number is required';
                  }
                  if (value.isNotEmpty && value.length != 10) {
                    return 'Please enter valid phone number';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: size.height * 0.030,
              ),
              Text(
                "Bio (Brief Introduction)",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: size.width * 0.040,
                ),
              ),
              SizedBox(
                height: size.height * 0.010,
              ),
              CustomInput(
                hintLabel: 'Bio (Describe yourself & your service)',
                maxLines: 5,
                controller: _bioController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bio is required';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: size.height * 0.030,
              ),
              Text(
                "Languages",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: size.width * 0.040,
                ),
              ),
              SizedBox(
                height: size.height * 0.010,
              ),
              Wrap(
                runSpacing: 1.0,
                spacing: 10.0,
                children: List.generate(
                  langs.length,
                  (index) => FilterChip(
                    label: Text(
                      langs[index].toString(),
                      style: GoogleFonts.poppins(),
                    ),
                    backgroundColor: _isSelectedList[index]
                        ? Colors.orangeAccent
                        : Colors.transparent,
                    selected: _isSelectedList[index],
                    shape: const StadiumBorder(
                      side: BorderSide(),
                    ),
                    onSelected: (bool isSelected) {
                      setState(() {
                        _isSelectedList[index] = isSelected;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.030,
              ),
              CustomButton(
                title: "Complete",
                onPressed: onCompleteProfile,
              ),
              SizedBox(
                height: size.height * 0.050,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
