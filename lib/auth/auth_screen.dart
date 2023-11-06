import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:turf_booking_admin/api/api.dart';
import 'package:turf_booking_admin/auth/otp_screen.dart';
import 'package:turf_booking_admin/common/dialogs.dart';
import 'package:turf_booking_admin/main.dart';
import 'package:turf_booking_admin/themes/theme_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final textController = TextEditingController();

  Future<void> _signInWithMobileNumber() async {
    try {
      Dialogs.showLoader(context);

      final phoneNumber = '+91${textController.text}';

      APIs.auth.setSettings(appVerificationDisabledForTesting: false);

      await APIs.auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (_) {},
        verificationFailed: ((error) {
          log("Verification Failed : $error");
        }),
        codeSent: (
          String verificationID,
          int? token,
        ) {
          Navigator.pop(context);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OTPScreen(
                phoneNumber: phoneNumber,
                verificationID: verificationID,
              ),
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationId = verificationId;
          log('AutoRetrieval Section');
          log(verificationId);
          log('TimeOut');
        },
        timeout: const Duration(seconds: 60),
      );
    } catch (e) {
      log("$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: HashColorCodes.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(15),
            child: const Text(
              "Login",
              style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Urbanist'),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFormField(
                    controller: textController,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    // onChanged: onPhoneNumberChanged,
                    validator: (value) {
                      if (value == null || value.length != 10) {
                        return 'Enter a valid 10-digit phone number';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: "phone no",
                      hintStyle: TextStyle(
                          color: HashColorCodes.fontGrey,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.bold),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: HashColorCodes.borderGrey,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.black12),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: HashColorCodes.red,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: HashColorCodes.red),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.symmetric(
                      vertical: mq.height * .01, horizontal: mq.width * .1),
                  child: ElevatedButton(
                    onPressed: () {
                      _checkFormKeyStatus();
                      // Dialogs.showLoader(context).then((val){})
                      // Navigator.push(context,
                      _signInWithMobileNumber();
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
                        'Send OTP',
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  _checkFormKeyStatus() {
    if (_formKey.currentState?.validate() == true) {
      final phoneNumber = '${textController.text}';
      log(phoneNumber);
    } else {
      log('Form is invalid');
    }
  }

  void onPhoneNumberChanged(String value) {
    log('Phone number changed: $value');
  }
}
