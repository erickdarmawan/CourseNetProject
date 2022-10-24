import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';

class ResultWidget extends StatefulWidget {
  const ResultWidget({Key? key}) : super(key: key);

  @override
  State<ResultWidget> createState() => _ResultWidgetState();
}

Future searchMovie(x) async {
  var url = Uri.https('api.themoviedb.org', '3/search/movie',
      {'api_key': '961cd89cb82c3946d873ce11f7c2a89f', 'query': x});

  var response = await http.get(url);
  var result = json.decode(response.body) as Map<String, dynamic>;
  var r = result['results'] as List<dynamic>;
  return r;
}

class _ResultWidgetState extends State<ResultWidget> {
  @override
  Widget build(BuildContext context) {
    var search = ModalRoute.of(context)!.settings.arguments.toString();
    return WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Scaffold(
            body: FutureBuilder(
          future: searchMovie(search),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Please Try Again');
            } else if (snapshot.hasData) {
              var data = snapshot.data as List<dynamic>;
              return GridView.builder(
                  itemCount: data.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    var movie = data[index] as Map<String, dynamic>;
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'page_detail',
                            arguments: movie['id'].toString());
                      },
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: 'https://image.tmdb.org/t/p/w500/' +
                            movie['poster_path'],
                      ),
                    );
                  });
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        )));
  }
}
