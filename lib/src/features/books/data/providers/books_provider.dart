import 'package:aptm/src/api/api.dart';
import 'package:aptm/src/features/addons/data/addons_detail_model.dart';
import 'package:aptm/src/features/addons/data/addson_model.dart';
import 'package:aptm/src/features/auth/data/models/login_expired.dart';
import 'package:aptm/src/features/books/data/models/adds_model.dart';
import 'package:aptm/src/features/books/data/models/success.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/book_details_model.dart';
import '../models/books_model.dart';
import '../models/popular_books_model.dart';

final booksProvider = FutureProvider<BooksModel>((ref) async {
  final url = Uri.parse('https://aptm-b.ethical-digit.com/books');
  const storage = FlutterSecureStorage();
  final token = await storage.read(key: 'token');
  print(token);
  print(1234);
  final response = await http.get(url, headers: {'Authorization': token!});
  print(response);
  final json = jsonDecode(response.body);
  return BooksModel.fromJson(json);
});

final addons = FutureProvider<AddsonModel>((ref) async {
  final url = Uri.parse('https://aptm-b.ethical-digit.com/addons');
  const storage = FlutterSecureStorage();
  final token = await storage.read(key: 'token');
  final response = await http.get(url, headers: {'Authorization': token!});
  print(response);
  final json = jsonDecode(response.body);
  return AddsonModel.fromJson(json);
});

final newAddedBooksProvider = FutureProvider<BooksModel>((ref) async {
  final url =
      Uri.parse('https://aptm-b.ethical-digit.com/books?sort=createdAt');
  const storage = FlutterSecureStorage();
  final token = await storage.read(key: 'token');
  await storage.delete(key: 'now');
  print(token!);
  final response = await http.get(url, headers: {'Authorization': token});
  print(response);
  final json = jsonDecode(response.body);
  return BooksModel.fromJson(json);
});

final popularBooksProvider = FutureProvider<PopularBooksModel>((ref) async {
  const storage = FlutterSecureStorage();
  final token = await storage.read(key: 'token');
  print(token!);
  final url = Uri.parse(
      'https://aptm-b.ethical-digit.com/books/topRead?page=0&historyPerPage=10&search=&sort=createdAt');
  final response = await http.get(url, headers: {'Authorization': token});
  print(response);
  final json = jsonDecode(response.body);
  return PopularBooksModel.fromJson(json);
});

final addsProvider = FutureProvider<AddsModel>((ref) async {
  const storage = FlutterSecureStorage();
  final token = await storage.read(key: 'token');
  print(token!);
  final url = Uri.parse('https://aptm-b.ethical-digit.com/adds');
  final response = await http.get(url, headers: {'Authorization': token});
  print(response.body);
  final json = jsonDecode(response.body);
  return AddsModel.fromJson(json);
});

Future<BookDetails> getBookDetails(String bookId) async {
  const storage = FlutterSecureStorage();
  final token = await storage.read(key: 'token');
  print(token!);
  final String apiUrl = 'https://aptm-b.ethical-digit.com/books/$bookId';
  final response = await http.get(Uri.parse(apiUrl), headers: {
    'Authorization': token,
  });
  print("Book Datail Respones ${response.body}");
  if (response.statusCode == 200) {
    final bookJson = json.decode(response.body);
    return BookDetails.fromJson(bookJson);
  } else {
    throw Exception('Failed to retrieve book details.');
  }
}

final bookDetailsProvider =
    FutureProvider.autoDispose.family<BookDetails, String>((ref, id) async {
  const storage = FlutterSecureStorage();
  final token = await storage.read(key: 'token');
  print(token!);
  final String apiUrl = 'https://aptm-b.ethical-digit.com/books/$id';
  final response = await http.get(Uri.parse(apiUrl), headers: {
    'Authorization': token,
  });
  print(response);
  if (response.statusCode == 200) {
    final bookJson = json.decode(response.body);
    return BookDetails.fromJson(bookJson);
  } else {
    throw Exception('Failed to retrieve book details.');
  }
});

final addonsdetial = FutureProvider.autoDispose
    .family<AddsonDetailModel, String>((ref, id) async {
  const storage = FlutterSecureStorage();
  final token = await storage.read(key: 'token');
  print(token!);
  final String apiUrl = 'https://aptm-b.ethical-digit.com/addons/$id';
  final response = await http.get(Uri.parse(apiUrl), headers: {
    'Authorization': token,
  });
  print('$id');
  print(response.body);
  if (response.statusCode == 200) {
    final bookJson = json.decode(response.body);
    return AddsonDetailModel.fromJson(bookJson);
  } else {
    throw Exception('Failed to retrieve book details.');
  }
});

