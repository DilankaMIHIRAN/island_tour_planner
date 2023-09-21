import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:island_tour_planner/screens/auth_wrapper.dart';

import '../../../services/auth_service.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_input.dart';
import '../../widgets/custom_loading.dart';

class Traveller extends StatefulWidget {
  final Map<String, dynamic> data;

  const Traveller({
    super.key,
    required this.data,
  });

  @override
  State<Traveller> createState() => _TravellerState();
}

class _TravellerState extends State<Traveller> {
  ImagePicker picker = ImagePicker();
  XFile? avatar;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneNumberController = TextEditingController();
  final AuthService _authService = AuthService();

  @override
  void dispose() {
    super.dispose();
    _phoneNumberController.dispose();
  }

  getImage() {
    if (avatar != null) {
      return FileImage(File.fromUri(Uri.parse(avatar!.path)));
    } else {
      return const AssetImage("assets/images/avatar.jpg");
    }
  }

  Future pickImage() async {
    final XFile? file = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (file != null) {
      setState(() {
        avatar = file;
      });
    }
  }

  Future removeImage() async {
    setState(() {
      avatar = null;
    });
  }

  Future onCompleteProfile() async {
    if (_formKey.currentState!.validate()) {
      LoadingIndicatorDialog().show(context);

      Map<String, dynamic> data = {
        'email': widget.data['email'],
        'password': widget.data['password'],
        'name': widget.data['name'],
        'role': widget.data['role'],
        'phoneNumber': _phoneNumberController.text,
        'avatar': avatar
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
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(1000),
                    ),
                    child: Image(
                      image: getImage(),
                      height: size.height * 0.16,
                      width: size.height * 0.16,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) {
                        return Container(
                          height: size.height * 0.16,
                          width: size.height * 0.16,
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.02,
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            "Could load the Image",
                            textAlign: TextAlign.center,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.010,
              ),
              (avatar != null)
                  ? Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red[600],
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            side: BorderSide.none,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: removeImage,
                        child: Text(
                          'Remove',
                          style: GoogleFonts.poppins(),
                        ),
                      ),
                    )
                  : Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orangeAccent[150],
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            side: BorderSide.none,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: pickImage,
                        child: Text(
                          'Pick',
                          style: GoogleFonts.poppins(),
                        ),
                      ),
                    ),
              SizedBox(
                height: size.height * 0.030,
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
                height: size.height * 0.020,
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
