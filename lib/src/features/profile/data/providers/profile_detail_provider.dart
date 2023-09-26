import 'dart:io';

import 'package:aptm/src/api/api.dart';
import 'package:aptm/src/features/auth/data/models/user_model.dart';
import 'package:aptm/src/features/profile/data/providers/download_model.dart';
import 'package:aptm/src/features/profile/data/providers/fav_model.dart';
import 'package:aptm/src/features/profile/data/providers/pricing_model.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:path_provider/path_provider.dart';

// final booksProvider = FutureProvider<BooksModel>((ref) async {
//   final url = Uri.parse('https://aptm-b.ethical-digit.com/books');
//   final response =
//       await http.get(url, headers: {'Authorization': ApiProvider.token});
//   print(response);
//   final json = jsonDecode(response.body);
//   return BooksModel.fromJson(json);
// });

final profilDetailsProvider = FutureProvider<UserData>((ref) async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  final devicedata = await deviceInfo.androidInfo;
  final deviceId = devicedata.id;
  const url = '${ApiProvider.baseUrl}/auth/login';
  const storage = FlutterSecureStorage();
  final email = await storage.read(key: 'email');
  final password = await storage.read(key: 'password');
  final fcmToken = await FirebaseMessaging.instance.getToken();
  final token = fcmToken;
  print('Testing');
  print(token);
  print(password);
  final response = await http.post(Uri.parse(url), body: {
    'email': email,
    'password': password,
    'deviceId': deviceId,
    'token': token,
  });
  print(response.body);
  if (response.statusCode == 200) {
    final bookJson = json.decode(response.body);
    return UserData.fromJson(bookJson);
  } else {
    throw Exception('Failed to retrieve book details.');
  }
  // final String apiUrl = 'https://aptm-b.ethical-digit.com/books/$id';
  // final response = await http.get(Uri.parse(apiUrl), headers: {
  //   'Authorization': ApiProvider.token,
  // });
  // print(response);
  // if (response.statusCode == 200) {
  //   final bookJson = json.decode(response.body);
  //   return BookDetails.fromJson(bookJson);
  // } else {
  //   throw Exception('Failed to retrieve book details.');
  // }
});

final profileFav = FutureProvider<FavModel>((ref) async {
  final url = Uri.parse('https://aptm-b.ethical-digit.com/favorites');
  const storage = FlutterSecureStorage();
  final token = await storage.read(key: 'token');
  final response = await http.get(url, headers: {'Authorization': token!});
  print(response.body);
  final json = jsonDecode(response.body);
  return FavModel.fromJson(json);
});

final pricing = FutureProvider<PricingModel>((ref) async {
  final url = Uri.parse('https://aptm-b.ethical-digit.com/packages');
  const storage = FlutterSecureStorage();
  final token = await storage.read(key: 'token');
  final response = await http.get(url, headers: {'Authorization': token!});
  print(response.body);
  final json = jsonDecode(response.body);
  return PricingModel.fromJson(json);
});

final downloadLocal = FutureProvider<DownloadModel>((ref) async {
  final directory = await getApplicationDocumentsDirectory();
  final filePath = '${directory.path}/response.json';

  final file = File(filePath);
  if (!await file.exists()) {
    final initialData = {
      "success": true,
      "downloads": []
    }; // Replace with your desired initial JSON data
    final jsonString = jsonEncode(initialData);

    // Create the file and write the initial JSON data
    await file.writeAsString(jsonString);
  }

  final jsonString = await file.readAsString();

  final json = jsonDecode(jsonString);
  print(json);
  return DownloadModel.fromJson(json);
});

Future<void> saveJsonResponseLocally(String jsonResponse) async {
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/response.json');
  await file.writeAsString(jsonResponse);

  print('JSON response saved locally!');
}

final profileDownload = FutureProvider<DownloadModel>((ref) async {
  final url = Uri.parse('https://aptm-b.ethical-digit.com/downloads');
  final storage = FlutterSecureStorage();
  final token = await storage.read(key: 'token');
  final response = await http.get(url, headers: {'Authorization': token!});
  print(response.body);
  final jsonResponse = response.body;
  await saveJsonResponseLocally(jsonResponse);
  final json = jsonDecode(jsonResponse);
  return DownloadModel.fromJson(json);
});
