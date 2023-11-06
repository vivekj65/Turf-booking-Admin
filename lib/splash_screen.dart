import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:turf_booking_admin/api/api.dart';
import 'package:turf_booking_admin/auth/auth_screen.dart';
import 'package:turf_booking_admin/home_screen.dart';
import 'package:turf_booking_admin/themes/theme_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key? key,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (APIs.auth.currentUser != null) {
        log('User: ${FirebaseAuth.instance.currentUser!.uid}');
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const HomeScreen()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const LoginScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Media query for sizing
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        color: HashColorCodes.green,
        child: const Center(
          child: Image(
            image: AssetImage('images/logom.png'),
            height: 150,
          ),
        ),
      ),
    );
  }
}