final bookFavProvider =
    FutureProvider.autoDispose.family<Success, String>((ref, id) async {
  const storage = FlutterSecureStorage();
  final token = await storage.read(key: 'token');
  print(token!);
  final url = Uri.parse('https://aptm-b.ethical-digit.com/books/$id/favorite');
  final response = await http.post(url, headers: {'Authorization': token});
  if (response.statusCode == 200) {
    final json = jsonDecode(response.body);
    return Success.fromJson(json);
  } else {
    throw Exception('Failed to retrieve book details.');
  }
});

final bookDownloadProvider =
    FutureProvider.autoDispose.family<Success, String>((ref, id) async {
  const storage = FlutterSecureStorage();
  final token = await storage.read(key: 'token');
  print(token!);
  final url = Uri.parse('https://aptm-b.ethical-digit.com/books/$id/download');
  final response = await http.post(url, headers: {'Authorization': token});
  if (response.statusCode == 200) {
    print(response.body);
    final json = jsonDecode(response.body);
    return Success.fromJson(json);
  } else {
    throw Exception('Failed to retrieve book details.');
  }
});

final audioDownloadProvider =
    FutureProvider.autoDispose.family<Success, String>((ref, id) async {
  const storage = FlutterSecureStorage();
  final token = await storage.read(key: 'token');
  print(token!);
  final url = Uri.parse('https://aptm-b.ethical-digit.com/audios/$id/download');
  final response = await http.post(url, headers: {'Authorization': token});
  if (response.statusCode == 200) {
    print(response.body);
    final json = jsonDecode(response.body);
    return Success.fromJson(json);
  } else {
    throw Exception('Failed to retrieve book details.');
  }
});

final videoFavProvider =
    FutureProvider.autoDispose.family<Success, String>((ref, id) async {
  const storage = FlutterSecureStorage();
  final token = await storage.read(key: 'token');
  print(token!);
  final url = Uri.parse('https://aptm-b.ethical-digit.com/videos/$id/favorite');
  final response = await http.post(url, headers: {'Authorization': token});
  if (response.statusCode == 200) {
    print(response.body);
    final json = jsonDecode(response.body);
    return Success.fromJson(json);
  } else {
    throw Exception('Failed to retrieve book details.');
  }
});

final audioFavProvider =
    FutureProvider.autoDispose.family<Success, String>((ref, id) async {
  const storage = FlutterSecureStorage();
  final token = await storage.read(key: 'token');
  print(token!);
  final url = Uri.parse('https://aptm-b.ethical-digit.com/audios/$id/favorite');
  final response = await http.post(url, headers: {'Authorization': token});
  if (response.statusCode == 200) {
    print(response.body);
    final json = jsonDecode(response.body);
    return Success.fromJson(json);
  } else {
    throw Exception('Failed to retrieve book details.');
  }
});

// final Expired = FutureProvider<LoginExpired>((ref) async {
//   const storage = FlutterSecureStorage();
//   final token = await storage.read(key: 'token');
//   if (token == null) {
//     const tokennot = 'kjekfjkafjeijijf';
//     final url = Uri.parse('https://aptm-b.ethical-digit.com/adds');
//     final response = await http.get(url, headers: {'Authorization': tokennot});
//     print(response.body);
//     final json = jsonDecode(response.body);
//     return LoginExpired.fromJson(json);
//   } else {
//     final url = Uri.parse('https://aptm-b.ethical-digit.com/adds');
//     final response = await http.get(url, headers: {'Authorization': token});
//     print(response.body);
//     final json = jsonDecode(response.body);
//     return LoginExpired.fromJson(json);
//   }
// });

final Expired = FutureProvider<LoginExpired>((ref) async {
  const storage = FlutterSecureStorage();
  final token = await storage.read(key: 'token');
  print(token!);
  final url = Uri.parse('https://aptm-b.ethical-digit.com/adds');
  final response = await http.get(url, headers: {'Authorization': token});
  print(response.body);
  final json = jsonDecode(response.body);
  return LoginExpired.fromJson(json);
});

class Expiredtest {
  static Future<LoginExpired> expireduser() async {
    final url = Uri.parse('https://aptm-b.ethical-digit.com/adds');
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    final response = await http.get(url, headers: {'Authorization': token!});
    print(response.body);
    final userJson = json.decode(response.body);
    return LoginExpired.fromJson(userJson);
  }
}
