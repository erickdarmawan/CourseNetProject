import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import 'package:intl/intl.dart';

class CovidUpdate extends StatelessWidget {
  const CovidUpdate({Key? key}) : super(key: key);

  getDataCovid() async {
    //https://data.covid19.go.id/public/api/update.json
    var url = Uri.https('data.covid19.go.id', 'public/api/update.json');
    var response = await https.get(url);
    var result = json.decode(response.body);
    
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            'Today\'s Update',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          centerTitle: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
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
                          Map covidResult = snapshot.data as Map;
                          var getdataCovid =
                              snapshot.data as Map<String, dynamic>;
                          var f = NumberFormat('##,###.0', 'en_US');

                          return ListView(
                            shrinkWrap: true,
                            children: [
                              Center(
                                child: Card(
                                  color: Colors.grey.shade300,
                                  child: Container(
                                    padding: const EdgeInsets.all(15),
                                    height: 50,
                                    width: 350,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Date:',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          (covidResult["update"]["penambahan"]
                                                  ["tanggal"])
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Total Positives:',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          (covidResult["update"]["penambahan"]
                                                  ["jumlah_positif"])
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Total Deaths:',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          (covidResult["update"]["penambahan"]
                                                  ["jumlah_meninggal"])
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Total Patients Cured:',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          (covidResult["update"]["penambahan"]
                                                  ["jumlah_sembuh"])
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Total Patients Treated:',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          (covidResult["update"]["penambahan"]
                                                  ["jumlah_dirawat"])
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          );
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
                              Text('Loading...'),
                            ],
                          );
                        }
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
