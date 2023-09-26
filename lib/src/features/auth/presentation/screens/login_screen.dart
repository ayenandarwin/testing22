import 'dart:io';

import 'package:aptm/src/features/auth/presentation/screens/signup_screen.dart';
import 'package:aptm/src/features/main/home_screen.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/providers/login_provider.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});
  static const path = '/login';

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      const SnackBar(
        content: Text('Wrong email or password'),
        // action: SnackBarAction(label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginProvider);
    final size = MediaQuery.of(context).size;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    AndroidDeviceInfo? androidInfo;
    Future<BaseDeviceInfo> getInfo() async {
      if (Platform.isAndroid) {
        return await deviceInfo.androidInfo;
      } else if (Platform.isIOS) {
        return await deviceInfo.iosInfo;
      } else {
        throw UnsupportedError("Platform not supported");
      }
    }

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(bottom: 0.000),
          child: SingleChildScrollView(
            child: SizedBox(
              width: size.width,
              child: Container(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 80),
                      width: size.width,
                      height: 60,
                      child: const Center(
                        child: Text(
                          'APTM',
                          style: TextStyle(
                            color: Color(0xff222222),
                            fontSize: 35,
                            fontFamily: 'Orbitron',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 45),
                      width: size.width,
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 25,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: Color(0xff222222),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // Text(
                    //   "Add your phone number.We'll sent you a verification code so we know you're real.",
                    //   style: TextStyle(
                    //       fontFamily: "Poppins",
                    //       fontSize: 14,
                    //       color: Color(0xff222222),
                    //       fontWeight: FontWeight.normal),
                    // ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      'Email',
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          color: Color(0xff333333)),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 40,
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'example@gmail.com',
                          labelStyle: TextStyle(fontSize: 14),
                          prefixIcon: const Icon(Icons.email_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      'Password',
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          color: Color(0xff333333)),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 40,
                      child: TextField(
                        controller: passwordController,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                          labelText: 'Enter your Password',
                          labelStyle: TextStyle(fontSize: 14),
                          prefixIcon: const Icon(Icons.lock_rounded),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Text(
                          'Forget password?',
                          style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.normal,
                              color: Color(0xff666666)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    FutureBuilder<BaseDeviceInfo>(
                        future: getInfo(),
                        builder: (context, snapshot) {
                          String? deviceid;
                          if (Platform.isAndroid) {
                            deviceid = (snapshot.data as AndroidDeviceInfo?)
                                ?.androidId;
                          } else if (Platform.isIOS) {
                            deviceid = (snapshot.data as IosDeviceInfo?)
                                ?.identifierForVendor;
                          }
                          return SizedBox(
                            width: size.width,
                            height: 40,
                            child: TextButton(
                              onPressed: () async {
                                if (loginState.isSuccess) {
                                  // ignore: use_build_context_synchronously
                                  return context.go(HomeScreen.path);
                                }
                                print(loginState.isLoading);
                                // loginState.isLoading
                                //     ? null
                                // () async {
                                final email = emailController.text;
                                final password = passwordController.text;
                                print('email: $email password: $password');
                                await ref.read(loginProvider.notifier).login(
                                    context,
                                    email,
                                    password,
                                    deviceid.toString());
                                if (loginState.isSuccess) {
                                  // ignore: use_build_context_synchronously
                                  return context.go(HomeScreen.path);
                                } else if (loginState.error != null) {
                                  _showToast(context);
                                }
                                // };
                                // return context.go('${LoginScreen.path}/${OtpScreen.path}');
                              },
                              style: TextButton.styleFrom(
                                  backgroundColor: const Color(0xff0000ff),
                                  fixedSize: const Size(396, 48)),
                              child: loginState.isLoading
                                  ? const CircularProgressIndicator()
                                  : const Text(
                                      'Login',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                            ),
                          );
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    const Center(
                      child: Text(
                        'or sign in with ',
                        style: TextStyle(
                            fontSize: 13,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.normal,
                            color: Color(0xff666666)),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FutureBuilder<BaseDeviceInfo>(
                            future: getInfo(),
                            builder: (context, snapshot) {
                              String? deviceid;
                              if (Platform.isAndroid) {
                                deviceid = (snapshot.data as AndroidDeviceInfo?)
                                    ?.androidId;
                              } else if (Platform.isIOS) {
                                deviceid = (snapshot.data as IosDeviceInfo?)
                                    ?.identifierForVendor;
                              }
                              return InkWell(
                                child: Image.asset(
                                  'assets/images/search.png',
                                  scale: 15,
                                ),
                                // Column(
                                //   children: [
                                //     const Icon(Icons.g_mobiledata_rounded),
                                //     Text('Google')
                                //   ],
                                // ),
                                onTap: () {
                                  ref
                                      .read(loginProvider.notifier)
                                      .signInWithGoogle(
                                          context, deviceid.toString());
                                  if (loginState.isSuccess) {
                                    // ignore: use_build_context_synchronously
                                    return context.go(HomeScreen.path);
                                  } else if (loginState.error != null) {
                                    _showToast(context);
                                  }
                                },
                              );
                            }),
                        SizedBox(
                          width: 30,
                        ),
                        FutureBuilder<BaseDeviceInfo>(
                            future: getInfo(),
                            builder: (context, snapshot) {
                             
                              String? deviceid;
                              if (Platform.isAndroid) {
                                deviceid = (snapshot.data as AndroidDeviceInfo?)
                                    ?.androidId;
                              } else if (Platform.isIOS) {
                                deviceid = (snapshot.data as IosDeviceInfo?)
                                    ?.identifierForVendor;
                              }
                              return InkWell(
                                child: Image.asset(
                                  'assets/images/facebook.png',
                                  scale: 15,
                                ),
                                // Column(
                                //   children: [
                                //     const Icon(Icons.facebook_rounded),
                                //     Text('facebook')
                                //   ],
                                // ),
                                onTap: () {
                                  // ref
                                  //     .read(loginProvider.notifier)
                                  //     .signInWithFacebook(context, deviceid!);
                                },
                              );
                            }),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Don\'t have an account? ',
                          style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.normal,
                              color: Color(0xff666666)),
                        ),
                        InkWell(
                          onTap: () {
                            return context
                                .go('${LoginScreen.path}/${SignUpScreen.path}');
                          },
                          child: const Text(
                            'Sign up here',
                            style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                color: Color(0xff333333)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
