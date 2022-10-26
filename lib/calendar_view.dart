
import 'package:http/http.dart' as http;
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CalendarViewWidget());
}

class CalendarViewWidget extends StatelessWidget {
  const CalendarViewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
      ),
      // body: Column(children: [
      //   TableCalendar(focusedDay: focusedDay, firstDay: firstDay, lastDay: lastDay)
      // ]),
    );
  }
}
