import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(const CalendarTable());
}

class CalendarTable extends StatefulWidget {
  const CalendarTable({Key? key}) : super(key: key);

  @override
  State<CalendarTable> createState() => _CalendarTableState();
}

class _CalendarTableState extends State<CalendarTable> {
  CalendarFormat _calendarFormat = CalendarFormat.month;

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  List _listOfDayEvents(DateTime dateTime) {
    if (mySelectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)] != null) {
      return mySelectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)]!;
    } else {
      return [];
    }
  }

  Map<String, List> mySelectedEvents = {};
  final titleController = TextEditingController();
  final descpController = TextEditingController();

  _showAddEventDialog() async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text(
                'Add New Event',
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
                      labelText: 'Title',
                    ),
                  ),
                  TextField(
                    controller: descpController,
                    textCapitalization: TextCapitalization.words,
                    decoration: const InputDecoration(labelText: 'Description'),
                  ),
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel')),
                TextButton(
                    child: const Text('Add Event'),
                    onPressed: () {
                      if (titleController.text.isEmpty &&
                          descpController.text.isEmpty) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Requiered title and description'),
                          duration: Duration(seconds: 2),
                        ));
                        return;
                      } else {
                        print(titleController.text);
                        print(descpController.text);

                        if (mySelectedEvents[DateFormat('yyyy-MM-dd')
                                .format(_selectedDay!)] !=
                            null) {
                          mySelectedEvents[DateFormat('yyyy-MM-dd')
                                  .format(_selectedDay!)]
                              ?.add({
                            'eventTitle': titleController.text,
                            'eventDescp': descpController.text,
                          });
                        } else {
                          mySelectedEvents[DateFormat('yyyy-MM-dd')
                              .format(_selectedDay!)] = [
                            {
                              'eventTitle': titleController.text,
                              'eventDescp': descpController.text
                            }
                          ];
                        }

                        print(
                            'New event for backend developer ${json.encode(mySelectedEvents)}');
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
    // CalendarFormat format = CalendarFormat.month;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            TableCalendar(
              calendarBuilders: CalendarBuilders(dowBuilder: (context, day) {
                if (day.weekday == DateTime.sunday) {
                  final text = DateFormat.E().format(day);
      
                  return Center(
                      child: Text(
                    text,
                    style: TextStyle(color: Colors.red),
                  ));
                }
              }, weekNumberBuilder: (context, endWeek) {
                if (endWeek == 1) {
                  final textWeek = DateFormat.E(endWeek).toString();
              
                return Center(
                  child: Text(textWeek, style: TextStyle(color: Colors.red),),
                );
        }}),
              focusedDay: _focusedDay,
              firstDay: DateTime(2022),
              lastDay: DateTime(2050),
              calendarFormat: _calendarFormat,
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              rowHeight: 60,
              daysOfWeekHeight: 60,
              daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: TextStyle(fontWeight: FontWeight.bold),
                  weekendStyle: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              headerStyle: HeaderStyle(
                  formatButtonVisible: true,
                  titleCentered: true,
                  formatButtonShowsNext: true,
                  formatButtonDecoration: BoxDecoration(
                      color: Colors.blue.shade200,
                      borderRadius: BorderRadius.circular(20.0)),
                  formatButtonTextStyle: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  titleTextStyle:
                      const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  headerPadding:
                      const EdgeInsets.symmetric(horizontal: 1.0, vertical: 10)),
              startingDayOfWeek: StartingDayOfWeek.sunday,
              daysOfWeekVisible: true,
              calendarStyle: CalendarStyle(
                isTodayHighlighted: true,
                // weekendTextStyle: TextStyle(color: Colors.black),
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
          
            ..._listOfDayEvents(_selectedDay!).map(
              (myEvents) => ListTile(
                leading: Icon(
                  Icons.done,
                  color: Colors.teal,
                ),
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Event Title:   ${myEvents['eventTitle']}'),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Description:    ${myEvents['eventDescp']}'),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddEventDialog(),
        label: const Text('Add Event'),
      ),
    );
  }
}
