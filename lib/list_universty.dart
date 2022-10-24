import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListUniversityWidget extends StatefulWidget {
  const ListUniversityWidget({Key? key}) : super(key: key);

  @override
  State<ListUniversityWidget> createState() => _ListUniversityWidgetState();
}

class _ListUniversityWidgetState extends State<ListUniversityWidget> {
  List countries = [];
  bool processing = true;
  var selectedCountry;

  @override
  void initState() {
    super.initState();
    getListCountries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Of University'),
      ),
      body: ListView(
        children: [
          //processing ? CircularProgressIndicator() : Container(),
          Visibility(
            visible: processing,
            child: const CircularProgressIndicator(),
          ),
          DropdownButton(
            value: selectedCountry,
            items: countries.map((country) {
              return DropdownMenuItem(value: country, child: Text(country));
            }).toList(),
            onChanged: (value) {
              selectedCountry = value;
              setState(() {});
              Text(selectedCountry ?? '');
            },
          ),
          //processing ? CircularProgressIndicator() : Container(),
          Visibility(
            visible: processing,
            child: const CircularProgressIndicator(),
          ),

          FutureBuilder(
            future: getListUniversities(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                    child: Text(
                        'Error... Please Try Again' + snapshot.toString()));
              } else {
                var dataS = snapshot.data as List<dynamic>;

                return ListView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: dataS.length,
                    itemBuilder: (context, index) {
                      var univ = dataS[index] as Map<String, dynamic>;
                      int no = index + 1;

                      var webpages = univ["web_pages"
                          // + "domains"
                          ] as List<dynamic>;
                      var webpage = '';
                      var webpage2 = '';
                      var allWebpages = webpages.join(',');

                      if (webpages.isNotEmpty) {
                        webpage = webpages[0];

                        if (webpages.length > 1) {
                          webpage2 = webpages[1];
                        }
                      }

                      return Card(
                        color: Colors.indigo.shade50,
                        shadowColor: Colors.black,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            no.toString() +
                                '.' +
                                univ['name'] +
                                '' +
                                allWebpages,
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                      );
                    });
              }
            },
          ),
        ],
      ),
    );
  }

  Future getListUniversities() async {
    var url = Uri.http(
        'universities.hipolabs.com', 'search', {'country': selectedCountry});

    //jsononject => Map<String, dynamic>
    //jsonarray => List<dynamic> (berisi banyak map, dynamic>
    var response = await http.get(url);
    var result = json.decode(response.body) as List<dynamic>;
    return result;
  }

  Future getListCountries() async {
    // https: //api.first.org/data/v1/countries
    var url = Uri.https('api.first.org', 'data/v1/countries');
    var response = await http.get(url);
    var result = json.decode(response.body);
    var list = result['data'] as Map<String, dynamic>;

    list.forEach((key, value) {
      String country = value['country'];
      countries.add(country);
    });

    countries.sort((a, b) {
      return a.toString().compareTo(b.toString());
    });
    processing = false;
    setState(() {});
    // await Future.delayed(Duration(seconds: 5));
  }
}

