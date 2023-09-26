import 'package:aptm/src/features/auth/presentation/screens/terms_privacy_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../models/new_user.dart';
import '../services/auth_service.dart';

final signupProvider =
    StateNotifierProvider<SignupNotifier, SignupState>((ref) {
  return SignupNotifier();
});

final authServiceProvider = Provider<LoginService>((ref) {
  return LoginService();
});

class SignupNotifier extends StateNotifier<SignupState> {
  SignupNotifier() : super(SignupState());

  Future<void> signup(
      BuildContext context,
      String name,
      String email,
      String password,
      String dob,
      String role,
      String phone,
      String deviceId) async {
    try {
      state = SignupState.loading();
      final user = NewUser(
          name: name,
          email: email,
          password: password,
          dob: dob,
          role: role,
          deviceId: deviceId,
          phone: phone);
      final success = await LoginService.signUp(user).then((value) {
        if (value.success) {
          storage.write(key: 'token', value: value.token);
          storage.write(key: 'username', value: user.name);
          storage.write(key: 'email', value: user.email);
          storage.write(key: 'password', value: user.password);
          storage.write(key: 'now', value: 'now');
          storage.write(key: 'deviceId', value: deviceId);
          return true;
        } else {
          return false;
        }
      });
      if (success) {
        state = SignupState.success();
        // ignore: use_build_context_synchronously
        context.go(TermsPrivacyScreen.path);
      } else {
        state = SignupState.error('Something went Wrong');
      }
    } catch (error) {
      state = SignupState.error(error.toString());
    }
    return;
  }

  Future<void> logout() async {
    await LoginService.logout();
    state = SignupState.initial();
  }
}

class SignupState {
  final bool isLoading;
  final bool isSuccess;
  final String? error;

  SignupState({this.isLoading = false, this.isSuccess = false, this.error});

  factory SignupState.initial() => SignupState();

  factory SignupState.loading() => SignupState(isLoading: true);

  factory SignupState.success() => SignupState(isSuccess: true);

  factory SignupState.error(String message) => SignupState(error: message);
}
