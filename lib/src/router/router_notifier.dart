import 'package:aptm/src/features/addons/presentation/addons_detail_screen.dart';
import 'package:aptm/src/features/addons/presentation/addons_screen.dart';
import 'package:aptm/src/features/audio_books/presentation/screens/audio_detail_screen.dart';
import 'package:aptm/src/features/audio_books/presentation/screens/audio_player.dart';
import 'package:aptm/src/features/audio_books/presentation/screens/summary_screen.dart';
import 'package:aptm/src/features/auth/data/models/third_party_user.dart';
import 'package:aptm/src/features/auth/data/models/user.dart' as user_model;
import 'package:aptm/src/features/auth/data/providers/login_provider.dart';
import 'package:aptm/src/features/auth/data/services/auth_service.dart';
import 'package:aptm/src/features/auth/presentation/screens/login_screen.dart';
import 'package:aptm/src/features/auth/presentation/screens/otp_screen.dart';
import 'package:aptm/src/features/auth/presentation/screens/signup_screen.dart';
import 'package:aptm/src/features/auth/presentation/screens/terms_privacy_screen.dart';
import 'package:aptm/src/features/books/data/providers/books_provider.dart';
import 'package:aptm/src/features/books/data/providers/books_provider.dart';
import 'package:aptm/src/features/books/presentation/book_detail_screen.dart';
import 'package:aptm/src/features/books/presentation/book_gallery.dart';
import 'package:aptm/src/features/books/presentation/book_reader.dart';
import 'package:aptm/src/features/books/presentation/new_added.dart';
import 'package:aptm/src/features/books/presentation/popular_books.dart';
import 'package:aptm/src/features/main/home_screen.dart';
import 'package:aptm/src/features/main/notifications_screen.dart';
import 'package:aptm/src/features/main/search_screen.dart';
import 'package:aptm/src/features/profile/profile_screen.dart';
import 'package:aptm/src/features/profile/screens/download_audio_detail.dart';
import 'package:aptm/src/features/profile/screens/download_audio_player.dart';
import 'package:aptm/src/features/profile/screens/download_screen.dart';
import 'package:aptm/src/features/profile/screens/fav_screen.dart';
import 'package:aptm/src/features/profile/screens/upgrade_screen.dart';
import 'package:aptm/src/features/splash_screens/splash_screen1.dart';
import 'package:aptm/src/features/splash_screens/splash_screen2.dart';
import 'package:aptm/src/features/splash_screens/splash_screen3.dart';
import 'package:aptm/src/features/splash_screens/splash_screen4.dart';
import 'package:aptm/src/features/videos/video_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

import '../features/splash_screens/splash_screen.dart';
import '../features/videos/presentation/youtube_player.dart';

// import '../entities/user_role.dart';
// import '../main.dart';
// import '../state/auth.dart';
// import '../state/permissions.dart';

