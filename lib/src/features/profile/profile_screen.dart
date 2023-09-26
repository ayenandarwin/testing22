import 'package:aptm/src/features/auth/data/providers/login_provider.dart';
import 'package:aptm/src/features/main/home_screen.dart';
import 'package:aptm/src/features/profile/screens/fav_screen.dart';
import 'package:aptm/src/router/router.dart';
import 'package:aptm/src/router/router_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:restart_app/restart_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../auth/presentation/screens/login_screen.dart';
import 'data/providers/profile_detail_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});
  static const path = 'profile';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final userData = ref.watch(profilDetailsProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff0000ff),
        // leading: Container(
        //   margin: const EdgeInsets.only(left: 16),
        //   child: const Center(
        //     child: Text(
        //       'APTM',
        //       style: TextStyle(
        //         color: Colors.white,
        //         fontSize: 20,
        //         fontFamily: 'Orbitron',
        //         fontWeight: FontWeight.w600,
        //       ),
        //     ),
        //   ),
        // ),
        // leadingWidth: 100,
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Profile',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              // color: Color(0xff222222),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: 40, left: 16, right: 16),
            child: Column(
              children: [
                userData.when(
                  data: ((data) => Row(
                        children: [
                          Container(
                            width: size.width * 0.13,
                            height: size.width * 0.13,
                            margin:
                                const EdgeInsets.only(right: 16, bottom: 20),
                            child: (data.data.profileImage.toString() != 'null')
                                ? CircleAvatar(
                                    backgroundImage:
                                        AssetImage(data.data.profileImage!),
                                  )
                                : ProfilePicture(
                                    name: data.data.name,
                                    radius: 31,
                                    fontsize: 21),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Text(
                                data.data.name,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff222222),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                data.data.email,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 10,
                                  color: Color(0xff666666),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                data.data.premium
                                    ? 'Premium User'
                                    : 'Free User',
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  color: Color(0xffcd7427),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  error: (error, stackTrace) => Text('Error: $error'),
                ),
                const SizedBox(
                  height: 32,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xff3333ff),
                      ),
                    ),
                    onPressed: () {
                      context.go('/profile/upgrade-screen');
                      // return context.go(HomeScreen.path +
                      //     BookDetailScreen.path +
                      //     '/' +
                      //     BookReader.path);
                    },
                    child: const Text(
                      'Upgrade your plan',
                      style: TextStyle(
                          color: Color(0xffffffff),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins'),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                InkWell(
                  onTap: () {
                    print('object');
                    context.go('/profile/favscreen');
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.favorite_rounded,
                          color: Colors.red,
                          size: 20,
                        ),
                        SizedBox(
                          width: 29,
                        ),
                        Text(
                          'Favourites',
                          style: TextStyle(
                              color: Color(0xff222222),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Poppins'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.bookmark_outline,
                        size: 20,
                      ),
                      SizedBox(
                        width: 29,
                      ),
                      Text(
                        'Saved',
                        style: TextStyle(
                            color: Color(0xff222222),
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Poppins'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                InkWell(
                  onTap: () {
                    context.go('/profile/download');
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: const [
                        Icon(Icons.download, size: 20),
                        SizedBox(
                          width: 29,
                        ),
                        Text(
                          'Download',
                          style: TextStyle(
                              color: Color(0xff222222),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Poppins'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: const [
                      Icon(Icons.settings_outlined, size: 20),
                      SizedBox(
                        width: 29,
                      ),
                      Text(
                        'Settings',
                        style: TextStyle(
                            color: Color(0xff222222),
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Poppins'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: const [
                      Icon(Icons.help_outline, size: 20),
                      SizedBox(
                        width: 29,
                      ),
                      Text(
                        'Help & feedback',
                        style: TextStyle(
                            color: Color(0xff222222),
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Poppins'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: const [
                      Icon(Icons.privacy_tip_outlined, size: 20),
                      SizedBox(
                        width: 29,
                      ),
                      Text(
                        'Privacy & policy',
                        style: TextStyle(
                            color: Color(0xff222222),
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Poppins'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                InkWell(
                  onTap: () => _dialogBuilder(context, ref),
                  // () async {
                  //   await ref.read(loginProvider.notifier).logout();
                  //   return context.go(LoginScreen.path);
                  // },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: const [
                        Icon(Icons.logout, size: 20),
                        SizedBox(
                          width: 29,
                        ),
                        Text(
                          'Logout',
                          style: TextStyle(
                              color: Color(0xff222222),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Poppins'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> _dialogBuilder(BuildContext context, WidgetRef ref) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'Logout',
          style: TextStyle(color: Colors.red),
        ),
        content: const Text('Are you sure to logout?'),
        actions: <Widget>[
          TextButton(
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () async {
              await ref.refresh(loginProvider.notifier).logout();
              context.go(LoginScreen.path);
            },
          ),
        ],
      );
    },
  );
}
