import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import 'package:intl/intl.dart';

class CovidUpdateWidget extends StatelessWidget {
  const CovidUpdateWidget({Key? key}) : super(key: key);

  getDataCovid() async {
    //https://data.covid19.go.id/public/api/update.json
    var url = Uri.https('data.covid19.go.id', 'public/api/update.json');
    var response = await https.get(url);
    var result = json.decode(response.body);
    return result;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.blueAccent.shade100,
            title: const Text(
              'Todays Update',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            centerTitle: true),
        body: Container(
          child: Card(
            child: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(3),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: FutureBuilder(
                      future: getDataCovid(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var getdataCovid =
                              snapshot.data as Map<String, dynamic>;
                          var f = NumberFormat('##,###.0', 'en_US');
                          return ListView(
                            shrinkWrap: true,
                            children: [
                              Text('Date ' +
                                  f
                                      .format(getdataCovid["update"]
                                          ["penambahan"]["tanggal"])
                                      .toString()),
                              Text('Positives ' +
                                  f
                                      .format(getdataCovid["update"]
                                          ["penambahan"]["jumlah_positif"])
                                      .toString()),
                              Text('Deaths' +
                                  f
                                      .format(getdataCovid["update"]
                                          ["penambahan"]["jumlah_meninggal"])
                                      .toString()),
                              Text('Patients Cured ' +
                                  f
                                      .format(getdataCovid["update"]
                                          ["penambahan"]["jumlah_sembuh"])
                                      .toString()),
                              Text('Patients Treated ' +
                                  f
                                      .format(getdataCovid["update"]
                                          ["penambahan"]["jumlah_dirawat"])
                                      .toString()),
                              Text(f.format(123456.28)),
                            ],
                          );

                          // return Center(child: Text('Data Covid berhasil diambil'));
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Gagal ambil data, coba lagi!!' +
                                  snapshot.error.toString()));
                        } else {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              CircularProgressIndicator(),
                              Text('Loading...')
                            ],
                          );
                        }
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
