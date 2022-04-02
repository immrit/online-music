import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'Post.dart';

Future<Post> fetchPost() async {
  final response = await http.get(
      Uri.parse('https://mrtehran-scraper.herokuapp.com/musics/all?page=1'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    if (kDebugMode) {
      print(response.body);
    }
    return Post.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    if (kDebugMode) {
      print("Erorrrrrrrrrrr!");
    }
    throw Exception('Failed to load album');
  }
}
