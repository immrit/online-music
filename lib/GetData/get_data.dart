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

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    posts = await RemoteService().getPosts();
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
                return Text(
                  posts[index].name,
                  style: const TextStyle(color: Colors.white),
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