/// This notifier is meant to implement the [Listenable] our [GoRouter] needs.
///
/// We aim to trigger redirects whenever's needed.
/// This is done by calling our (only) listener everytime we want to notify stuff.
/// This allows to centralize global redirecting logic in this class.
/// In this simple case, we just listen to auth changes.
///
/// SIDE NOTE.
/// This might look overcomplicated at a first glance;
/// Instead, this method aims to follow some good some good practices:
///   1. It doesn't require us to pipe down any `ref` parameter
///   2. It works as a complete replacement for [ChangeNotifier] (it's a [Listenable] implementation)
///   3. It allows for listening to multiple providers if needed (we do have a [Ref] now!)
class RouterNotifier extends AutoDisposeAsyncNotifier<void>
    implements Listenable {
  VoidCallback? routerListener;
  bool isAuth = true; // Useful for our global redirect function

  @override
  Future<void> build() async {
    // One could watch more providers and write logic accordingly

    // isAuth = await ref.watch(
    //   authNotifierProvider.selectAsync((data) => data != null),
    // );

    ref.listenSelf((_, __) {
      // One could write more conditional logic for when to call redirection
      if (state.isLoading) return;
      routerListener?.call();
    });
  }

  /// Redirects the user when our authentication changes
  Future<String?> redirect(BuildContext context, GoRouterState state) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    final now = await storage.read(key: 'now');
    final username = await storage.read(key: 'username');
    final password = await storage.read(key: 'password');
    final thirdparty = await storage.read(key: 'thirdParty');
    print(username);
    // if (token != null) {
    //   if (ref.refresh(Expired).value?.msg ==
    //           "Token expires, Please login again !" &&
    //       now != 'now') {
    //     await storage.delete(key: 'token');
    //     await storage.delete(key: 'password');
    //     await storage.delete(key: 'username');
    //     await storage.delete(key: 'now');
    //     print(storage.read(key: 'token'));
    //   }
    // }
    if (username != null && password != null && thirdparty != null) {
      // If there is login data, allow navigation to any page except the login page
      if (state.location == '${SplashScreen.path}/${SplashScreen1.path}') {
        final email = await storage.read(key: 'email');
        final deviceId = await storage.read(key: 'deviceId');
        final thirdParty = await storage.read(key: 'thirdParty');
        final user = ThirdPartyUser(
          email: email!,
          deviceId: deviceId!,
          name: username,
          dob: '2023-05-29',
          phone: '0912345678',
          thirdParty: thirdParty!,
          thirdPartyToken: password,
        );
        final success =
            await LoginService.thirdPartyLogin(user).then((value) async {
          print("object");
          if (value.success) {
            await storage.write(key: 'token', value: value.token);
            return true;
          } else {
            return false;
          }
        });
        if (success) {
          Future.delayed(const Duration(seconds: 2), () {
            return context.go(HomeScreen.path);
          });
        } else {
          return null;
        }
      }

      if (state.location == '${SplashScreen.path}/${SplashScreen1.path}') {
        final email = await storage.read(key: 'email');
        final deviceId = await storage.read(key: 'deviceId');
        final thirdParty = await storage.read(key: 'thirdParty');
        final user = ThirdPartyUser(
          email: email!,
          deviceId: deviceId!,
          name: username,
          dob: '2023-05-29',
          phone: '0912345678',
          thirdParty: thirdParty!,
          thirdPartyToken: password,
        );
        final success =
            await LoginService.thirdPartyLogin(user).then((value) async {
          print("object");
          if (value.success) {
            await storage.write(key: 'token', value: value.token);
            return true;
          } else {
            return false;
          }
        });
        if (success) {
          Future.delayed(const Duration(seconds: 2), () {
            return context.go(HomeScreen.path);
          });
        } else {
          return null;
        }
      }
    } else {
      // If there is no login data, redirect to the login page
      if (state.location != '${SplashScreen.path}/${SplashScreen1.path}') {
        return null;
      }
    }

    if (username != null && password != null) {
      final email = await storage.read(key: 'email');
      final deviceId = await storage.read(key: 'deviceId');
      final user = user_model.User(
          email: email!, password: password, deviceId: deviceId!);
      final success = await LoginService.login(user).then((value) async {
        if (value.success) {
          await storage.write(key: 'token', value: value.token);
          await storage.write(key: 'email', value: email);
          await storage.write(key: 'username', value: value.data.name);
          await storage.write(key: 'password', value: password);
          await storage.write(key: 'deviceId', value: deviceId);
          final token = await storage.read(key: 'token');
          print('objecttoken');
          print(token);
          return true;
        } else {
          return false;
        }
      });
      if (success) {
        Future.delayed(const Duration(seconds: 5), () {
          context.go(HomeScreen.path);
        });
      } else {}
      // If there is login data, allow navigation to any page except the login page

      if (state.location == '${SplashScreen.path}/${SplashScreen1.path}') {
        return '/';
      }
    } else {
      // If there is no login data, redirect to the login page
      if (state.location != '${SplashScreen.path}/${SplashScreen1.path}') {
        return null;
      }
    }
    return null;
  }

  /// Our application routes. Obtained through code generation
  List<GoRoute> get routes => [
        GoRoute(
          path: SplashScreen.path,
          builder: (context, state) => const SplashScreen(),
          routes: [
            GoRoute(
              path: SplashScreen1.path,
              builder: (context, state) => const SplashScreen1(),
            ),
            GoRoute(
              path: SplashScreen2.path,
              builder: (context, state) => const SplashScreen2(),
            ),
            GoRoute(
              path: SplashScreen3.path,
              builder: (context, state) => const SplashScreen3(),
            ),
            GoRoute(
              path: SplashScreen4.path,
              builder: (context, state) => const SplashScreen4(),
            )
          ],
        ),
        GoRoute(
          path: LoginScreen.path,
          builder: (context, state) => LoginScreen(),
          routes: [
            GoRoute(
              path: SignUpScreen.path,
              builder: (context, state) => const SignUpScreen(),
            ),
            GoRoute(
              path: OtpScreen.path,
              builder: (context, state) => const OtpScreen(),
            ),
            GoRoute(
              path: TermsPrivacyScreen.path,
              builder: (context, state) => const TermsPrivacyScreen(),
            )
          ],
        ),
        GoRoute(
            path: HomeScreen.path,
            builder: (context, state) => const HomeScreen(),
            routes: [
              GoRoute(
                path: '${BookDetailScreen.path}/:id',
                builder: (context, state) => BookDetailScreen(
                  bookId: state.params['id']!,
                ),
                routes: [
                  GoRoute(
                    path: '${BookReader.path}/:i',
                    builder: (context, state) => BookReader(
                      bookId: state.params['i']!,
                    ),
                  ),
                ],
              ),
              GoRoute(
                path: '${AudioDetailScreen.path}/:aid',
                builder: (context, state) => AudioDetailScreen(
                  audioBookId: state.params['aid']!,
                ),
                routes: [
                  GoRoute(
                    path: '${AudioPlayerScreen.path}/:ai',
                    builder: (context, state) => AudioPlayerScreen(
                      audioBookId: state.params['ai']!,
                    ),
                  ),
                  GoRoute(
                    path: '${SummaryScreen.path}/:ai',
                    builder: (context, state) => SummaryScreen(
                      audioBookId: state.params['ai']!,
                    ),
                  ),
                ],
              ),
              GoRoute(
                path: '${VideoDetailScreen.path}/:vid',
                builder: (context, state) => VideoDetailScreen(
                  videoBookId: state.params['vid']!,
                ),
                routes: [
                  GoRoute(
                    path: '${VideoPlayerScreen.path}/:vi',
                    builder: (context, state) => VideoPlayerScreen(
                      videoBookId: state.params['vi']!,
                    ),
                  ),
                ],
              ),
              GoRoute(
                  path: ProfileScreen.path,
                  builder: (context, state) => const ProfileScreen(),
                  routes: [
                    GoRoute(
                      path: FavScreen.path,
                      builder: (context, state) => const FavScreen(),
                    ),
                    GoRoute(
                      path: DownloadScreen.path,
                      builder: (context, state) => const DownloadScreen(),
                    ),
                    GoRoute(
                      path: UpgradeScreen.path,
                      builder: (context, state) => const UpgradeScreen(),
                    ),
                  ]),
              GoRoute(
                  path: AddonsScreen.path,
                  builder: (context, state) => const AddonsScreen(),
                  routes: [
                    GoRoute(
                      path: '${AddonDetailScreen.path}/:adid',
                      builder: (context, state) => AddonDetailScreen(
                        addonsId: state.params['adid']!,
                      ),
                    )
                  ]),
              GoRoute(
                path: '${DownloadAudioDetail.path}/:id/:title/:description',
                builder: (context, state) => DownloadAudioDetail(
                    audioBookId: state.params['id']!,
                    title: state.params['title']!,
                    description: state.params['description']!),
              ),
              GoRoute(
                path:
                    '${DownloadAudioPlayer.path}/:id/:title/:description/:dir',
                builder: (context, state) => DownloadAudioPlayer(
                    audioBookId: state.params['id']!,
                    title: state.params['title']!,
                    description: state.params['description']!,
                    dir: state.params['dir']!),
              ),
              GoRoute(
                path: SearchScreen.path,
                builder: (context, state) => const SearchScreen(),
              ),
              GoRoute(
                path: NotificationScreen.path,
                builder: (context, state) => const NotificationScreen(),
              ),
              GoRoute(
                path: BookGalleryScreen.path,
                builder: (context, state) => const BookGalleryScreen(),
              ),
              GoRoute(
                path: PopularBooksScreen.path,
                builder: (context, state) => const PopularBooksScreen(),
              ),
              GoRoute(
                path: NewAddedScreen.path,
                builder: (context, state) => const NewAddedScreen(),
              ),
            ]),
      ];

  /// Adds [GoRouter]'s listener as specified by its [Listenable].
  /// [GoRouteInformationProvider] uses this method on creation to handle its
  /// internal [ChangeNotifier].
  /// Check out the internal implementation of [GoRouter] and
  /// [GoRouteInformationProvider] to see this in action.
  @override
  void addListener(VoidCallback listener) {
    routerListener = listener;
  }

  /// Removes [GoRouter]'s listener as specified by its [Listenable].
  /// [GoRouteInformationProvider] uses this method when disposing,
  /// so that it removes its callback when destroyed.
  /// Check out the internal implementation of [GoRouter] and
  /// [GoRouteInformationProvider] to see this in action.
  @override
  void removeListener(VoidCallback listener) {
    routerListener = null;
  }
}

final routerNotifierProvider =
    AutoDisposeAsyncNotifierProvider<RouterNotifier, void>(() {
  return RouterNotifier();
});
