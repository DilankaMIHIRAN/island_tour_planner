import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../../services/auth_service.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_input.dart';
import '../widgets/custom_loading.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final AuthService _authService = AuthService();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> handleForm() async {
    if (_formKey.currentState!.validate()) {
      LoadingIndicatorDialog().show(context);

      Map<String, dynamic> response =
          await _authService.forgotPassword(_emailController.text.trim());

      if (response['status'] == true) {
        _emailController.clear();
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
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(Iconsax.arrow_left),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Enter Your Email and We wil send you \na password rest link!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: size.width * 0.045,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.030,
                ),
                Text(
                  'E-mail',
                  style: GoogleFonts.poppins(
                    fontSize: size.width * 0.040,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.010,
                ),
                CustomInput(
                  hintLabel: 'E-mail',
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'E-mail is required';
                    }
                    if (value.isNotEmpty && !value.contains('@')) {
                      return 'E-mail is badly formated';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: size.height * 0.030,
                ),
                CustomButton(
                  title: 'Reset Password',
                  onPressed: handleForm,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
