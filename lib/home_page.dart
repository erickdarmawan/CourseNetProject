import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_fluttercourse_p2/carousel.dart';
import 'data/menu.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Menu menu1 = Menu();
    menu1.title = 'Go Ride';
    menu1.icon = Icons.pedal_bike;
    menu1.color = Colors.orange;

    Menu menu2 = Menu();
    menu2.title = 'Go Car';
    menu2.icon = Icons.car_rental;
    menu2.color = Colors.red;

    Menu menu3 = Menu();
    menu3.title = 'Go Send';
    menu3.icon = Icons.pedal_bike;
    menu3.color = Colors.blue;

    Menu menu4 = Menu();
    menu4.title = 'Go Shop';
    menu4.icon = Icons.shopping_bag;
    menu4.color = Colors.yellow;

    Menu menu5 = Menu();
    menu5.title = 'Go Repair';
    menu5.icon = Icons.handyman;
    menu5.color = Colors.purple;

    Menu menu6 = Menu();
    menu6.title = 'Go Send';
    menu6.icon = Icons.send;
    menu6.color = Colors.blueGrey;

    Menu menu7 = Menu();
    menu7.title = 'Go Food';
    menu7.icon = Icons.food_bank;
    menu7.color = Colors.green;

    Menu menu8 = Menu();
    menu8.title = 'Other';
    menu8.icon = Icons.dashboard;
    menu8.color = Colors.black;

    List<Menu> allMenu = [];
    allMenu.add(menu1);
    allMenu.add(menu2);
    allMenu.add(menu3);
    allMenu.add(menu4);
    allMenu.add(menu5);
    allMenu.add(menu6);
    allMenu.add(menu7);
    allMenu.add(menu8);

    return Scaffold(
      backgroundColor: Colors.indigo.shade50,
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        backgroundColor: Colors.indigo.shade400,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const AlertDialog(
                          title: Text('About Us'),
                          content: Text('Created by Me - 2022'),
                        );
                      });
                },
                child: const Icon(Icons.chat_bubble)),
          )
        ],
      ),
      body: ListView(shrinkWrap: true, children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
              shrinkWrap: true,
              itemCount: allMenu.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemBuilder: (context, index) {
                var theMenu = allMenu[index];

                return GridTile(
                    child: Card(
                  shadowColor: Colors.black,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Icon(
                                theMenu.icon,
                                color: theMenu.color,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 1.5),
                          child: Text(
                            theMenu.title,
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ));
              }),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Carousel(),
        ),
      ]),
      drawer: Drawer(
        backgroundColor: Colors.indigo.shade50,
        child: ListView(
          children: [
            DrawerHeader(
                padding: EdgeInsets.zero,
                child: Container(
                  child: SizedBox(
                    height: 3,
                    width: 3,
                    child: Image.asset(
                        'images/pngfind.com-galaga-png-2648894.png'),
                  ),
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                        Colors.blueGrey,
                        Colors.lightBlue,
                        Colors.blue
                      ])),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10),
              child: Row(
                children: const [
                  Icon(Icons.home),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text('Home'),
                  ),
                ],
              ),
            ),
            const Card(
              shadowColor: Colors.blue,
              elevation: 10,
              child: ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                subtitle: Text('This is Home'),
              ),
            ),
            Card(
              shadowColor: Colors.blue,
              elevation: 10,
              child: ListTile(
                leading: const Icon(Icons.chat),
                title: const Text('Chat'),
                onTap: () {
                  Fluttertoast.showToast(
                      msg: "This is Chat",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                },
              ),
            ),
            Card(
              shadowColor: Colors.blue,
              elevation: 10,
              child: ListTile(
                leading: const Icon(Icons.access_alarm_sharp),
                title: const Text('Dynamic List View'),
                subtitle: const Text('This is Dynamic View'),
                onTap: () {
                  Navigator.pushNamed(context, 'page_dynamic_view');
                },
              ),
            ),
            Card(
              shadowColor: Colors.blue,
              elevation: 10,
              child: ListTile(
                leading: const Icon(Icons.file_present),
                title: const Text('Covid-19 result'),
                onTap: () {
                  Navigator.pushNamed(context, 'page_covid');
                },
              ),
            ),
            Card(
              shadowColor: Colors.blue,
              elevation: 10,
              child: ListTile(
                leading: const Icon(Icons.calendar_month_outlined),
                title: const Text('Calendar'),
                onTap: () {
                  Navigator.pushNamed(context, 'page_calendar');
                },
              ),
            ),
            Card(
              shadowColor: Colors.blue,
              elevation: 10,
              child: ListTile(
                leading: const Icon(Icons.catching_pokemon),
                title: const Text('Cat Boys'),
                onTap: () {
                  Navigator.pushNamed(context, 'page_catboys');
                },
              ),
            ),
            Card(
              shadowColor: Colors.blue,
              elevation: 10,
              child: ListTile(
                leading: const Icon(Icons.school_sharp),
                title: const Text('List Of University'),
                onTap: () {
                  Navigator.pushNamed(context, 'page_university');
                },
              ),
            ),
            Card(
              shadowColor: Colors.blue,
              elevation: 10,
              child: ListTile(
                leading: const Icon(Icons.movie),
                title: const Text('Movies'),
                onTap: () {
                  Navigator.pushNamed(context, 'page_movies');
                },
              ),
            ),
            Card(
              shadowColor: Colors.blue,
              elevation: 10,
              child: ListTile(
                leading: const Icon(Icons.map),
                title: const Text('Google Map'),
                onTap: () {
                  Navigator.pushNamed(context, 'page_map');
                },
              ),
            ),
            Card(
              shadowColor: Colors.blue,
              elevation: 10,
              child: ListTile(
                leading: const Icon(Icons.celebration),
                title: const Text('List of Holiday'),
                onTap: () {
                  Navigator.pushNamed(context, 'page_holiday');
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 1.0),
              child: Card(
                shadowColor: Colors.blue,
                elevation: 10,
                child: ListTile(
                  leading: const Icon(Icons.exit_to_app),
                  title: const Text('Log Out'),
                  subtitle: const Text('Going Out'),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, 'page_login');
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.white,
        showSelectedLabels: true,
        selectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        backgroundColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
        ],
      ),
    );
  }
}
