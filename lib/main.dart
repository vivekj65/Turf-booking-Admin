import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:turf_booking_admin/firebase_options.dart';
import 'package:turf_booking_admin/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _intilizeFirebase();
  runApp(const MyApp());
}

// late Size mq;

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

_intilizeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
