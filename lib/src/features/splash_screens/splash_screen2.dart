import 'package:aptm/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen2 extends StatelessWidget {
  const SplashScreen2({super.key});
  static const path = 'splash2';

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
            alignment: const Alignment(0, -0.67),
            child: SizedBox(
              width: size.width * 0.5,
              height: size.height * 0.3,
              child: Center(
                // TODO ask for book logo
                child: Assets.images.books.image(width: 180, height: 180),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, -0.67),
            child: SizedBox(
              width: size.width * 0.5,
              height: size.height * 0.3,
              child: Center(
                child: Assets.images.books.image(width: 180, height: 180),
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
                      "Learn Book",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 25,
                          color: Color(0xff222222),
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Everywhere",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 17,
                          color: Color(0xff666666),
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      "In life there are people that will hurt us and cause us pain.",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 16,
                          color: Color(0xff666666),
                          fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: 40,
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
            //fixedSize: const Size(99, 44)
          ),
          child: const Text(
            "Next",
            style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.normal),
          ),
          onPressed: () {
            return context.go("/splash/splash3");
          },
        ),
      ),
    );
  }
}
