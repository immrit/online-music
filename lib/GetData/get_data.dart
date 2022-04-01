// import 'package:flutter/material.dart';

// import 'Post.dart';
// import 'Remote_Service.dart';


// class GetData extends StatefulWidget {
//   const GetData({Key? key}) : super(key: key);

//   @override
//   State<GetData> createState() => _GetDataState();
// }

// class _GetDataState extends State<GetData> {
//   late Future<Post> posts;

//   @override
//   void initState() {
//     super.initState();
//     posts = fetchPost();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Center(
//       child: FutureBuilder<Post>(
//         future: posts,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return ListView.builder(
//               itemCount: snapshot.data!.data.length,
//               itemBuilder: ((context, index) {
//                 return Card(
//                   child: Column(
//                     children: [
//                       Text(snapshot.data!.data[index].artist),
//                       Text(snapshot.data!.data.elementAt(index).title),
//                     ],
//                   ),
//                 );
//               }),
//             );
//           } else if (snapshot.hasError) {
//             return Text('${snapshot.error}');
//           }

//           // By default, show a loading spinner.
//           return const CircularProgressIndicator();
//         },
//       ),
//     ));
//   }
// }
