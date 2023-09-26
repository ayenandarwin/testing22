import 'dart:convert';
import 'dart:io';
import 'package:aptm/src/api/api.dart';
import 'package:aptm/src/features/auth/data/models/third_party_user.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/new_user.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

const storage = FlutterSecureStorage();

class LoginService {
  static Future<UserData> login(User user) async {
    const url = '${ApiProvider.baseUrl}/auth/login';
    final fcmToken = await FirebaseMessaging.instance.getToken();
    print(fcmToken);

    final response = await http.post(Uri.parse(url), body: {
      'email': user.email,
      'password': user.password,
      'deviceId': user.deviceId,
      'token': fcmToken,
    });
    print(response.body);
    if (response.statusCode == 200) {
      final userJson = json.decode(response.body);
      await storage.write(key: 'email', value: user.email);
      await storage.write(key: 'password', value: user.password);
      await storage.write(key: 'now', value: 'now');
      return UserData.fromJson(userJson);
    } else {
      throw Exception('Failed to retrieve book details.');
    }
  }

  static Future<UserData> thirdPartyLogin(ThirdPartyUser user) async {
    const url = '${ApiProvider.baseUrl}/auth/thirdPartyLogin';
    final fcmToken = await FirebaseMessaging.instance.getToken();
    print(fcmToken);
    print('email: ${user.email} device_id: ${user.deviceId}');

    final response = await http.post(Uri.parse(url), body: {
      'name': user.name,
      'email': user.email,
      'thirdParty': user.thirdParty,
      'thirdPartyToken': user.thirdPartyToken,
      'phone': user.phone,
      'deviceId': user.deviceId,
      'token': fcmToken,
      'dob': '2023-05-29',
      'password': user.thirdPartyToken
    });
    print(response.body);
    if (response.statusCode == 201) {
      final userJson = json.decode(response.body);
      await storage.write(key: 'username', value: user.name);
      await storage.write(key: 'password', value: user.thirdPartyToken);
      await storage.write(key: 'now', value: 'now');
      await storage.write(key: 'email', value: user.email);
      await storage.write(key: 'deviceId', value: user.deviceId);
      await storage.write(key: 'dob', value: '2023-05-29');
      await storage.write(key: 'phone', value: user.phone);
      await storage.write(key: 'thirdParty', value: user.thirdParty);
      await storage.write(key: 'thirdPartyToken', value: user.thirdPartyToken);
      return UserData.fromJson(userJson);
    } else {
      throw Exception('Failed to retrieve book details.');
    }
  }

  static Future<UserData> signUp(NewUser user) async {
    const url = '${ApiProvider.baseUrl}/auth/register';
    final fcmToken = await FirebaseMessaging.instance.getToken();
    print(fcmToken);
    print(
        'email: ${user.email} password: ${user.password} device_id: ${user.deviceId}');

    final response = await http.post(Uri.parse(url), body: {
      'name': user.name,
      'email': user.email,
      'password': user.password,
      'dob': user.dob,
      'role': user.role,
      'phone': user.phone,
      'deviceId': user.deviceId,
      'token': fcmToken,
    });
    print(response.body);
    if (response.statusCode == 201) {
      final userJson = json.decode(response.body);
      await storage.write(key: 'username', value: user.email);
      await storage.write(key: 'password', value: user.password);
      return UserData.fromJson(userJson);
    } else {
      String responseString = response.body;

      Map<String, dynamic> error = jsonDecode(responseString);
      String errorMessage = error["error"];
      throw Exception(errorMessage);
    }
  }

  // static Future<UserData> thirdPartyLogin(ThirdPartyUser user) async {
  //   const url = '${ApiProvider.baseUrl}/auth/thirdPartyLogin';

  //   final response = await http.post(Uri.parse(url), body: {
  //     'name': user.name,
  //     'email': user.email,
  //     'thirdParty': user.thirdParty,
  //     'thirdPartyToken': user.thirdPartyToken,
  //     'phone': user.phone,
  //     'deviceId': user.deviceId,
  //     'token': ApiProvider.apiToken,
  //   });
  //   // print(response.body);
  //   if (response.statusCode == 201) {
  //     final userJson = json.decode(response.body);
  //     await storage.write(key: 'username', value: user.email);
  //     await storage.write(key: 'password', value: null);
  //     return UserData.fromJson(userJson);
  //   } else {
  //     String responseString = response.body;

  //     Map<String, dynamic> error = jsonDecode(responseString);
  //     String errorMessage = error["error"];
  //     throw Exception(errorMessage);
  //   }
  // }

  static Future<void> logout() async {
    await storage.write(key: 'logout', value: 'logout');
    await storage.delete(key: 'password');
    await storage.delete(key: 'email');
    await storage.delete(key: 'username');
    await storage.delete(key: 'token');
    await storage.delete(key: 'profileImage');
    print(await storage.read(key: 'password'));

    await DefaultCacheManager().emptyCache();
    HttpClient().close(force: true);
  }
}
