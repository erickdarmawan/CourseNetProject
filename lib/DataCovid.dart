import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CovidWidget extends StatelessWidget {
  const CovidWidget({Key? key}) : super(key: key);

  getDataCovid() async {
    //https://data.covid19.go.id/public/api/update.json
    var url = Uri.https('data.covid19.go.id', 'public/api/update.json');
    var response = await http.get(url);
    var result = json.decode(response.body);

    // await Future.delayed(Duration(seconds: 5));
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.indigo.shade100,
        title: const Text(
          'Statistic Covid-19 Indonesia',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: FutureBuilder(
        future: getDataCovid(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var a = snapshot.data as Map<String, dynamic>;
            // json
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    'Cases Count :' + a['data']['jumlah_odp'].toString(),
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Center(
                  child: Text(
                    'Total Spesiman: ' + a['data']['total_spesimen'].toString(),
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Center(
                  child: Text(
                    'Specimen Negative:' +
                        a['data']['total_spesimen_negatif'].toString(),
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
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
                              color: Colors.white,
                              fontSize: null,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                    'Todays Date: ' +
                        a['update']["penambahan"]["tanggal"].toString(),
                    style:
                        const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text(
                    'Positive: ' +
                        a['update']["penambahan"]["jumlah_positif"].toString(),
                    style:
                        const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text(
                    'Treated: ' +
                        a['update']["penambahan"]["jumlah_dirawat"].toString(),
                    style:
                        const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text(
                    'Cured: ' +
                        a['update']["penambahan"]["jumlah_sembuh"].toString(),
                    style:
                        const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text(
                    'Death: ' +
                        a['update']["penambahan"]["jumlah_meninggal"]
                            .toString(),
                    style:
                        const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text(
                    'Todays Date: ' +
                        a['update']["penambahan"]["tanggal"].toString(),
                    style:
                        const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ));

            // return Center(
            //     child: Text(
            //   'Covid-19 result has successfully loaded',
            //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            // ));
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
