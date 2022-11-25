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
    DateTime.parse('2022-01-01 00:00:00.000Z'): 'New Year\'s Eve',
    DateTime.parse('2022-02-01 00:00:00.000Z'): 'Chinese New Year',
    DateTime.parse('2022-02-28 00:00:00.000Z'): 'Isra Mi\'aj',
    DateTime.parse('2022-03-03 00:00:00.000Z'): 'Bali Hindu New Year',
    DateTime.parse('2022-04-15 00:00:00.000Z'): 'Good Friday',
    DateTime.parse('2022-04-29 00:00:00.000Z'): 'Lebaran Holiday',
    DateTime.parse('2022-05-01 00:00:00.000Z'): 'Labour Day',
    DateTime.parse('2022-05-02 00:00:00.000Z'): 'Hari Raya Idul Fitri',
    DateTime.parse('2022-05-03 00:00:00.000Z'): 'Lebaran Holiday',
    DateTime.parse('2022-05-04 00:00:00.000Z'): 'Lebaran Holiday',
    DateTime.parse('2022-05-05 00:00:00.000Z'): 'Lebaran Holiday',
    DateTime.parse('2022-05-06 00:00:00.000Z'): 'Lebaran Holiday',
    DateTime.parse('2022-05-16 00:00:00.000Z'): 'Waisak Day',
    DateTime.parse('2022-05-26 00:00:00.000Z'): 'Ascension Day Of Jesus Christ',
    DateTime.parse('2022-06-01 00:00:00.000Z'): 'Pancasila Day',
    DateTime.parse('2022-07-10 00:00:00.000Z'): 'Idul Adha',
    DateTime.parse('2022-07-30 00:00:00.000Z'): 'Islamic New Year',
    DateTime.parse('2022-08-17 00:00:00.000Z'): 'Independence Day',
    DateTime.parse('2022-10-08 00:00:00.000Z'): 'Prophet Muhammad\'s Birthday',
    DateTime.parse('2022-12-25 00:00:00.000Z'): 'Christmas Day',
  };

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _holidayDay;

  @override
  void initState() {
    super.initState();
    _sendHolidayListToEvents(holidayList);
    _selectedDay = _focusedDay;
  }

  Map<String, List<EventItem>> mySelectedEvents = {};

  final titleController = TextEditingController();
  final descpController = TextEditingController();

  void _sendHolidayListToEvents(Map<DateTime, String> holidayList) {
    Map<String, List<EventItem>> events = {};
    for (MapEntry holiday in holidayList.entries) {
      final String eventKey = DateFormat('yyyy-MM-dd').format(holiday.key);
      final List<EventItem> eventValue = [
        EventItem(isPublicHoliday: true, titleEvent: '', descp: holiday.value)
      ];
      events[eventKey] = eventValue;
    }
    mySelectedEvents = events;
  }

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
                            isPublicHoliday: false,
                            titleEvent: titleController.text,
                            descp: descpController.text);

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
                            style: const TextStyle(color: Colors.red),
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
                    eventLoader: _listOfDayEventsForEventLoader,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: constructEventList(_selectedDay),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
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
    return _listOfDayEvents(selectedDay).map((myEvent) {
      bool isPublicHoliday = myEvent.isPublicHoliday;

      return Card(
          shadowColor: Colors.black,
          elevation: 0.5,
          child: Container(
            height: isPublicHoliday ? 50 : 80,
            width: 355,
            color: isPublicHoliday ? Colors.red : Colors.grey.shade300,
            child: isPublicHoliday
                ? Center(
                    child: Text(
                      myEvent.descp,
                      style: const TextStyle(
                          color: Colors.white,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                : ListTile(
                    contentPadding: const EdgeInsets.only(top: 5, left: 10),
                    title: Row(children: [
                      Text(
                        myEvent.titleEvent,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ]),
                    subtitle: Row(children: [
                      Text(myEvent.descp,
                          style: const TextStyle(
                              letterSpacing: 1, color: Colors.black))
                    ]),
                    trailing: SizedBox(
                      width: 80,
                      child: isPublicHoliday
                          ? null
                          : Row(
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
                                          final formattedDay =
                                              DateFormat('yyyy-MM-dd')
                                                  .format(selectedDay);
                                          final events =
                                              mySelectedEvents[formattedDay];
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
          ));
    }).toList();
  }

   List<EventItem> _listOfDayEventsForEventLoader(DateTime dateTime) {
    List<EventItem>? events =
        mySelectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)];
    if (events != null) {
      // final List<EventItem> publicHolidayEventItems =
          // events.where((element) => element.isPublicHoliday).toList();
          final List<EventItem> nonPublicHolidayEventItems =
          events.where((element) => element.isPublicHoliday == false).toList();
          if(nonPublicHolidayEventItems.isNotEmpty){
      return events;
      } else {
        return [];
      }
    } else {
      return [];
    }
  }

  List<EventItem> _listOfDayEvents(DateTime dateTime) {
    List<EventItem>? events =
        mySelectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)];
    if (events != null) {
     
      return events;
    } else {
      return [];
    }
  }
}

class EventItem {
  String titleEvent;
  String descp;
  bool isPublicHoliday;
  EventItem(
      {required this.isPublicHoliday,
      required this.titleEvent,
      required this.descp});
}
