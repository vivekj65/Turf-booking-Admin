import 'package:flutter/material.dart';
import 'package:turf_booking_admin/booking_screen.dart';
// import 'package:turf_booking_admin/memberntry_screen.dart';
import 'package:turf_booking_admin/model/slot_model.dart';
import 'package:turf_booking_admin/themes/theme_colors.dart';
import 'package:carousel_slider/carousel_slider.dart';

class SlotInfoScreen extends StatefulWidget {
  const SlotInfoScreen({super.key, required this.slot});
  final Slot slot;
  @override
  State<SlotInfoScreen> createState() => _SlotInfoScreenState();
}

class _SlotInfoScreenState extends State<SlotInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HashColorCodes.green,
        title: const Text(
          "Slot Info",
          style: TextStyle(
            fontFamily: 'Sarala',
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CarouselSlider(
            items: [
              'images/image1.jpg',
              'images/image2.jpg',
              'images/image3 copy.jpg',
              // 'images/image4.jpg',
            ].map((imagePath) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              );
            }).toList(),
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 16 / 9,
              enlargeCenterPage: true,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.slot.turfName,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Urbanist',
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Price : Rs ${widget.slot.price.toString()}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Details",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.slot.description,
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BookingScreen(
                          slot: widget.slot,
                        )),
              );
            },
            child: Container(
                color: HashColorCodes.green,
                height: 50,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "See Bookings",
                          style: TextStyle(
                            color: HashColorCodes.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Urbanist',
                          ),
                        ),
                      ]),
                )),
          ),
        ],
      ),
    );
  }
}
