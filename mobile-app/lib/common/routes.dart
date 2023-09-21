import 'package:flutter/material.dart';
import 'package:island_tour_planner/screens/auth/forgot_password.dart';
import 'package:island_tour_planner/screens/auth/register.dart';
import 'package:island_tour_planner/screens/auth/widgets/login.dart';
import 'package:island_tour_planner/screens/base.dart';
import 'package:island_tour_planner/screens/profile/change_password.dart';
import 'package:island_tour_planner/screens/trip/create_trip.dart';
import 'package:island_tour_planner/screens/welcome.dart';
import '../screens/auth_wrapper.dart';

var routes = <String, WidgetBuilder> {
  '/base':(context) => const Base(),
  '/login':(context) => const Login(),
  '/welcome':(context) => const Welcome(),
  '/register':(context) => const Register(),
  '/create_trip':(context) => const CreateTrip(),
  '/auth_wrapper':(context) => const AuthWrapper(),
  '/forgot_password':(context) => const ForgotPassword(),
  '/change_password':(context) => const ChangePassword(),
};