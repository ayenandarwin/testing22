import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:go_router/go_router.dart';

import 'login_screen.dart';
import 'terms_privacy_screen.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});
  static const path = 'otp';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
        ),
        body: Container(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 40),
                child: const Text(
                  'Verify phone number',
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    color: Color(0xff222222),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 16),
                child: const Text(
                  'Enter 4 digit verification code sent to your number.',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.normal,
                    color: Color(0xff333333),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 4),
                child: const Text(
                  '04:00',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    color: Color(0xff333333),
                  ),
                ),
              ),
              const SizedBox(
                height: 48,
              ),
              OtpTextField(
                numberOfFields: 6,
                fieldWidth: size.width / 8,
                borderColor: const Color(0xFFccccff),
                textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins'),
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                //set to true to show as box or false to show as dash
                showFieldAsBox: true,
                //runs when a code is typed in
                onCodeChanged: (String code) {
                  //handle validation or checks here
                },
                //runs when every textfield is filled
                onSubmit: (String verificationCode) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Verification Code"),
                          content: Text('Code entered is $verificationCode'),
                        );
                      });
                  return context
                      .go('${LoginScreen.path}/${TermsPrivacyScreen.path}');
                }, // end onSubmit
              ),
              const SizedBox(
                height: 80,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Didn\'t you receive any code? ',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.normal,
                      color: Color(0xff666666),
                    ),
                  ),
                  Text(
                    'Resend Code',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      color: Color(0xff333333),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 124,
              ),
              TextButton(
                onPressed: () {
                  return context
                      .go('${LoginScreen.path}/${TermsPrivacyScreen.path}');
                },
                style: TextButton.styleFrom(
                    backgroundColor: const Color(0xff0000ff),
                    fixedSize: const Size(396, 48)),
                child: const Text(
                  'Confirm',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
            ],
          ),
        ));
  }
}
