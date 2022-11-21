import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'calendar_page.dart';
import 'package:collection/collection.dart';

void main() {
  const dateTimeString = '2020-07-17T03:18:31.177769-04:00';
  final dateTime = DateTime.parse(dateTimeString);

  final format = DateFormat('HH:mm a');

  runApp(const CalendarTable());
}

class CalendarTable extends StatefulWidget {
  const CalendarTable({Key? key}) : super(key: key);

  @override
  State<CalendarTable> createState() => _CalendarTableState();
}

class _CalendarTableState extends State<CalendarTable> {
  CalendarFormat _calendarFormat = CalendarFormat.month;

// TODO: sementara aja, bakal di replace sama holidayApi
  Map<DateTime, String> holidayList = {
    DateTime.parse('2022-01-01'): 'New Year\'s Eve',
    DateTime.parse('2022-02-01'): 'Chinese New Year',
    DateTime.parse('2022-02-28'): 'Isra Mi\'aj',
    DateTime.parse('2022-03-03'): 'Bali Hindu New Year',
    DateTime.parse('2022-04-15'): 'Good Friday',
    DateTime.parse('2022-04-29'): 'Lebaran Holiday',
    DateTime.parse('2022-05-01'): 'Labour Day',
    DateTime.parse('2022-05-02'): 'Hari Raya Idul Fitri',
    DateTime.parse('2022-05-03'): 'Lebaran Holiday',
    DateTime.parse('2022-05-04'): 'Lebaran Holiday',
    DateTime.parse('2022-05-05'): 'Lebaran Holiday',
    DateTime.parse('2022-05-06'): 'Lebaran Holiday',
    DateTime.parse('2022-05-16'): 'Waisak Day',
    DateTime.parse('2022-05-26'): 'Ascension Day Of Jesus Christ',
    DateTime.parse('2022-06-01'): 'Pancasila Day',
    DateTime.parse('2022-07-10'): 'Idul Adha',
    DateTime.parse('2022-07-30'): 'Islamic New Year',
    DateTime.parse('2022-08-17'): 'Independence Day',
    DateTime.parse('2022-10-08'): 'Prophet Muhammad\'s Birthday',
    DateTime.parse('2022-12-25'): 'Christman Day',
  };

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    // convertHolidayListToSelectedEvent(holidayList);
  }

  // void convertHolidayListToSelectedEvent (Map<DateTime, String>holidayList){
  //   mySelectedEvents = holidayList.map((key, value) {
  //           print(key);
  //     return "bla" : [EventItem("teswt", "ts")];
  //     //TODO
  //   },);
  //   //TODO
  // }
  Map<String, List<EventItem>> mySelectedEvents = {
    '2022-01-01': [EventItem('', 'Independence Day')],
    '2022-02-01': [EventItem('', 'Chinese New Year')],
    '2022-2-28': [EventItem('', 'Isra Mir\'aj')],
    '2022-3-3': [EventItem('', 'Bali Hindu New Year')],
    '2022-4-15': [EventItem('', 'Good Friday')],
    '2022-4-29': [EventItem('', 'Lebaran Holiday')],
    '2022-05-01': [EventItem('', 'Labour Day')],
    '2022-05-02': [EventItem('', 'Hari Raya Idul Fitri')],
    '2022-05-03': [EventItem('', 'Lebaran Holiday')],
    '2022-05-04': [EventItem('', 'Lebaran Holiday')],
    '2022-05-05': [EventItem('', 'Lebaran Holiday')],
    '2022-05-06': [EventItem('', 'Lebaran Holiday')],
    '2022-05-16': [EventItem('', 'Waisak Day')],
    '2022-05-26': [EventItem('', 'Ascension Day of Jesus Christ')],
    '2022-06-01': [EventItem('', 'Pancasila Day')],
    '2022-07-10': [EventItem('', 'Idul Adha')],
    '2022-07-17': [EventItem('', 'Independence Day')],
    '2022-10-08': [EventItem('', 'Prophet Muhammad\'s Birthday')],
    '2022-12-25': [EventItem('', 'Christmas Day')],
    
  };
  final titleController = TextEditingController();
  final descpController = TextEditingController();

  Future _showAddEventDialog(EventItem? selectedEvent) async {
    final heading = selectedEvent != null ? 'Edit Event' : 'Add Event';
    titleController.text =
        selectedEvent != null ? selectedEvent.titleEvent : '';
    descpController.text = selectedEvent != null ? selectedEvent.descp : '';
    final actionDialog = selectedEvent != null ? 'Save Event' : 'Add Event';

    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                heading,
                textAlign: TextAlign.center,
              ),
              content: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        labelText: "Title",
                      ),
                    ),
                    TextField(
                      controller: descpController,
                      textCapitalization: TextCapitalization.words,
                      decoration:
                          const InputDecoration(labelText: 'Description'),
                    )
                  ]),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel')),
                TextButton(
                    child: Text(actionDialog),
                    onPressed: () {
                      if (titleController.text.isEmpty &&
                          descpController.text.isEmpty) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Requiered title and description'),
                          duration: Duration(seconds: 5),
                        ));
                        return;
                      } else {
                        final key =
                            DateFormat('yyyy-MM-dd').format((_selectedDay!));

                        final newValue = EventItem(
                            titleController.text, descpController.text);

                        final int? indexOfExistingEvent = mySelectedEvents[key]
                            ?.indexWhere((element) => element == EventItem);
                        setState(() {
                          if (indexOfExistingEvent != null &&
                              indexOfExistingEvent != -1) {
                            mySelectedEvents[key]?[indexOfExistingEvent] =
                                newValue;
                          } else if (mySelectedEvents[key] != null) {
                            mySelectedEvents[key]?.add(newValue);
                          } else {
                            mySelectedEvents[key] = [newValue];
                          }
                        });
                        titleController.clear();
                        descpController.clear();
                        Navigator.pop(context);
                        return;
                      }
                    }),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getHoliday(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return SafeArea(
              child: Column(
                children: [
                  TableCalendar(
                    locale: 'id_ID',
                    holidayPredicate: (DateTime dateTime) {
                      DateTime? holidayDate = holidayList.keys.firstWhereOrNull(
                          (element) =>
                              element.day == dateTime.day &&
                              element.month == dateTime.month &&
                              element.year == dateTime.year);

                      if (holidayDate != null) {
                        return true;
                      } else {
                        return false;
                      }
                    },
                    calendarBuilders: CalendarBuilders(
                      holidayBuilder: (context, date, holiday) {
                        return Center(
                          child: Text(
                            date.day.toString(),
                            style: TextStyle(color: Colors.red),
                          ),
                        );
                      },
                    ),
                    focusedDay: _focusedDay,
                    firstDay: DateTime(2022),
                    lastDay: DateTime(2050),
                    calendarFormat: _calendarFormat,
                    weekendDays: const [7],
                    onFormatChanged: (format) {
                      if (_calendarFormat != format) {
                        setState(() {
                          _calendarFormat = format;
                        });
                      }
                    },
                    rowHeight: 60,
                    daysOfWeekHeight: 60,
                    daysOfWeekStyle: const DaysOfWeekStyle(
                        weekdayStyle: TextStyle(fontWeight: FontWeight.bold),
                        weekendStyle: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold)),
                    headerStyle: HeaderStyle(
                        formatButtonVisible: true,
                        titleCentered: true,
                        formatButtonShowsNext: true,
                        formatButtonDecoration: BoxDecoration(
                            color: Colors.blue.shade200,
                            borderRadius: BorderRadius.circular(20.0)),
                        formatButtonTextStyle: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        titleTextStyle: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                        headerPadding: const EdgeInsets.symmetric(
                            horizontal: 1.0, vertical: 10)),
                    startingDayOfWeek: StartingDayOfWeek.sunday,
                    daysOfWeekVisible: true,
                    calendarStyle: CalendarStyle(
                      isTodayHighlighted: true,
                      weekendTextStyle: const TextStyle(color: Colors.red),
                      selectedTextStyle: const TextStyle(color: Colors.white),
                      todayDecoration: BoxDecoration(
                          color: Colors.purpleAccent,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10.0)),
                      selectedDecoration: BoxDecoration(
                          color: Colors.blue.shade200,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10.0)),
                      weekendDecoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10)),
                      defaultDecoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10)),
                      tableBorder: TableBorder(
                          top: BorderSide(
                            width: 1,
                            color: Colors.grey.shade300,
                          ),
                          bottom: BorderSide(
                            width: 1,
                            color: Colors.grey.shade300,
                          ),
                          verticalInside: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1,
                          )),
                    ),
                    onDaySelected: (selectedDay, focusedDay) {
                      if (!isSameDay(_selectedDay, selectedDay)) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                        });
                      }
                    },
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    onPageChanged: (focusedDay) {
                      _focusedDay = focusedDay;
                    },
                    eventLoader: _listOfDayEvents,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child:
                            Column(children: constructEventList(_selectedDay))),
                  ),
                ],
              ),
            );
          }
          return Text('');
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _showAddEventDialog(null),
          label: const Text(
            'Add Event',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
    );
  }

  List<Card> constructEventList(DateTime? selectedDay) {
    if (selectedDay == null) {
      return [];
    }
    return _listOfDayEvents(selectedDay)
        .map((myEvent) => Card(
            shadowColor: Colors.black,
            elevation: 0.5,
            child: Container(
              height: 80,
              width: 355,
              color: Colors.grey.shade300,
              child: ListTile(
                contentPadding: const EdgeInsets.only(top: 5, left: 10),
                title: Row(children: [
                  Text(
                    myEvent.titleEvent,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        decoration: TextDecoration.underline),
                  ),
                ]),
                subtitle: Row(children: [
                  Text(myEvent.descp,
                      style: const TextStyle(
                          letterSpacing: 1, color: Colors.black))
                ]),
                trailing: SizedBox(
                  width: 80,
                  child: Row(
                    children: [
                      Expanded(
                          child: IconButton(
                              onPressed: () {
                                _showAddEventDialog(myEvent);
                              },
                              icon: const Icon(Icons.edit))),
                      Expanded(
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                final formattedDay = DateFormat('yyyy-MM-dd')
                                    .format(selectedDay);
                                final events = mySelectedEvents[formattedDay];
                                if (events != null) {
                                  events.remove(myEvent);
                                }
                              });
                            },
                            icon: const Icon(Icons.delete)),
                      ),
                    ],
                  ),
                ),
              ),
            )))
        .toList();
  }

  List<EventItem> _listOfDayEvents(DateTime dateTime) {
    if (mySelectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)] != null) {
      return mySelectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)]!;
    } else {
      return [];
    }
  }
}

