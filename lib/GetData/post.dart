//CHANGE
// Post postFromJson(Map<String, dynamic> json) => Post.fromJson(json);
// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

Post postFromJson(Map<String, dynamic> json) => Post.fromJson(json);

String postToJson(Post data) => json.encode(data.toJson());

class Post {
  Post({
    this.data,
  });

  List<Datum> data;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.title,
    this.artist,
    this.url,
    this.file,
    this.cover,
  });

  String title;
  String artist;
  String url;
  String file;
  String cover;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        title: json["title"],
        artist: json["artist"],
        url: json["url"],
        file: json["file"],
        cover: json["cover"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "artist": artist,
        "url": url,
        "file": file,
        "cover": cover,
      };
}
