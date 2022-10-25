import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselWidget extends StatelessWidget {
  int activeIndex = 0;
  final urlImages = [
    'https://www.retrogamer.net/wp-content/uploads/2014/05/DuckHunt-616x390.png',
    'http://retrogamermag.wpengine.com/wp-content/uploads/2014/05/SuperMarioBros-616x388.png',
    'https://www.retrogamer.net/wp-content/uploads/2014/05/MegaMan2-616x391.png',
    'https://www.retrogamer.net/wp-content/uploads/2014/05/Punchout-616x391.png',
    'http://www.retrogamer.net/wp-content/uploads/2014/05/Metroid.png',
    'https://www.retrogamer.net/wp-content/uploads/2014/05/legend-of-zelda-616x577.png'
  ];
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        borderOnForeground: true,
        child: CarouselSlider(
            items: urlImages
                .map((item) => Container(
                      child: Center(
                          child: Image.network(
                        item,
                        fit: BoxFit.cover,
                        width: 1000,
                      )),
                    ))
                .toList(),
            options: CarouselOptions(
              height: 200,
              aspectRatio: 16 / 9,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: false,
              scrollDirection: Axis.horizontal,
            )),
      ),
    );
    // );
  }
}
