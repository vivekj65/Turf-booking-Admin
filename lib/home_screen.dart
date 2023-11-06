import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:turf_booking_admin/model/slot_model.dart';
// import 'package:turf_booking/profile_screen.dart';
import 'package:turf_booking_admin/slotinfo_screen.dart';
import 'package:turf_booking_admin/widget/timeslot_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Stream<List<Slot>> getSlotsStream() {
    return FirebaseFirestore.instance
        .collection('slots')
        .orderBy('name')
        .snapshots()
        .map(
      (querySnapshot) {
        return querySnapshot.docs.map(
          (doc) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            return Slot(
              slotNum: data['slotNum'],
              name: data['name'] ?? '',
              description: data['description'] ?? '',
              price: data['price'] ?? '',
              available: data['available'] ?? '',
              turfName: data['turfName'] ?? '',
              imgUrl: data['imgUrl'] ?? '',
              startTime: data['startTime'] ?? '',
              endTime: data['endTime'] ?? '',
              slotPlayer: data['slotPlayer'] ?? '',
            );
          },
        ).toList();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.push(
        //         context, MaterialPageRoute(builder: (_) => ProfileScreen()));
        //   },
        //   icon: const Icon(
        //     Icons.settings,
        //     color: Colors.white,
        //   ),
        // ),
        backgroundColor: Colors.green,
        title: const Text(
          "TCK Turf",
          style: TextStyle(
            fontFamily: 'Sarala',
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder<List<Slot>>(
        stream: getSlotsStream(),
        builder: (BuildContext context, AsyncSnapshot<List<Slot>> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text('No time slots available');
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              final slot = snapshot.data![index];
              return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => SlotInfoScreen(
                                  slot: slot,
                                )));
                  },
                  child: SlotCard(slot: slot));
            },
          );
        },
      ),
    );
  }
}
