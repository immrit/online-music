import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:online_music/GetData/Remote_Service.dart';
import 'package:online_music/GetData/post.dart';

class GetDataClass extends StatefulWidget {
  const GetDataClass({Key key}) : super(key: key);

  @override
  State<GetDataClass> createState() => _GetDataClassState();
}

class _GetDataClassState extends State<GetDataClass> {
  List<Post> posts = [];

  var isLoading = true;

  Pic _pic;
  @override
  void initState() {
    super.initState();
    //CHANGE
    middle();
  }

  //CHANGE
  void middle() async {
    await getData();
  }

  getData() async {
    //CHANGE
    Post singlePost = await RemoteService().getPosts();
    posts.add(singlePost);
    if (posts != null) {
      setState(() {
        isLoading = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Visibility(
          visible: isLoading,
          child: ListView.builder(
              itemCount: posts == null ? 0 : posts.length,
              itemBuilder: (context, index) {
                print(posts[index].images.toString());

                return Column(
                  children: [
                    Text(
                      posts[index].name,
                      style: const TextStyle(color: Colors.white, fontSize: 50),
                    ),
                    Text(
                      posts[index].popularity.toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 50),
                    ),
                    Text(
                      posts[index].genres.toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 50),
                    ),
                    // Image.network(posts[index].images[1].toString())
                  ],
                );
              }),
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
