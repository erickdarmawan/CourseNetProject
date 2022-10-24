//import 'dart:html';

// 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HolidaysWidget extends StatefulWidget {
  const HolidaysWidget({Key? key}) : super(key: key);

  @override
  State<HolidaysWidget> createState() => _HolidaysWidgetState();
}

class _HolidaysWidgetState extends State<HolidaysWidget> {
  List holidays = [];

  bool processing = true;

  var selectedCountry;

  Future getHolidays(id) async {
    Future getDays() async {
      String theAPI = '';
      String Year = '2021';
      String Country = 'ID';

      var url =
          Uri.https('holidayapi.com', 'v1/holidays' + Country + Year + theAPI, {
        'key': '2e4e691a-0d22-40c0-8394-65499f14e323',
      });

      var response = await http.get(url);
      print(response.body);
      var result = json.decode(response.body);
      var list = result['data'] as Map<String, dynamic>;

      return result;
    }

    String text = '';
    var selectedDay = 0;

    @override
    Widget build(BuildContext context) {
      return Scaffold(
          body: FutureBuilder(
              future: getHolidays(id),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data as Map<String, dynamic>;
                  var holidays = data['holidays'] as List<dynamic>;
                  //ListView(children: [
                  // //processing ? CircularProgressIndicator() : Container(),
                  // Visibility(
                  //   visible: processing,
                  //   child: CircularProgressIndicator(),
                  // ),
                  // DropdownButton(
                  //   value: selectedHoliday,
                  //   items: holidays.map((country) {
                  //     return DropdownMenuItem(value: country, child: Text(country));
                  //   }).toList(),
                  //   onChanged: (value) {
                  //     selectedHoliday = value;
                  //     setState(() {});
                  //     Text(selectedHoliday ?? '');
                  //   },
                  // ),
                  // //processing ? CircularProgressIndicator() : Container(),
                  // Visibility(
                  //   visible: processing,
                  //   child: CircularProgressIndicator(),
                  // ),

                  // FutureBuilder(
                  //     future: getHolidays(id),
                  //     builder: (context, snapshot) {
                  //       if (snapshot.hasData) {
                  //         var holidays = snapshot.data as Map<String, dynamic>;
                  //         //var days = days['vote_average'];

                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: holidays.length,
                  itemBuilder: (context, index) {
                    var theHolidays = holidays[index] as Map<String, dynamic>;

                    //int no = index + 1;

                    return Column(
                      children: [
                        Text(
                          'Name:  ' + theHolidays['name'],
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'Date:  ' + theHolidays['date'],
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        // Text(
                        //   'Week Day:  ' + theHolidays['weekday'] + theHolidays['name'],
                        //   style: TextStyle(
                        //     fontSize: 16,
                        //   ),
                        // )
                        const Divider(
                          thickness: 2,
                        )
                      ],
                    );
                  },
                );
              }));
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
