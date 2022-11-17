import 'dart:io';
import 'catboys/catboys_page.dart';
import 'package:flutter/material.dart';
import 'calendar/calendar_page.dart';
import 'covid/covid_page.dart';
import 'movies/movies_page.dart';
import 'login/login_page.dart';
import 'package:my_fluttercourse_p2/home_page.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'misc/misc_pages.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  if (kDebugMode) {
    HttpOverrides.global = MyHttpOverrides();
  }

  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  initializeDateFormatting().then((_) => runApp(MaterialApp(routes: {
        'page_home': (context) => const HomePage(),
        'page_register': (context) => const Register(),
        //'page_login': (context) => const LoginWidget(),
        'page_dynamic_view': (context) => DynamicListView(),
        'page_map': (context) => const MapPage(),
        'page_covid': (context) => const DataCovid(),
        'page_covid_update': (context) => const CovidUpdate(),
        'page_university': (context) => const ListUniversity(),
        'page_catboys': (context) => const Catboys(),
        'page_movies': (context) => const Movies(),
        'page_detail': (context) => MovieDetail(),
        'page_result': (context) => const Result(),
        'page_catboy_full_screen': (context) => CatboyFullScreen(),
        // 'page_holiday': (context) => const HolidaysWidget(),
        'page_calendar': (context) => const CalendarTable(),
      }, home: const HomePage()
          // LoginWidget(),
          )));
}

class FlutterDemo extends StatelessWidget {
  const FlutterDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('id', 'ID' ),
        Locale('en', 'ID'),
        ],
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

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
