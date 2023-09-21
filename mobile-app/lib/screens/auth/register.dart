import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:island_tour_planner/screens/auth/onboarding/hotel.dart';
import 'package:island_tour_planner/screens/auth/onboarding/traveller.dart';
import 'package:island_tour_planner/screens/widgets/custom_dropdown.dart';

import 'onboarding/tour_guide.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_input.dart';

class Register extends StatefulWidget {

  const Register({
    super.key,
  });

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String gender = "";
  final _formKey = GlobalKey<FormState>();
  bool isVisible = true;
  bool confimPassIsVisible = true;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _roleNameController = TextEditingController();
  final TextEditingController _roleValueController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Widget buildScreen(Map<String, dynamic> data) {
    if (data['role'] == "tour_guide" || data['role'] == "cab_driver") {
      return TourGuideOnboard(
        data: data,
      );
    } else if (data['role'] == "hotel") {
      return HotelOnboard(
        data: data,
      );
    }
    return Traveller(
      data: data,
    );
  }

  Future<void> handleForm() async {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> data = {
        'name': _nameController.text,
        'email': _emailController.text,
        'role': _roleValueController.text,
        'password': _passwordController.text,
      };

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => buildScreen(data),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: size.width,
            height: size.height * 0.90,
            child: LayoutBuilder(
              builder: (context, constraints) => SizedBox(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
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
                        const Text(
                          "Get started!",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                            letterSpacing: 1,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        const Text(
                          "Please register to continue",
                          style: TextStyle(
                            fontSize: 16,
                            letterSpacing: 1,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(
                          height: size.height * 0.030,
                        ),
                        Text(
                          'Name',
                          style: GoogleFonts.poppins(
                            fontSize: size.width * 0.040,
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.010,
                        ),
                        CustomInput(
                          hintLabel: 'Name',
                          controller: _nameController,
                          textInputType: TextInputType.name,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Name is required';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: size.height * 0.020,
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
                          textInputType: TextInputType.emailAddress,
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
                          height: size.height * 0.020,
                        ),
                        Text(
                          'Account Type',
                          style: GoogleFonts.poppins(
                            fontSize: size.width * 0.040,
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.010,
                        ),
                        CustomDropDown(
                          hintLabel: 'Select Account type',
                          controller: _roleNameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Account type is required";
                            }
                            return null;
                          },
                          onSelectedValue: (value) {
                            _roleNameController.text = value['name']!;
                            _roleValueController.text = value['value']!;
                          },
                          items: const [
                            {
                              'name': 'Traveller',
                              'value': 'traveller',
                            },
                            {
                              'name': 'Tour Guide',
                              'value': 'tour_guide',
                            },
                            {
                              'name': 'Cab Driver',
                              'value': 'cab_driver',
                            },
                            {
                              'name': 'Hotel',
                              'value': 'hotel',
                            }
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.020,
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
                        Text(
                          'Confirm Password',
                          style: GoogleFonts.poppins(
                            fontSize: size.width * 0.040,
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.010,
                        ),
                        CustomInput(
                          hintLabel: 'Confirm Password',
                          controller: _confirmPasswordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Confirm Password is required';
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
                          height: size.height * 0.020,
                        ),
                        CustomButton(
                          title: 'Next',
                          onPressed: handleForm,
                        ),
                        SizedBox(
                          height: size.height * 0.020,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an Account ? ',
                              style: TextStyle(
                                fontSize: size.width * 0.040,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: size.width * 0.040,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.030,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
