import 'package:flutter/material.dart';
import 'package:my_fluttercourse_p2/calendar_view.dart';
import 'package:my_fluttercourse_p2/data_covid.dart';
import 'package:my_fluttercourse_p2/movies.dart';
import 'package:my_fluttercourse_p2/home.dart';
import 'package:my_fluttercourse_p2/login.dart';

import 'register.dart';
import 'dynamic_list_view.dart';
import 'map.dart';
import 'calendar_view.dart';
import 'covid_update.dart';
import 'list_universty.dart';
import 'catboys.dart';
import 'Page_detail.dart';
import 'result.dart';
import 'holiday.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  runApp(MaterialApp(
    routes: {
      'page_home': (context) => const HomeWidget(),
      'page_register': (context) => const RegisterWidget(),
      //'page_login': (context) => const LoginWidget(),
      'page_dynamic_view': (context) => DynamicListView(),
      'page_map': (context) => const MapWidget(),
      'page_covid': (context) => const CovidWidget(),
      'page_covid_update': (context) => const CovidUpdateWidget(),
      'page_university': (context) => const ListUniversityWidget(),
      'page_catboys': (context) => const CatboysWidget(),
      'page_movies': (context) => const MovieWidget(),
      'page_detail': (context) => PageDetailWidget(),
      'page_result': (context) => const ResultWidget(),
      // 'page_holiday': (context) => const HolidaysWidget(),
      'page_calendar':(context) => const CalendarView(),
    },
    home: const HomeWidget()
    // LoginWidget(),
  ));
}

class FlutterDemo extends StatelessWidget {
  const FlutterDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: const FlutterHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class FlutterHomePage extends StatefulWidget {
  final String title;

  const FlutterHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<FlutterHomePage> createState() => _FlutterHomePageState();
}

class FlutterWidget extends StatelessWidget {
  const FlutterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text("Flutter AppBar"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        leading: const Icon(Icons.menu),
        titleSpacing: 5,
      ),
      body:
          // Row
          Column(
        children: [
          const Text('Hello Flutter',
              style: TextStyle(
                color: Colors.brown,
                fontSize: 17,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic,
              )),
          const Text(
            'Welcome Flutter',
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.normal),
          ),
          const Text(
            'Copyright 2022',
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.red,
                fontSize: 17,
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.normal),
          ),
          Center(
            child: Padding(
              //padding: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.fromLTRB(5, 5, 1, 5),
              //padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
              //padding: EdgeInsets.only(top: 5, bottom: 8),
              child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Submit 1'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
            child: OutlinedButton(
                style: ButtonStyle(
                    side:
                        MaterialStateProperty.all(const BorderSide(width: 2))),
                onPressed: () {},
                child: const Text('Submit 2')),
          ),
          Padding(

            padding: const EdgeInsets.only(top: 5, bottom: 8),
            child: TextButton(
              onPressed: () {},
              child: const Text('Submit 3'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 8),
            child: IconButton(onPressed: () {}, icon: const Icon(Icons.check)),
          ),
          const Divider(
            color: Colors.red,
            height: 80,
            thickness: 3,
          ),
          TextFormField(),
          Image.asset(
            'images/pngfind.com-galaga-png-2648894.png',
            width: 200,
            height: 200,
            color: Colors.blue,
          ),
        ],
      ),
    ));
  }
}

class _FlutterHomePageState extends State<FlutterHomePage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You Pressed:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), //
    );
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
}
