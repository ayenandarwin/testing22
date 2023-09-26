import 'package:aptm/gen/assets.gen.dart';
import 'package:aptm/src/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen4 extends StatelessWidget {
  const SplashScreen4({super.key});
  static const path = 'splash4';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                  child: Row(
                children: [
                  Expanded(
                    // TODO ask for bg circle
                    child: Container(color: Colors.white),
                  ),
                  Expanded(
                    // TODO ask for bg circle
                    child: Container(color: Colors.white),
                  ),
                ],
              )),
              Expanded(
                // TODO ask for bg circle
                child: Container(color: Colors.white),
              ),
            ],
          ),
          Align(
            alignment: const Alignment(0, -0.7),
            child: SizedBox(
              width: size.width * 0.5,
              height: size.height * 0.3,
              child: Center(
                child: Assets.images.bookOpen.image(width: 180, height: 180),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, -0.7),
            child: SizedBox(
              width: size.width * 0.5,
              height: size.height * 0.3,
              child: Center(
                // TODO ask for book logo
                child: Assets.images.bookOpen.image(width: 180, height: 180),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: size.height * 0.45),
            child: Align(
              alignment: const Alignment(0, 0.7),
              child: Container(
                width: size.width,
                height: size.height * 0.5,
                padding: EdgeInsets.all(16),
                // color: Colors.black,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Welcome to APTM Library",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 25,
                          color: Color(0xff222222),
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 55,
                    ),
                    Text(
                      "Make reading, listening and watching part of you daily routine.",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 16,
                          color: Color(0xff666666),
                          fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: 46,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 10),
        width: size.width * 0.24,
        height: size.height * 0.05,
        child: TextButton(
          style: TextButton.styleFrom(
              backgroundColor: const Color(0xff0000ff),
              fixedSize: const Size(99, 44)),
          child: const Text(
            "Let's go",
            style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.normal),
          ),
          onPressed: () {
            return context.go(LoginScreen.path);
          },
        ),
      ),
    );
  }
}
