import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DataCovid extends StatelessWidget {
  const DataCovid({Key? key}) : super(key: key);

  getDataCovid() async {
    var url = Uri.https('data.covid19.go.id', 'public/api/update.json');
    var response = await http.get(url);
    var result = json.decode(response.body);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text(
          'Statistic Covid-19 Indonesia',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: FutureBuilder(
        future: getDataCovid(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var a = snapshot.data as Map<String, dynamic>;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Card(
                    color: Colors.grey.shade300,
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      height: 50,
                      width: 350,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Cases Count :',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            a['data']['jumlah_odp'].toString(),
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Card(
                    color: Colors.grey.shade300,
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      height: 50,
                      width: 350,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total Spesiman:',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            a['data']['total_spesimen'].toString(),
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Card(
                    color: Colors.grey.shade300,
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      height: 50,
                      width: 350,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Specimen Negative:',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            a['data']['total_spesimen_negatif'].toString(),
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Column(
                  children: <Widget>[
                    Card(
                      color: Colors.indigo.shade400,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            textStyle: const TextStyle(
                          fontSize: 40,
                        )),
                        onPressed: () {
                          Navigator.pushNamed(context, 'page_covid_update');
                        },
                        child: const Text(
                          'Update Today',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Unable to load Covid-19 result:' +
                    snapshot.error.toString()));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
