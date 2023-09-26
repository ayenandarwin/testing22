import 'package:aptm/src/features/audio_books/presentation/screens/audiobook_screen_widget.dart';
import 'package:aptm/src/features/auth/data/providers/login_provider.dart';
import 'package:aptm/src/features/auth/presentation/screens/login_screen.dart';
import 'package:aptm/src/features/books/data/providers/books_provider.dart';
import 'package:aptm/src/features/books/presentation/book_screen_widget.dart';
import 'package:aptm/src/features/main/main_screen_widgets.dart';
import 'package:aptm/src/features/main/notifications_screen.dart';
import 'package:aptm/src/features/main/search_screen.dart';
import 'package:aptm/src/features/profile/profile_screen.dart';
import 'package:aptm/src/features/videos/video_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:restart_app/restart_app.dart';

import '../profile/data/providers/profile_detail_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});
  static const path = '/';

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class MenuItem {
  const MenuItem(this.iconData, this.text);
  final IconData iconData;
  final String text;
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int index = 0;

  void updateId(int newId) {
    setState(() {
      index = newId;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userData = ref.refresh(profilDetailsProvider);
    final List<Widget> buildBody = <Widget>[
      MainScreenWidget(onIndexChanged: (int newIndex) {
        updateId(newIndex);
        // print("New Index ********************************** ${newIndex}");
      }),
      const BookScreenWidget(),
      const AudioBookScreenWidget(),
      const VideoScreenWidget()
    ];
    const menuItemlist = <MenuItem>[
      MenuItem(Icons.home, 'Home'),
      MenuItem(Icons.book, 'Book'),
      MenuItem(Icons.audiotrack, 'Audio'),
      MenuItem(Icons.smart_display, 'Video'),
    ];
    final size = MediaQuery.of(context).size;
    final profileImage = storage.read(key: 'profileImage').toString();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff0000ff),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded),
            tooltip: 'Search',
            onPressed: () {
              return context.go(HomeScreen.path + SearchScreen.path);
            },
          ), //IconButton
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            tooltip: 'Notifications',
            onPressed: () {
              return context.go(HomeScreen.path + NotificationScreen.path);
            },
          ),
          InkWell(
              onTap: () {
                return context.go(HomeScreen.path + ProfileScreen.path);
              },
              child: FutureBuilder<ProfileData>(
                  future: profilepicturelink(ref),
                  builder: (BuildContext context,
                      AsyncSnapshot<ProfileData> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator(); // Show a loading indicator while fetching the name
                    } else if (snapshot.hasError) {
                      return const Text(
                          'Error fetching username'); // Handle error state
                    } else {
                      final username = snapshot.data!.username;
                      final profileImage = snapshot.data?.profileImage;

                      return Container(
                        width: 40,
                        height: 40,
                        margin: const EdgeInsets.only(right: 16),
                        child: (profileImage != null)
                            ? CircleAvatar(
                                backgroundImage: AssetImage(profileImage),
                              )
                            : ProfilePicture(
                                name: username, radius: 31, fontsize: 21),
                      );
                    }
                  }))
        ],
        leading: Container(
          margin: EdgeInsets.only(right: 70),
          child: const Center(
            child: Text(
              'APTM',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontFamily: 'Orbitron',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        leadingWidth: MediaQuery.of(context).size.width / 2,
      ),
      body: buildBody[index],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xfff5f5ff),
        currentIndex: index,
        onTap: (value) async {
          setState(() {
            index = value;
          });
        },
        showUnselectedLabels: true,
        unselectedItemColor: const Color(0xff333333),
        unselectedLabelStyle: const TextStyle(
            color: Color(0xff333333),
            fontFamily: 'Poppins',
            fontSize: 10,
            fontWeight: FontWeight.w500),
        selectedLabelStyle: const TextStyle(
            color: Color(0xff0000ff),
            fontFamily: 'Poppins',
            fontSize: 10,
            fontWeight: FontWeight.w500),
        selectedItemColor: const Color(0xff0000ff),
        items: menuItemlist
            .map(
              (MenuItem menuItem) => BottomNavigationBarItem(
                  icon: Icon(menuItem.iconData), label: menuItem.text),
            )
            .toList(),
      ),
    );
  }

  Future<ProfileData> profilepicturelink(WidgetRef ref) async {
    final profileImage = await storage.read(key: 'profileImage');
    final username = await storage.read(key: 'username');
    print('$profileImage eijfiehefh');
    return ProfileData(profileImage, username ?? '');
    // You can use the `username` value in further operations or assignments if needed
  }
}

class ProfileData {
  final String? profileImage;
  final String username;

  ProfileData(this.profileImage, this.username);
}
