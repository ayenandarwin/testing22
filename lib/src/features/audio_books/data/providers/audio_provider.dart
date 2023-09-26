import 'package:aptm/src/api/api.dart';
import 'package:aptm/src/features/audio_books/data/models/audio_books_model.dart';
import 'package:aptm/src/features/audio_books/data/models/detail_audiobook_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final audioBooksProvider = FutureProvider<AudioBooksModel>((ref) async {
  const storage = FlutterSecureStorage();
  final token = await storage.read(key: 'token');
  final url = Uri.parse(
      'https://aptm-b.ethical-digit.com/audios?audioBookPerPage=10&page=0');
  final response = await http.get(url, headers: {'Authorization': token!});
  final json = jsonDecode(response.body);
  return AudioBooksModel.fromJson(json);
});

final audioBookDetailsProvider = FutureProvider.autoDispose
    .family<AudioBooksDetail, String>((ref, id) async {
  const storage = FlutterSecureStorage();
  final token = await storage.read(key: 'token');
  final String apiUrl = 'https://aptm-b.ethical-digit.com/audios/$id';
  final response = await http.get(Uri.parse(apiUrl), headers: {
    'Authorization': token!,
  });
  if (response.statusCode == 200) {
    final bookJson = json.decode(response.body);
    return AudioBooksDetail.fromJson(bookJson);
  } else {
    throw Exception('Failed to retrieve book details.');
  }
});
