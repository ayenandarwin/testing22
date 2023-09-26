import 'package:aptm/src/features/auth/data/models/third_party_user.dart';
import 'package:aptm/src/features/main/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:restart_app/restart_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart' as user_model;
import '../services/auth_service.dart';

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  return LoginNotifier();
});

const storage = FlutterSecureStorage();
final isLoggedInProvider = FutureProvider<bool>((ref) async {
  final username = await storage.read(key: 'username');
  final password = await storage.read(key: 'password');
  return username != null && password != null;
});

final authServiceProvider = Provider<LoginService>((ref) {
  return LoginService();
});

class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifier() : super(LoginState());

  Future<void> checkLoginStatus(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn) {
      // ignore: use_build_context_synchronously
      context.go(HomeScreen.path);
    }
  }

  Future<void> login(BuildContext context, String email, String password,
      String deviceId) async {
    try {
      state = LoginState.loading();
      final user =
          user_model.User(email: email, password: password, deviceId: deviceId);
      final success = await LoginService.login(user).then((value) async {
        if (value.success) {
          await storage.write(key: 'token', value: value.token);
          await storage.write(key: 'email', value: email);
          await storage.write(key: 'username', value: value.data.name);
          await storage.write(key: 'password', value: password);
          await storage.write(key: 'deviceId', value: deviceId);
          await storage.write(
              key: 'profileImage', value: value.data.profileImage);
          final token = await storage.read(key: 'token');
          print('objecttoken');
          print(token);
          return true;
        } else {
          return false;
        }
      });
      if (success) {
        state = LoginState.success();
        Future.delayed(const Duration(seconds: 2), () {
          context.go(HomeScreen.path);
        });
      } else {
        state = LoginState.error('Invalid email or password');
      }
    } catch (e) {
      state = LoginState.error(e.toString());
    }
  }

  Future<void> thirdPartyLogin(BuildContext context, String email,
      String password, String deviceId, String thirdParty, String name) async {
    try {
      state = LoginState.loading();
      final user = ThirdPartyUser(
        email: email,
        deviceId: deviceId,
        name: name,
        dob: '2023-05-29',
        phone: '0912345678',
        thirdParty: thirdParty,
        thirdPartyToken: password,
      );
      final success =
          await LoginService.thirdPartyLogin(user).then((value) async {
        print("object");
        if (value.success) {
          await storage.write(key: 'token', value: value.token);
          await storage.write(
              key: 'profileImage', value: value.data.profileImage);
          return true;
        } else {
          return false;
        }
      });
      if (success) {
        state = LoginState.success();
        Future.delayed(const Duration(seconds: 2), () {
          context.go(HomeScreen.path);
        });
      } else {
        state = LoginState.error('Invalid email or password');
      }
    } catch (e) {
      state = LoginState.error(e.toString());
    }
  }

  // Future<void> thirdPartyLogin(BuildContext context, String email,
  //     String password, String deviceId, thirdParty) async {
  //   try {
  //     state = LoginState.loading();
  //     final user = ThirdPartyUser(
  //       email: email,
  //       deviceId: deviceId,
  //       name: 'Aptm',
  //       phone: '0912345678',
  //       thirdParty: thirdParty,
  //       thirdPartyToken: password,
  //       token: '',
  //     );
  //     final success = await LoginService.thirdPartyLogin(user).then((value) {
  //       if (value.success) {
  //         return true;
  //       } else {
  //         return false;
  //       }
  //     });
  //     print("object");
  //     if (success) {
  //       state = LoginState.success();
  //       // ignore: use_build_context_synchronously
  //       context.go(HomeScreen.path);
  //     } else {
  //       state = LoginState.error('Invalid email or password');
  //     }
  //   } catch (e) {
  //     state = LoginState.error(e.toString());
  //   }
  // }

  Future<UserCredential> signInWithGoogle(
      BuildContext context, String deviceId) async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    final googleLogin =
        await FirebaseAuth.instance.signInWithCredential(credential);
    String email = googleLogin.user?.email ?? '';
    String accessToken = googleLogin.credential?.accessToken ?? '';
    String name = googleLogin.user?.displayName ?? '';
    print(name);
    print(googleLogin.user?.email);
    print(googleLogin.credential?.accessToken);
    thirdPartyLogin(
      context,
      email,
      accessToken,
      deviceId,
      'google',
      name,
    );

    // Once signed in, return the UserCredential
    return googleLogin;
    // return;
  }

  Future<UserCredential> signInWithFacebook(
      BuildContext context, String deviceId) async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    final facebookLogin = await FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential);
    print("email${facebookLogin.user!.email}");
    print("token${loginResult.accessToken!.token}");
    String email = facebookLogin.user?.email ?? '';
    String accessToken = loginResult.accessToken!.token;
    String name = facebookLogin.user?.displayName ?? '';
    print(name);
    thirdPartyLogin(
      context,
      email,
      accessToken,
      deviceId,
      'google',
      name,
    );
    return facebookLogin;
  }

  Future<void> logout() async {
    await LoginService.logout();
  }
}

class LoginState {
  final bool isLoading;
  final bool isSuccess;
  final String? error;

  LoginState({this.isLoading = false, this.isSuccess = false, this.error});

  factory LoginState.initial() => LoginState();

  factory LoginState.loading() => LoginState(isLoading: true);

  factory LoginState.success() => LoginState(isSuccess: true);

  factory LoginState.error(String message) => LoginState(error: message);
}
