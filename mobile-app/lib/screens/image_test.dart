import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'widgets/custom_button.dart';

class ImageTest extends StatefulWidget {
  const ImageTest({super.key});

  @override
  State<ImageTest> createState() => _ImageTestState();
}

class _ImageTestState extends State<ImageTest> {
  ImagePicker picker = ImagePicker();
  XFile? avatar;

  getImage() {
    if (avatar != null) {
      return FileImage(File.fromUri(Uri.parse(avatar!.path)));
    } else {
      return AssetImage("assets/images/avatar.jpg");
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

  Future onSumbit() async {
    final String fileName = path.basename(avatar!.path);
    File imageFile = File(avatar!.path);
    final storageRef = FirebaseStorage.instance.ref();
    storageRef.child('hotels/${fileName}').putFile(imageFile);
    String url = (await storageRef.child('hotels/${fileName}').getDownloadURL()).toString();
    print(url);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: size.width * 0.80,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.080,
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
              SizedBox(
                height: size.height * 0.030,
              ),
              CustomButton(
                title: 'Update Profile',
                onPressed: onSumbit,
              )
            ],
          ),
        ),
      ),
    );
  }
}
