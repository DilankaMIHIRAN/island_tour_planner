import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:island_tour_planner/models/cab_driver_model.dart';
import 'package:island_tour_planner/models/tour_guide_model.dart';
import 'package:island_tour_planner/models/user_model.dart';
import 'package:island_tour_planner/screens/widgets/custom_button.dart';
import 'package:island_tour_planner/screens/widgets/custom_input.dart';
import 'package:island_tour_planner/services/auth_service.dart';
import 'package:island_tour_planner/services/cab_service.dart';
import 'package:island_tour_planner/services/tour_guide_service.dart';

import '../widgets/custom_loading.dart';

class EditProfile extends StatefulWidget {
  final UserModel user;

  const EditProfile({
    super.key,
    required this.user,
  });

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  ImagePicker picker = ImagePicker();
  XFile? avatar;

  AuthService authService = AuthService();

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

  @override
  void initState() {
    _nameController.text = widget.user.name.toString();
    _emailController.text = widget.user.email.toString();
    _phoneController.text = widget.user.phoneNumber.toString();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
  }

  getImage() {
    if (avatar != null) {
      return FileImage(File.fromUri(Uri.parse(avatar!.path)));
    } else if (widget.user.avatar!.isNotEmpty) {
      return NetworkImage(widget.user.avatar.toString());
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

  Future onHandleForm() async {
    if (_formKey.currentState!.validate()) {
      LoadingIndicatorDialog().show(context);

      List<String> selectedLanguages = [];

      for (int i = 0; i < _isSelectedList.length; i++) {
        if (_isSelectedList[i]) {
          selectedLanguages.add(langs[i]);
        }
      }

      Map<String, dynamic> response = await authService.updateUserAccount(
        _nameController.text.trim(),
        _emailController.text.trim(),
        _phoneController.text.trim(),
        avatar,
        _bioController.text.trim(),
        selectedLanguages,
        widget.user.role,
      );

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
          'Edit Profile',
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
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.height * 0.020,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.030,
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
                  height: size.height * 0.010,
                ),
                Text(
                  'Name',
                  style: GoogleFonts.poppins(
                    fontSize: size.width * 0.040,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.012,
                ),
                CustomInput(
                  hintLabel: 'Name',
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
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
                  height: size.height * 0.012,
                ),
                CustomInput(
                  hintLabel: 'E-mail',
                  textInputType: TextInputType.emailAddress,
                  controller: _emailController,
                  enabled: false,
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
                  'Phone Number',
                  style: GoogleFonts.poppins(
                    fontSize: size.width * 0.040,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.012,
                ),
                CustomInput(
                  hintLabel: 'Phone Number',
                  textInputType: TextInputType.number,
                  controller: _phoneController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Phone Number is required';
                    }
                    if (value.isNotEmpty && value.length != 10) {
                      return 'Phone Number is badly formated';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: size.height * 0.030,
                ),
                widget.user.role == "tour_guide"
                    ? StreamBuilder<TourGuideModel>(
                        stream:
                            TourGuideService(uid: widget.user.uid).tourGuide,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            TourGuideModel? tourGuide = snapshot.data;
                            _bioController.text = tourGuide!.bio;

                            for (int i = 0;
                                i < tourGuide.languages.length;
                                i++) {
                              for (int j = 0; j < langs.length; j++) {
                                if (tourGuide.languages[i] == langs[j]) {
                                  _isSelectedList[j] = true;
                                }
                              }
                            }

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Bio (Brief Introduction)",
                                  style: GoogleFonts.poppins(
                                    fontSize: size.width * 0.040,
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.010,
                                ),
                                CustomInput(
                                  hintLabel:
                                      'Bio (Describe yourself & your service)',
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
                              ],
                            );
                          } else {
                            return Container();
                          }
                        },
                      )
                    : widget.user.role == "cab_driver"
                        ? StreamBuilder<CabDriverModel>(
                            stream: CabService(uid: widget.user.uid).cabDriver,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                CabDriverModel? cabDriver = snapshot.data;
                                _bioController.text = cabDriver!.bio;
                                for (int i = 0;
                                    i < cabDriver.languages.length;
                                    i++) {
                                  for (int j = 0; j < langs.length; j++) {
                                    if (cabDriver.languages[i] == langs[j]) {
                                      _isSelectedList[j] = true;
                                    }
                                  }
                                }

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Bio (Brief Introduction)",
                                      style: GoogleFonts.poppins(
                                        fontSize: size.width * 0.040,
                                      ),
                                    ),
                                    SizedBox(
                                      height: size.height * 0.010,
                                    ),
                                    CustomInput(
                                      hintLabel:
                                          'Bio (Describe yourself & your service)',
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
                                          backgroundColor:
                                              _isSelectedList[index]
                                                  ? Colors.orangeAccent
                                                  : Colors.transparent,
                                          selected: _isSelectedList[index],
                                          shape: const StadiumBorder(
                                            side: BorderSide(),
                                          ),
                                          onSelected: (bool isSelected) {
                                            setState(() {
                                              _isSelectedList[index] =
                                                  isSelected;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: size.height * 0.030,
                                    ),
                                  ],
                                );
                              } else {
                                return Container();
                              }
                            },
                          )
                        : SizedBox(
                            height: size.height * 0.020,
                          ),
                CustomButton(
                  title: 'Update Profile',
                  onPressed: onHandleForm,
                ),
                SizedBox(
                  height: size.height * 0.060,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
