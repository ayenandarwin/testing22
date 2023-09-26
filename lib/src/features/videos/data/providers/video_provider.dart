import 'package:aptm/src/api/api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/detail_videobook_model.dart';
import '../models/videobook_model.dart';

final videoBooksProvider = FutureProvider<VideoBooksModel>((ref) async {
  const storage = FlutterSecureStorage();
  final token = await storage.read(key: 'token');
  final url = Uri.parse('https://aptm-b.ethical-digit.com/videos');
  final response = await http.get(url, headers: {'Authorization': token!});
  final json = jsonDecode(response.body);
  return VideoBooksModel.fromJson(json);
});

final videoBookDetailsProvider = FutureProvider.autoDispose
    .family<VideoBookDetailModel, String>((ref, id) async {
  const storage = FlutterSecureStorage();
  final token = await storage.read(key: 'token');
  final String apiUrl = 'https://aptm-b.ethical-digit.com/videos/$id';
  final response = await http.get(Uri.parse(apiUrl), headers: {
    'Authorization': token!,
  });
  if (response.statusCode == 200) {
    final bookJson = json.decode(response.body);
    return VideoBookDetailModel.fromJson(bookJson);
  } else {
    throw Exception('Failed to retrieve book details.');
  }
});
