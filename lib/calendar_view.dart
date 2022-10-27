import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CalendarView());
}

class CalendarView extends StatelessWidget {
  const CalendarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CalendarFormat format = CalendarFormat.month;
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
      ),
      body: Center(
        child: TableCalendar(
          focusedDay: DateTime.now(),
          firstDay: DateTime(2022),
          lastDay: DateTime(2050),
          calendarFormat: format,
          startingDayOfWeek: StartingDayOfWeek.sunday,
          onFormatChanged: (CalendarFormat _format) {
            setState() {
              format = _format;
            }
          },
        ),
      ),
    );
  }
}
