import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:island_tour_planner/screens/base.dart';
import 'package:provider/provider.dart';

import 'auth/authenticate.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    if(user == null) {
      return const Authenticate();
    } else {
      return const Base();
    }
  }
}
