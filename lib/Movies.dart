
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'search.dart';
//import 'package:cached_network_image/cached_network_image.dart';

class MovieWidget extends StatefulWidget {
  const MovieWidget({Key? key}) : super(key: key);

  @override
  State<MovieWidget> createState() => _MovieWidgetState();
}

class _MovieWidgetState extends State<MovieWidget> {
  Future getMovie() async {
    String theAPI = '';
    if (selectedIndex == 0) {
      theAPI = 'popular';
    } else if (selectedIndex == 1) {
      theAPI = 'top_rated';
    } else if (selectedIndex == 2) {
      theAPI = 'now_playing';
    }
    var xx = Uri.https("api.themoviedb.org", "3/movie/" + theAPI,
        {'api_key': '961cd89cb82c3946d873ce11f7c2a89f'});


    // var xx = Uri.https("api.themoviedb.org", "3/movie/now_playing" // (replace),
    //     {'api_key': '961cd89cb82c3946d873ce11f7c2a89f'});

    var response = await http.get(xx);
    var result = json.decode(response.body);
    return result;
  }

  var selectedRating = 0;

  var selectedIndex = 0;
  //var iconSearch = Icons.search;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.black,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Popular Movie',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.thumb_up),
            label: 'Top Rated',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_circle_fill),
            label: 'Now Playing',
          ),
        ],
        onTap: (index) {
          selectedIndex = index;
          setState(() {});
        },
      ),
      appBar: const SearchWidget(),
      body: FutureBuilder(
        future: getMovie(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: LinearProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Please try again later' + snapshot.toString()));
          } else {
            var data = snapshot.data as Map<String, dynamic>;
            var movies = data['results'] as List<dynamic>;

            return ListView.builder(
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  var movie = movies[index] as Map<String, dynamic>;

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: <Widget>[
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              child: SizedBox(
                                height: 300,
                                width: 180,
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(14),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, 'page_detail',
                                                arguments:
                                                    movie['id'].toString());
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            child: Image.network(
                                              'https://image.tmdb.org/t/p/w500/' +
                                                  movie['poster_path'],
                                              width: 200,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, 'page_detail',
                                            arguments: movie['id'].toString());
                                      },
                                      child: Text(
                                        //
                                        //+
                                        movie['title'],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: Colors.blue,
                                  width: 3,
                                ),
                              ),
                              //alignment: Alignment.topCenter,
                              height: 200,
                              width: 180,
                              child: Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    //   Flexible(
                                    //     child: Padding(
                                    //       padding:
                                    //           const EdgeInsets.only(top: 8.0),
                                    //       child: Text(
                                    //           //'Sypnosis: ' + '' +

                                    //           movie['overview'],
                                    //           textAlign: TextAlign.start,
                                    //           style: TextStyle(
                                    //             fontWeight: FontWeight.bold,
                                    //           )),
                                    //     ),
                                    //   ),
                                    Flexible(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: Center(
                                          child: Text(
                                            'Release Date:  ' '' +
                                                movie['release_date']
                                                    .toString(),
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Center(
                                          child: Text(
                                              'Ratings:  ' '' +
                                                  movie['vote_average']
                                                      .toString(),
                                              style: const TextStyle(
                                                  height: 2,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 15.0),
                                      child: RatingBar.builder(
                                        initialRating: movie['vote_average'],
                                        glow: true,
                                        glowColor: Colors.amber.shade50,
                                        minRating: movie['vote_average'],
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemSize: 25,
                                        itemPadding: const EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          // ),
                                          // onRatingUpdate: (rating) => setState(() {
                                          //   this.rating = rating;
                                          //}
                                        ),
                                        onRatingUpdate: (double value) {},
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        color: Colors.black,
                        thickness: 1,
                      )
                    ]),
                  );
                });
          }
        },
      ),
    );
  }
}

double rating = 0;
