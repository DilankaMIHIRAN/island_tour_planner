import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:island_tour_planner/screens/widgets/custom_input.dart';
import 'package:island_tour_planner/services/auth_service.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/custom_loading.dart';

class Login extends StatefulWidget {
  final void Function()? onTap;

  const Login({
    super.key,
    this.onTap,
  });

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  bool isVisible = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    setState(() {});
    LoadingIndicatorDialog().dismiss();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> handleForm() async {
    if (_formKey.currentState!.validate()) {
      LoadingIndicatorDialog().show(context);

      Map<String, dynamic> response = await _authService.loginUser(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response['message']),
        ),
      );

      LoadingIndicatorDialog().dismiss();
    }
  }

  Future<void> handleGoogleLogin() async {
    Map<String, dynamic> response = await _authService.signInWithGoogle();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(response['message']),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hello there!",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: size.width * 0.070,
                    letterSpacing: 1,
                  ),
                  textAlign: TextAlign.start,
                ),
                Text(
                  "Please login to continue",
                  style: GoogleFonts.poppins(
                    fontSize: size.width * 0.040,
                    letterSpacing: 1,
                  ),
                  textAlign: TextAlign.start,
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
                Text(
                  'Password',
                  style: GoogleFonts.poppins(
                    fontSize: size.width * 0.040,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.010,
                ),
                CustomInput(
                  hintLabel: 'Password',
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
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
                  height: size.height * 0.020,
                ),
                Row(
                  children: [
                    Text(
                      "Forogot Password ? ",
                      style: GoogleFonts.poppins(
                        fontSize: size.width * 0.040,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed('/forgot_password');
                      },
                      child: Text(
                        "Reset",
                        style: GoogleFonts.poppins(
                          fontSize: size.width * 0.040,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.020,
                ),
                CustomButton(
                  title: 'Login',
                  onPressed: handleForm,
                ),
                SizedBox(
                  height: size.height * 0.020,
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(
                    vertical: size.height * 0.020,
                  ),
                  child: Text(
                    "OR",
                    style: GoogleFonts.poppins(
                      fontSize: size.width * 0.040,
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.055,
                  width: size.width,
                  child: ElevatedButton(
                    onPressed: handleGoogleLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(
                          width: 1,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/images/google.svg',
                          fit: BoxFit.cover,
                          width: size.width * 0.050,
                        ),
                        SizedBox(
                          width: size.width * 0.020,
                        ),
                        Text(
                          'Sign In with Google',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.030,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an Account ? ',
                      style: TextStyle(
                        fontSize: size.width * 0.040,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pushNamed('/register'),
                      child: Text(
                        'Register',
                        style: TextStyle(
                          fontSize: size.width * 0.040,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
