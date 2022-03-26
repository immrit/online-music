import 'package:online_music/GetData/post.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  final url = Uri.parse(
      "https://one-api.ir/spotify/?token=326882:623d956c493ad4.18231183&action=artist&id=5CEosSs2y4M9THNGI6mej8");

  Future getPosts() async {
    var client = http.Client();
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var json = response.body;
      print(json);
      return postFromJson(json);
    }
  }
}
