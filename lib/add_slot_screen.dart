import 'package:flutter/material.dart';
import 'package:turf_booking_admin/themes/theme_colors.dart';

class AddSlotScreen extends StatefulWidget {
  const AddSlotScreen({super.key});

  @override
  State<AddSlotScreen> createState() => _AddSlotScreenState();
}

class _AddSlotScreenState extends State<AddSlotScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Slot',
          style: TextStyle(
            fontFamily: 'Sarala',
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: HashColorCodes.green,
      ),
    );
  }
}
