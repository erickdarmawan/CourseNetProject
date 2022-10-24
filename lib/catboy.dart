// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as https;
// import 'package:cached_network_image/cached_network_image.dart';

// class CatboyWidget extends StatefulWidget {
//   const CatboyWidget({Key? key}) : super(key: key);

//   @override
//   State<CatboyWidget> createState() => _CatboyWidgetState();
// }

// class _CatboyWidgetState extends State<CatboyWidget> {
//   List CatBoys = [];
//   bool processing = true;
//   var selectedcatboys = null;

//   void initState() {
//     super.initState();

//     GetCatBoys();
//   }

//   Future GetCatBoys() async {
//     //https://api.catboys.com/img
//     var url = Uri.https('api.catboys.com', 'img');
//     var response = await https.get(url);
//     var result = json.decode(response.body);
//     var list = result['url'] as Map<String, dynamic>;

//     const String catboyImageAPIURL = 'url';
//     const String catboyArtist = 'artist';
//     const String artistURL = 'artist_url';
//     const String sourceURL = 'source_url';

//     list.forEach((key, value) {
//       String url = value['url'];
//       CatBoys.add(CatBoys);
//     });
//     processing = false;
//     setState(() {});

//     @override
//     Widget build(BuildContext context) {
//       return Scaffold(
//         appBar: AppBar(
//           title: Text('Cat Boy'),
//           centerTitle: true,
//         ),
//         body: Center(
//           child: FutureBuilder(
//             future: GetCatBoys(),
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 return GridView.builder(
//                     itemCount: 2,
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2),
//                     itemBuilder: (context, index) {
//                       return Padding(
//                           padding: EdgeInsets.all(5),
//                           child: Container(
//                               decoration: new BoxDecoration(
//                                   image: new DecorationImage(
//                                       image: new NetworkImage(
//                                           //'https://api.catboys.com/img'
//                                           snapshot.data![index]),
//                                       fit: BoxFit.cover))));
//                     });
//               }
//               return Center(child: CircularProgressIndicator());
//             },
//           ),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
// }
