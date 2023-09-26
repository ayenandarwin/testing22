import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:aptm/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../auth/data/providers/login_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});
  static const path = '/splash';

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return initScreen(context);
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() async {
    var duration = const Duration(seconds: 2);
    return Timer(duration, route);
  }

  route() {
    context.go("/splash/splash1");
  }

  initScreen(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0000ff),
      body: Container(
        // color: Color(0xfff2ad70),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Center(
            //   child: Text(
            //     'ATPM',
            //     style: const TextStyle(
            //       color: Colors.white,
            //       fontSize: 35,
            //       fontFamily: 'Orbitron',
            //       fontWeight: FontWeight.w600,
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   child: Center(
            //     child: Assets.images.mypages.image(width: 100, height: 100),
            //   ),
            // ),
            Center(
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'APTM',
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontFamily: 'Orbitron',
                      fontWeight: FontWeight.w600,
                    ),
                    speed: const Duration(milliseconds: 150),
                  ),
                ],
                totalRepeatCount: 1,
                pause: const Duration(milliseconds: 150),
                displayFullTextOnTap: true,
                stopPauseOnTap: true,
              ),
            ),
            // const Text(
            //   'MyPages',
            //   style: TextStyle(
            //     color: Colors.white,
            //     fontSize: 40,
            //     fontFamily: 'Orbitron',
            //     fontWeight: FontWeight.w600,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
