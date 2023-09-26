// class JokeApi {
//   final DioClient _dioClient;

//   JokeApi(this._dioClient);

//   Future<Map<String, dynamic>> fetchJokesApiRequest() async {
//     try {
//       final res = await _dioClient.get(Endpoints.jokes);
//       return res.data;
//     } catch (e) {
//       rethrow;
//     }
//   }
// }

import 'dart:convert';

import 'package:aptm/src/features/books/data/models/book_details_model.dart';
import 'package:http/http.dart' as http;

import '../features/books/data/models/books_model.dart';

class ApiProvider {
  static const String baseUrl = 'https://aptm-b.ethical-digit.com';
  static const String apiToken =
      'd4kkOJYfw_9LzZr4QJHYXe:APA91bHUml7m238VOLcNirmSZkv_IZ-Xu55GQaWGPu7mLmaGyYpjIRr2MGdQVnZewBRN_bUn5ks6ZgCev3zHzRl-7sb2RHexOyH1VcQ2O-M8vtvSSFLc59TSOEVvZAItNjtUe5g45th-';
  static const String token =
      'Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2NDYzNDAyOTM3NTliZjNhMDgyZGI4MjMiLCJyb2xlIjoidXNlciIsImlhdCI6MTY4NDMzNTkzNjE3NywiZXhwIjoxNjg0NDIyMzM2MTc3LCJkZXZpY2VJZCI6IlVQUDEuMjMwMTEzLjAxMCJ9.hO-_Vr1uALmls_ETNIvhBJn4Wp9tt09AAU7TjwBnIytI8KUNN6SkfYn_ueSmnwhwmEkaMJzlyStrjO5ulgjYaScKsPDeb8mSXaNb0dm0mnIDynCuYL6oveQ1rxdCWnRZeBc9nZYN-7CB000vSsl8TTiCb5_Iuj2SD29XqmKF701TrysVY5vFzWjNrI_nZjbJekLc8CqYMEW5c6cTVjDK51xHFVal6bRbtyRMk0yI-2nvKcoFOyipSQNeZNhWWEpNiEh-woBeZBGdkbOAg7FvlFxfB6ow3xSTVAWREVmuxCw6qD6nS1r6hqxpwvVmJmGEFxlT9oO9k8vwh1rFd3JAHvtg50StCjv4e0Fp8w6IdRT3Txgalo9jxI6PPnOFnz0B-imDvG2vymj8mM82IsTjETp4AFB4trQc41jEkpEFAm6PIDfGp2LPmRlbFqW9jzjTmyqDgY2uanDysr0Vr1yqgQIwWrENf-JoZqwSvaGqAzPEEROKxQ8tdb3xryszmz6PxTsWesrThcRqVpEUAN_QMFV6vAsxBxaIjkd1F5iP9qvHHkhqazL_5Wa_wqQQ73BGOKkC7AZ48IV8xQkIh9jcFSdzkHHDerjOsd90-lfp3fCsianQ9621FAr82ujnaCNDZX9P4zsy3m4bDirFmuviJIQyUQVebWu-2320qR-t-U0';
  final http.Client _client;

  ApiProvider({http.Client? client}) : _client = client ?? http.Client();

  Future<BookDetails> fetchBookDetails(int bookId) async {
    final response =
        await http.get(Uri.parse('https://example.com/books/$bookId'));
    if (response.statusCode == 200) {
      return BookDetails.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load book details');
    }
  }

  Future<BooksModel> fetchBooks() async {
    final url = Uri.parse('https://example.com/api/books');
    final response =
        await http.get(url, headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return BooksModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to load books');
    }
  }
}
