import 'dart:ui';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class PageDetailWidget extends StatelessWidget {
  PageDetailWidget({Key? key}) : super(key: key);

  Future getMovieDetails(id) async {
    var url = Uri.https('api.themoviedb.org', '3/movie/' + id, {
      'api_key': '961cd89cb82c3946d873ce11f7c2a89f',
    });
    var response = await http.get(url);
    print(response.body);
    var result = json.decode(response.body);

    return result;
  }

  var selectedRating = 0;

  String text = '';
  String link = '';
  @override
  Widget build(BuildContext context) {
    var id = ModalRoute.of(context)!.settings.arguments.toString();
    return Scaffold(
      body: FutureBuilder(
        future: getMovieDetails(id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var movie = snapshot.data as Map<String, dynamic>;
            var rating = movie['vote_average'];
            return Stack(fit: StackFit.expand, children: [
              Image.network(
                  'https://image.tmdb.org/t/p/w500/' + movie['poster_path'],
                  fit: BoxFit.fill),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: Container(
                  color: Colors.yellow.withOpacity(0.2),
                ),
              ),
              ListView(
                children: [
                  Container(
                    height: 300,
                    width: 250,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.white,
                              blurRadius: 50,
                              offset: Offset(0, 0)),
                        ],
                        image: DecorationImage(
                            image: NetworkImage(
                          'https://image.tmdb.org/t/p/w500/' +
                              movie['poster_path'],
                        ))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(
                        child: Text(
                      movie['title'],
                      style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(0.0, 0.0),
                              blurRadius: 20.0,
                              color: Colors.white,
                            ),
                          ]),
                    )),
                  ),
                  Center(
                    child: SizedBox(
                      width: 350,
                      child: Text(
                        movie['overview'],
                        style: const TextStyle(
                            fontSize: 18,
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(0.0, 0.0),
                                blurRadius: 10.0,
                                color: Colors.white,
                              ),
                            ],
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Center(
                              child: Text(
                                'Release Date:  ' '' +
                                    movie['release_date'].toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  shadows: <Shadow>[
                                    Shadow(
                                      offset: Offset(0.0, 1.0),
                                      blurRadius: 10.0,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                'Rating: $rating ',
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  shadows: <Shadow>[
                                    Shadow(
                                      offset: Offset(0.0, 0.0),
                                      blurRadius: 10.0,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: Center(
                              child: RatingBar.builder(
                                initialRating: movie['vote_average'],
                                glow: true,
                                glowColor: Colors.amber.shade50,
                                glowRadius: 20,
                                minRating: movie['vote_average'],
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 10,
                                itemSize: 50,
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) => setState(() {
                                  this.rating = rating;
                                }),
                              ),
                            ),
                          ),

                          Builder(
                            builder: (BuildContext context) {
                              return Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.blue),
                                  child: IconButton(
                                      color: Colors.white,
                                      icon: const Icon(Icons.share),
                                      onPressed: () async {
                                        await Share.share('Share this movie');
                                      }
                                      ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ]);
          } else if (snapshot.hasError) {
            return const Center(child: Text('Please Try Again Later'));
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  double rating = 0;
  void _onShare(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    await Share.share(text,
        subject: link,
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }

  setState(Null Function() param0) {}
}
