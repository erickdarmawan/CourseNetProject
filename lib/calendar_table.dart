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
              calendarBuilders: CalendarBuilders(dowBuilder: (context, day) {
                if (day.weekday == DateTime.sunday) {}
              }),
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
          onPressed: () => _showAddEventDialog(),
          label: const Text(
            'Add Event',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
    );
  }
  

  List<Container> constructEventList(DateTime? selectedDay) {
    if (selectedDay == null) {
      return [];
    }
    return _listOfDayEvents(selectedDay)
        .map((myEvents) => Container(
            height: 95,
            width: 355,
            margin: const EdgeInsets.all(3),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade300,
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.only(top: 5, left: 10),
              title: Row(children: [
                Text(
                  '${myEvents['eventTitle']}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      decoration: TextDecoration.underline),
                ),
              ]),
              subtitle: Row(children: [
                Text('${myEvents['eventDescp']}',
                    style:
                        const TextStyle(letterSpacing: 1, color: Colors.black))
              ]),
              trailing:
                  IconButton(onPressed: () {}, icon: const Icon(Icons.cancel)),
            )))
        .toList();
  }
}