// List<Holidays> nationalHoliday(DateTime holiday) {
//   List<Text> filteredTextHoliday = [];
//   var holidayNational = DateTime.parse()

// }

Text holidayRed(WeekDay date) {
  return Text(
    date != null ? date.toString() : '',
    style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
  );
}

// static DateTime parse(String formattedString) {
//   var re = _parseFormat;
//   Match? match = re.firstMatch(formattedString);
//   if (match != null) {
//     int parseIntOrZero(String? matched) {
//       if (matched == null) return 0;
//       return int.parse(matched);
//     }
// int getDateHoliday(String dateHoliday){
//   // var dateHoliday =
//   if (dateHoliday == null) return 0;
//   int length = dateHoliday.length;
//   assert(length >= 1);
//       int result = 0;
//       for (int i = 0; i < 6; i++) {
//         result *= 10;
//         if (i < dateHoliday.length) {
//           result += dateHoliday.codeUnitAt(i) ^ 0x30;
//         }
//       }
//       return result;
//     }
// }}

// int getHashCode(DateTime key){
//   return key.day * 1000000 + key.month * 1000002 * key.year;
// }
// groupHolidays(List<AppEvent> events) {
//     groupHolidays() = LinkedHashMap(equals: isSameDay, hashCode: getHashCode);
//     events.forEach((event) {
//       DateTime date = DateTime.utc(
//           event.startDate.year, event.startDate.month, event.startDate.day, 12);
//       if (groupHolidays[date] == null) groupHolidays[date] = [];
//       groupHolidays[date].add(event);
//     });
//   }
// LinkedHashMap<DateTime, List<Holidays>>? _publicHoliday;
// _publicHoliday = LinkedHashMap(equals: isSameDay, hashCode: getHashCode);

class EventItem {
  String titleEvent;
  String descp;
  EventItem(this.titleEvent, this.descp);
}
