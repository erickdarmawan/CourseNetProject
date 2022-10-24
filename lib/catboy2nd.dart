// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as https;
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:photo_view/photo_view.dart';

// class CatboysWidget extends StatefulWidget {
//   const CatboysWidget({Key? key}) : super(key: key);

//   @override
//   State<CatboysWidget> createState() => _CatboysWidgetState();
// }

// class _CatboysWidgetState extends State<CatboysWidget> {
//   @override
//   Widget build(BuildContext context) {
//     final List<dynamic> ImageUrl = [
//       'https://cdn.catboys.com/images/image_208.jpg',
//       "https://cdn.catboys.com/images/image_31.jpg",
//       "https://cdn.catboys.com/images/image_2.jpg",
//       "https://cdn.catboys.com/images/image_20.jpg",
//     ];
//     // final String ImageUrl2 = "https://cdn.catboys.com/images/image_31.jpg";

//     return MaterialApp(
//       home: Scaffold(
//         backgroundColor: Colors.indigo,
//         appBar: AppBar(
//           leading: BackButton(
//             onPressed: () {
//               Navigator.pushNamed(context, 'page_home');
//             },
//           ),
//           title: const Text('Cat Boys Images'),
//           centerTitle: true,
//         ),
//         body: Column(children: [
//           Expanded(
//             child: Container(
//               child: ListView.builder(
//                   // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   //     crossAxisCount: 2),
//                   shrinkWrap: true,
//                   itemCount: ImageUrl.length,
//                   itemBuilder: (context, index) {
//                     return Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       // child: GestureDetector(
//                       //   onTap: () {},
//                       child: CachedNetworkImage(
//                         width: MediaQuery.of(context).size.width,
//                         height: 650,
//                         // height: MediaQuery.of(context).size.height,
//                         fit: BoxFit.cover,
//                         placeholder: (context, url) =>
//                             const CircularProgressIndicator(),
//                         imageUrl: (ImageUrl[index]),
//                       ),
//                       //   ),
//                     );
//                   }),
//             ),
//           ),
//         ]),
//       ),
//     );
//   }
// }
