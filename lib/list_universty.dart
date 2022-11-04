import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListUniversity extends StatefulWidget {
  const ListUniversity({Key? key}) : super(key: key);

  @override
  State<ListUniversity> createState() => _ListUniversityState();
}

class _ListUniversityState extends State<ListUniversity> {
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
          DropdownButton(
            hint: const Text('Select your country'),
            value: selectedCountry,
            items: countries.map((country) {
              return DropdownMenuItem(value: country, child: Text(country));
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedCountry = value;
              });
              Text(selectedCountry ?? '');
            },
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
                      var webpages = univ["web_pages"] as List<dynamic>;
                      var allWebpages = webpages.join(',');

                      return Card(
                        color: Colors.indigo.shade50,
                        shadowColor: Colors.black,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            no.toString() +
                                '.' +
                                univ['name'] +
                                ' ' +
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
    if (selectedCountry == null) {
      return [];
    }
    var url = Uri.http(
        'universities.hipolabs.com', 'search', {'country': selectedCountry});

    var response = await http.get(url);
    var result = json.decode(response.body) as List<dynamic>;
    return result;
  }

  Future getListCountries() async {
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

    setState(() {
      processing = false;
    });
  }
}
