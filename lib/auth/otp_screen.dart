import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:turf_booking_admin/common/dialogs.dart';
import 'package:turf_booking_admin/home_screen.dart';
import 'package:turf_booking_admin/main.dart';
import 'package:turf_booking_admin/themes/theme_colors.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen(
      {super.key, required this.verificationID, required this.phoneNumber});
  final String verificationID;
  final String phoneNumber;
  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final otpController = TextEditingController(); 
  // final _formKey = GlobalKey<FormState>();
  String? errorMessage;
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        height: 350,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(15),
              child: const Text(
                "Enter OTP",
                style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Urbanist'),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: TextFormField(
                controller: otpController,
                decoration: const InputDecoration(
                  hintText: "Enter OTP",
                  hintStyle: TextStyle(
                    color: HashColorCodes.grey,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.black12),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: mq.height * .01, horizontal: mq.width * .1),
              child: ElevatedButton(
                onPressed: () async {
                  setState(() {
                    errorMessage = null;
                  });

                  String enteredOTP = otpController.text.trim();
                  final credentials = PhoneAuthProvider.credential(
                    verificationId: widget.verificationID,
                    smsCode: enteredOTP,
                  );

                  try {
                    Dialogs.showLoader(context);

                    await auth.signInWithCredential(credentials).then((value) {
                      if (value.user != null) {
                        // Navigator.pushReplacement(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => const HomeScreen(),
                        //   ),
                        // );
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (_) => HomeScreen()),
                            (route) => false);
                      } else {
                        setState(() {
                          errorMessage = "OTP doesn't match";
                        });
                      }
                    });
                  } catch (e) {
                    log("signInWithCredential: $e");
                    setState(() {
                      errorMessage = 'Invalid OTP';
                    });
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: HashColorCodes.green,
                  elevation: mq.height * 0.01,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Container(
                  alignment: Alignment.center,
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Sarala',
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            if (errorMessage != null)
              Text(
                errorMessage!,
                style: const TextStyle(color: HashColorCodes.red),
              ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
