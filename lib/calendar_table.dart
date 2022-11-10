import 'package:flutter/material.dart';
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

  Map<String, List<EventItem>> mySelectedEvents = {};
  final titleController = TextEditingController();
  final descpController = TextEditingController();

  Future _showAddEventDialog(EventItem? selectedEvent) async {
    final heading = selectedEvent != null ? 'Edit Event' : 'Add Event';
    titleController.text =
        selectedEvent != null ? selectedEvent.titleEvent : '';
    descpController.text =
        selectedEvent != null ? selectedEvent.descp : '';
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
                        // final newValue = {
                        //   'eventTitle': titleController.text,
                        //   'eventDescp': descpController.text
                        // };
                        final newValue = EventItem(titleController.text, descpController.text);

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
      body: SafeArea(
        child: Column(
          children: [
            TableCalendar(
              calendarBuilders: CalendarBuilders(dowBuilder: (context, day) {}),
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
                  child: Column(children: constructEventList(_selectedDay))),
            ),
          ],
        ),
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

class EventItem {
  String titleEvent;
  String descp;
  EventItem(this.titleEvent, this.descp);
}
