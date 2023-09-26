import 'package:aptm/src/features/main/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TermsPrivacyScreen extends StatefulWidget {
  const TermsPrivacyScreen({super.key});
  static const path = 'termsnprivacy';

  @override
  State<TermsPrivacyScreen> createState() => _TermsPrivacyScreenState();
}

class _TermsPrivacyScreenState extends State<TermsPrivacyScreen> {
  bool? valuefirst = false;
  // bool valuesecond = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 150),
            child: const Center(
              child: Text(
                'Accept Terms & Privacy Notice',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  color: Color(0xff222222),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 25),
            child: const Text(
              'A Terms and Conditions agreement outlines the rules that your website or mobile app users must follow. They usually cover topics such restricted behavior, payment terms, acceptable use, and more that we cover below.',
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.normal,
                color: Color(0xff333333),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'I agree ',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.normal,
                  color: Color(0xff666666),
                ),
              ),
              Checkbox(
                value: valuefirst,
                onChanged: (bool? value) {
                  setState(
                    () {
                      valuefirst = value;
                    },
                  );
                },
              )
            ],
          ),
          const SizedBox(
            height: 130,
          ),
          SizedBox(
            width: size.width,
            height: 40,
            child: TextButton(
              onPressed: () {
                if (valuefirst == true) {
                  return context.go(HomeScreen.path);
                }
              },
              style: TextButton.styleFrom(
                backgroundColor: valuefirst!
                    ? const Color(0xff0000ff)
                    : const Color.fromARGB(255, 81, 81, 81),
                fixedSize: const Size(396, 48),
              ),
              child: const Text(
                'Next',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
