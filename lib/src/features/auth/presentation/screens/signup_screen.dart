import 'dart:io';

import 'package:aptm/src/features/auth/data/providers/login_provider.dart';
import 'package:aptm/src/features/auth/data/providers/signup_provider.dart';
import 'package:aptm/src/features/auth/presentation/screens/login_screen.dart';
import 'package:aptm/src/features/auth/presentation/screens/terms_privacy_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:device_info_plus/device_info_plus.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});
  static const path = 'signup';

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final dateInput = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  var _isObscured;

  AndroidDeviceInfo? androidInfo;
  Future<AndroidDeviceInfo> getInfo() async {
    return await deviceInfo.androidInfo;
  }

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
  void initState() {
    _isObscured = true;
    dateInput.text = ""; //set the initial value of text field
    super.initState();
  }

  void showToast(BuildContext context, String error) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(error),
        // action: SnackBarAction(label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginProvider);
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            width: size.width,
            child: Container(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    width: size.width,
                    child: const Text(
                      'Sign up',
                      style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        color: Color(0xff222222),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    width: size.width,
                    child: const Text(
                      'Create new account',
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        color: Color(0xff222222),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Full Name',
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
                      // textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        labelText: 'Enter Full Name',
                        labelStyle: TextStyle(
                          fontSize: 14,
                        ),
                        prefixIcon: const Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      controller: nameController,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
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
                      decoration: InputDecoration(
                        labelText: 'example@gmail.com',
                        labelStyle: TextStyle(fontSize: 14),
                        prefixIcon: const Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      controller: emailController,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Phone',
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
                      controller: phoneController,
                      decoration: InputDecoration(
                        labelText: '09-',
                        labelStyle: TextStyle(fontSize: 14),
                        prefixIcon: const Icon(Icons.phone),
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
                    height: 20,
                  ),
                  const Text(
                    'Date of birth',
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
                      controller: dateInput,
                      decoration: InputDecoration(
                        labelText: 'Select date',
                        labelStyle: TextStyle(fontSize: 14),
                        suffixIcon: const Icon(Icons.calendar_month),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      readOnly: true,
                      //set it true, so that user will not able to edit text
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2100));

                        if (pickedDate != null) {
                          print(
                              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          print(
                              formattedDate); //formatted date output using intl package =>  2021-03-16
                          setState(() {
                            dateInput.text =
                                formattedDate; //set output date to TextField value.
                          });
                        } else {}
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
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
                      obscureText: _isObscured,
                      enableSuggestions: false,
                      autocorrect: false,
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: 'Enter your Password',
                        labelStyle: TextStyle(fontSize: 14),
                        prefixIcon: const Icon(Icons.lock_rounded),
                        suffixIcon: IconButton(
                          icon: _isObscured
                              ? Icon(Icons.visibility_outlined)
                              : Icon(Icons.visibility_off_outlined),
                          onPressed: () {
                            setState(() {
                              _isObscured = !_isObscured;
                            });
                          },
                        ),
                        // const Icon(Icons.visibility_off_outlined),
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
                  const Text(
                    'Must be 8 or more characters and contain at least 1 numbers and 1 special character.',
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.normal,
                        color: Color(0xff666666)),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  FutureBuilder<AndroidDeviceInfo>(
                    future: getInfo(),
                    builder: (context, snapshot) {
                      String? deviceid = snapshot.data?.id!;
                      return SizedBox(
                        width: size.width,
                        height: 40,
                        child: TextButton(
                          onPressed: () async {
                            final signUpState = ref.watch(signupProvider);
                            if (signUpState.isSuccess) {
                              // ignore: use_build_context_synchronously
                              context.go(
                                  '${LoginScreen.path}/${TermsPrivacyScreen.path}');
                              return;
                            }

                            if (signUpState.isLoading) {
                              return;
                            }

                            final name = nameController.text;
                            final phone = phoneController.text;
                            final date = dateInput.text;
                            const role = 'user';

                            final email = emailController.text;
                            final password = passwordController.text;
                            print(deviceid);

                            await ref.read(signupProvider.notifier).signup(
                                  context,
                                  name,
                                  email,
                                  password,
                                  date,
                                  role,
                                  phone,
                                  deviceid!,
                                );

                            final updatedSignUpState =
                                ref.watch(signupProvider);
                            if (updatedSignUpState.isSuccess) {
                              // ignore: use_build_context_synchronously
                              context.go(
                                  '${LoginScreen.path}/${TermsPrivacyScreen.path}');
                            } else if (updatedSignUpState.error != null) {
                              // ignore: use_build_context_synchronously
                              showToast(context, updatedSignUpState.error!);
                            }
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: const Color(0xff0000ff),
                            // fixedSize: const Size(396, 48),
                          ),
                          child: Consumer(
                            builder: (context, watch, child) {
                              final signUpState = ref.watch(signupProvider);
                              return signUpState.isLoading
                                  ? const CircularProgressIndicator()
                                  : const Text(
                                      'Create',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  // const Center(
                  //   child: Text(
                  //     'or sign in with ',
                  //     style: TextStyle(
                  //         fontSize: 13,
                  //         fontFamily: 'Poppins',
                  //         fontWeight: FontWeight.normal,
                  //         color: Color(0xff666666)),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     FutureBuilder<BaseDeviceInfo>(
                  //         future: getInfo(),
                  //         builder: (context, snapshot) {
                  //           String? deviceid;
                  //           if (Platform.isAndroid) {
                  //             deviceid = (snapshot.data as AndroidDeviceInfo?)
                  //                 ?.androidId;
                  //           } else if (Platform.isIOS) {
                  //             deviceid = (snapshot.data as IosDeviceInfo?)
                  //                 ?.identifierForVendor;
                  //           }
                  //           return InkWell(
                  //             child: Image.asset(
                  //               'assets/images/search.png',
                  //               scale: 15,
                  //             ),
                  //             // Column(
                  //             //   children: [
                  //             //     const Icon(Icons.g_mobiledata_rounded),
                  //             //     Text('Google')
                  //             //   ],
                  //             // ),
                  //             onTap: () {
                  //               ref.read(loginProvider.notifier).signInWithGoogle(
                  //                   context, deviceid!.toString());
                  //               if (loginState.isSuccess) {
                  //                 // ignore: use_build_context_synchronously
                  //                 return context.go(HomeScreen.path);
                  //               } else if (loginState.error != null) {
                  //                 _showToast(context);
                  //               }
                  //             },
                  //           );
                  //         }),
                  //     SizedBox(
                  //       width: 30,
                  //     ),
                  //     FutureBuilder<BaseDeviceInfo>(
                  //         future: getInfo(),
                  //         builder: (context, snapshot) {
                  //           String? deviceid;
                  //           if (Platform.isAndroid) {
                  //             deviceid = (snapshot.data as AndroidDeviceInfo?)
                  //                 ?.androidId;
                  //           } else if (Platform.isIOS) {
                  //             deviceid = (snapshot.data as IosDeviceInfo?)
                  //                 ?.identifierForVendor;
                  //           }
                  //           return InkWell(
                  //             child: Image.asset(
                  //               'assets/images/facebook.png',
                  //               scale: 15,
                  //             ),
                  //             // Column(
                  //             //   children: [
                  //             //     const Icon(Icons.facebook_rounded),
                  //             //     Text('facebook')
                  //             //   ],
                  //             // ),
                  //             onTap: () {
                  //               // ref
                  //               //     .read(loginProvider.notifier)
                  //               //     .signInWithFacebook(context, deviceid!);
                  //             },
                  //           );
                  //         }),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
