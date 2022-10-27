// import 'dart:js';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CatboysWidget extends StatefulWidget {
  const CatboysWidget({Key? key}) : super(key: key);

  @override
  State<CatboysWidget> createState() => _CatboysWidgetState();
}

class _CatboysWidgetState extends State<CatboysWidget> {
 List<dynamic> imageUrls = [];

  @override
  Widget build(BuildContext context) {
    for(var i = 0 ; i <= 5; i++){
      getCatBoys();
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cat Boys'),
          centerTitle: true,
        ),
        body:
         ListView.separated(
            separatorBuilder: ((context, index) => SizedBox(
                  height: 12,
                )),
            itemCount: imageUrls.length,
            itemBuilder: (context, index) => ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: imageUrls[index],
                key: UniqueKey(),
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey,
                ),
                errorWidget: (context, url, error) =>
                    Center(child: Icon(Icons.error)),
              ),
            ),
          )
    );
  }
   Future getCatBoys() async {
     var url = Uri.https('api.catboys.com', 'img');
     var response = await http.get(url);

     if (response.statusCode == 200) {
       var detail = jsonDecode(response.body);
       String catsImage = detail['url'];
       setState(() {
         imageUrls.add(catsImage);
       });
     }
   }
}
