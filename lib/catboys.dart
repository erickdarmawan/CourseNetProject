import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class Catboys extends StatefulWidget {
  const Catboys({Key? key}) : super(key: key);

  @override
  State<Catboys> createState() => _CatboysState();
}

class _CatboysState extends State<Catboys> {
  List<dynamic> imageUrls = [];
  var numList = [];

  final customCacheManager = CacheManager(
    Config(
      'customCacheKey',
      stalePeriod: const Duration(days: 7),
      maxNrOfCacheObjects: 20,
    ),
  );

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cat Boys'),
          centerTitle: true,
        ),
        body: RefreshIndicator(
          onRefresh: refresh,
          child: ListView.separated(
            separatorBuilder: ((context, index) => const SizedBox(
                  height: 5,
                )),
            itemCount: imageUrls.length,
            itemBuilder: (context, index) => ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Flexible(
                child: Column(
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        var selectedCatBoy = imageUrls[index];
                        Navigator.pushNamed(context, 'page_catboy_full_screen',
                            arguments: selectedCatBoy);
                      },
                      child: Card(
                        child: Center(
                          child: Container(
                            height: 315,
                            color: Colors.grey.shade200,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    numList[index],
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Flexible(
                                      child: CachedNetworkImage(
                                        cacheManager: customCacheManager,
                                        imageUrl: imageUrls[index],
                                        key: UniqueKey(),
                                        height: 300,
                                        width: 520,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            const Center(
                                                child:
                                                    CircularProgressIndicator()),
                                        errorWidget: (context, url, error) =>
                                            const Center(
                                                child: Icon(Icons.error)),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Future<void> refresh() async {
    setState(() => imageUrls.clear());
    for (var i = 0; i < 20; i++) {
      setState(() {
        numList.add(
          Text(
            '${i + 1}',
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        );
      });
      callCatBoysFromNetwork();
    }
  }

  Future callCatBoysFromNetwork() async {
    var url = Uri.https('api.catboys.com', 'img');
    var response = await http.get(url).catchError((error) {
      if (callCatBoysFromNetwork != callCatBoysFromNetwork) {
        return const Center(child: Icon(Icons.error));
      }
    });

    if (response.statusCode == 200) {
      var detail = jsonDecode(response.body);
      String catsImage = detail['url'];

      setState(() {
        imageUrls.add(catsImage);
      });
    }
  }
}
