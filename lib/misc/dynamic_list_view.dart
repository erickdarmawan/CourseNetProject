import 'package:flutter/material.dart';

class DynamicListView extends StatelessWidget {
  List movies = ["Movie1", "Movie2", "Movie3", "Movie4", "Movie5", "Movie6"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Dynamic List View'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return Text(movies[index]);
            },
          ),
        ));
  }
}
