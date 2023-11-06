import 'package:flutter/material.dart';
import 'package:turf_booking_admin/model/slot_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SlotCard extends StatelessWidget {
  const SlotCard({Key? key, required this.slot}) : super(key: key);
  final Slot slot;

  // Function to format the time in 12-hour format
  String formatTime(int time) {
    if (time == 0) {
      return "12 AM";
    } else if (time < 12) {
      return "$time AM";
    } else if (time == 12) {
      return "12 PM";
    } else {
      return "${time - 12} PM";
    }
  }

  @override
  Widget build(BuildContext context) {
        final date = DateTime.now();
    final formattedDate = "${date.month} ${date.day}, ${date.year}";
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Members')
          .where('selectedSlot', isEqualTo: slot.slotNum)
          .where('date', isEqualTo: formattedDate)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        int playerCount = snapshot.hasData ? snapshot.data!.docs.length : 0;
        String playerCountText =
            playerCount < 25 ? '$playerCount Players' : 'Full';

        return SizedBox(
          height: 80,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    height: 70,
                    width: 100,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: slot.imgUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        slot.name,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Urbanist',
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            formatTime(slot.startTime),
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Urbanist',
                            ),
                          ),
                          const Text(
                            " - ",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Urbanist',
                            ),
                          ),
                          Text(
                            formatTime(slot.endTime),
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Urbanist',
                            ),
                          ),
                          const SizedBox(width: 40),
                          Text(
                            playerCountText,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Urbanist',
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
