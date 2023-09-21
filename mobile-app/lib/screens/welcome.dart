import 'dart:async';
import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), onNavigate);
  }

  void onNavigate() {
    Navigator.of(context).pushNamedAndRemoveUntil(
      '/auth_wrapper',
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}
