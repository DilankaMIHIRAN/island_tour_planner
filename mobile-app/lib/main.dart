import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:island_tour_planner/common/routes.dart';
import 'package:island_tour_planner/common/theme.dart';
import 'package:island_tour_planner/services/auth_service.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        title: 'I Tour Planner',
        debugShowCheckedModeBanner: false,
        theme: light,
        themeMode: ThemeMode.light,
        initialRoute: '/welcome',
        routes: routes,
      ),
    );
  }
}