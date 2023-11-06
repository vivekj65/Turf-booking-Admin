import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:turf_booking_admin/model/slot_model.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key, required this.slot}) : super(key: key);
  final Slot slot;
  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final CollectionReference membersCollection =
      FirebaseFirestore.instance.collection('Members');

  Future<List<String>> fetchBookings(int selectedSlot) async {
    final date = DateTime.now();
    final formattedDate = "${date.month} ${date.day}, ${date.year}";
    try {
      final QuerySnapshot querySnapshot = await membersCollection
          .where('selectedSlot', isEqualTo: selectedSlot)
          .where('date', isEqualTo: formattedDate)
          .get();

      final List<String> bookings =
          querySnapshot.docs.map((doc) => doc['name'] as String).toList();

      return bookings;
    } catch (e) {
      log("Error fetching bookings: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          "Bookings",
          style: TextStyle(
            fontFamily: 'Sarala',
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder<List<String>>(
        future: fetchBookings(widget.slot.slotNum),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
                child: Text("No bookings found for the selected slot."));
          } else {
            final List<String> bookings = snapshot.data!;
            return ListView.builder(
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(
                    horizontal: mq.width * 0.01,
                    vertical: 4,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: Text(
                        (index + 1).toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          color: Color.fromRGBO(0, 0, 0, 1),
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                      title: Text(
                        bookings[index],
                        style: const TextStyle(
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
