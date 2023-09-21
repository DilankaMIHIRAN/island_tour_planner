import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:island_tour_planner/screens/widgets/custom_button.dart';
import 'package:island_tour_planner/screens/widgets/custom_input.dart';
import 'package:island_tour_planner/services/auth_service.dart';

import '../widgets/custom_loading.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool isVisible = true;
  bool confimPassIsVisible = true;
  bool currentPassIsVisible = true;

  AuthService authService = AuthService();

  @override
  void dispose() {
    super.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
  }

  Future onHandleForm() async {
    if (_formKey.currentState!.validate()) {
      LoadingIndicatorDialog().show(context);

      Map<String, dynamic> response = await authService.changePassword(
        _currentPasswordController.text.trim(),
        _newPasswordController.text.trim(),
      );

      if(response['status'] == true) {
        _currentPasswordController.clear();
        _newPasswordController.clear();
        _confirmPasswordController.clear();
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response['message']),
        ),
      );

      LoadingIndicatorDialog().dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Change Password',
          style: GoogleFonts.poppins(
            fontSize: size.width * 0.050,
          ),
        ),
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(Iconsax.arrow_left),
        ),
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
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
                  'Current Password',
                  style: GoogleFonts.poppins(
                    fontSize: size.width * 0.040,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.012,
                ),
                CustomInput(
                  hintLabel: 'Current Password',
                  controller: _currentPasswordController,
                  obscureText: currentPassIsVisible,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        currentPassIsVisible = !currentPassIsVisible;
                      });
                    },
                    child: currentPassIsVisible
                        ? const Icon(
                            Iconsax.eye_slash,
                            color: Colors.black54,
                          )
                        : const Icon(
                            Iconsax.eye,
                            color: Colors.black54,
                          ),
                  ),
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return 'Current Password is required';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: size.height * 0.030,
                ),
                Text(
                  'New Password',
                  style: GoogleFonts.poppins(
                    fontSize: size.width * 0.040,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.012,
                ),
                CustomInput(
                  hintLabel: 'New Password',
                  controller: _newPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'New Password is required';
                    }
                    return null;
                  },
                  obscureText: isVisible,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                    child: isVisible
                        ? const Icon(
                            Iconsax.eye_slash,
                            color: Colors.black54,
                          )
                        : const Icon(
                            Iconsax.eye,
                            color: Colors.black54,
                          ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.030,
                ),
                Text(
                  'Confirm Password',
                  style: GoogleFonts.poppins(
                    fontSize: size.width * 0.040,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.012,
                ),
                CustomInput(
                  hintLabel: 'Confirm Password',
                  controller: _confirmPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Confirm Password is required';
                    }
                    if (value.isNotEmpty &&
                        value != _newPasswordController.text) {
                      return 'Confirm Password dosen\'t matched';
                    }
                    return null;
                  },
                  obscureText: confimPassIsVisible,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        confimPassIsVisible = !confimPassIsVisible;
                      });
                    },
                    child: confimPassIsVisible
                        ? const Icon(
                            Iconsax.eye_slash,
                            color: Colors.black54,
                          )
                        : const Icon(
                            Iconsax.eye,
                            color: Colors.black54,
                          ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.030,
                ),
                CustomButton(
                  title: 'Update Password',
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
