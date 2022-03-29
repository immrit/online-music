import 'dart:convert';

import 'package:online_music/GetData/post.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  final url =
      Uri.parse("https://mrtehran-scraper.herokuapp.com/musics/all?page=1");
  Future getPosts() async {
    //CHANGE
    // var client = http.Client();
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var json = response.body;
      //CHANGE
      var a = jsonDecode(json);
      return postFromJson(a["result"]);
    }
  }
}
