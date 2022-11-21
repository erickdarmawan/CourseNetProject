import 'dart:convert';
import 'package:http/http.dart' as http;

Future getHoliday() async {
  var url = Uri.https('holidayapi.com', 'v1/holidays', {
    'country': 'ID',
    'year': '2021',
    'key': '2e4e691a-0d22-40c0-8394-65499f14e323'
  });
  var response = await http.get(url);

  if (response.statusCode == 200) {
    var result = json.decode(response.body);

    List<Holidays> holidayList = [];
    for (final each in result['holidays']) {
      var weekday = WeekDay(
          each['weekday']['date']['name'], each['weekday']['date']['numeric']);
      final holiday = Holidays(
          each['name'], each['date'], each['public'], each['country'], weekday);
      holidayList.add(holiday);
    }
    return holidayList;
  } else {
    return [];
  }
}

class Holidays {
  String name;
  String date;
  bool public;
  String country;
  WeekDay weekday;

  Holidays(this.name, this.date, this.public, this.country, this.weekday);
}

class WeekDay {
  String name;
  String numeric;

  WeekDay(this.name, this.numeric);
}

// class Holiday extends StatefulWidget {
//   const Holiday({Key? key}) : super(key: key);

//   @override
//   State<Holiday> createState() => _HolidayState();
// }

// class _HolidayState extends State<Holiday> {
//   List holidays = [];

//   bool processing = true;

//   var selectedCountry;

//   Future getHolidays(id) async {
//     Future getDays() async {
//       String theAPI = '';
//       String Year = '2021';
//       String Country = 'ID';

//       var url =
//           Uri.https('holidayapi.com', 'v1/holidays' + Country + Year + theAPI, {
//         'key': '2e4e691a-0d22-40c0-8394-65499f14e323',
//       });

//       var response = await http.get(url);
//       print(response.body);
//       var result = json.decode(response.body);
//       var list = result['data'] as Map<String, dynamic>;

//       return result;
//     }

//     String text = '';
//     var selectedDay = 0;

//     @override
//     Widget build(BuildContext context) {
//       return Scaffold(
//           body: FutureBuilder(
//               future: getHolidays(id),
//               builder: (context, snapshot) {
//                 if (snapshot.hasData) {
//                   var data = snapshot.data as Map<String, dynamic>;
//                   var holidays = data['holidays'] as List<dynamic>;

//                 }
//                 return ListView.builder(
//                   shrinkWrap: true,
//                   physics: const ScrollPhysics(),
//                   itemCount: holidays.length,
//                   itemBuilder: (context, index) {
//                     var theHolidays = holidays[index] as Map<String, dynamic>;

//                     return Column(
//                       children: [
//                         Text(
//                           'Name:  ' + theHolidays['name'],
//                           style: const TextStyle(
//                             fontSize: 16,
//                           ),
//                         ),
//                         Text(
//                           'Date:  ' + theHolidays['date'],
//                           style: const TextStyle(
//                             fontSize: 16,
//                           ),
//                         ),
//                         const Divider(
//                           thickness: 2,
//                         )
//                       ],
//                     );
//                   },
//                 );
//               }));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
// }
