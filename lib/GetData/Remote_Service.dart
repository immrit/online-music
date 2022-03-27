import 'dart:convert';

import 'package:online_music/GetData/post.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  final url = Uri.parse(
      "https://one-api.ir/spotify/?token=326882:623d956c493ad4.18231183&action=artist&id=4BBgE7HRzS9rdreJyy07Ne");
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
