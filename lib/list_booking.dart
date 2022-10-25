import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ListBookingWidget());
}

class ListBookingWidget extends StatelessWidget {
  const ListBookingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('booking').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ' + snapshot.toString()),
                );
              } else if (snapshot.hasData) {
                var result = snapshot.data as QuerySnapshot;
                var data = result.docs;
                return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      var booking = data[index].data() as Map<String, dynamic>;
                      return Text(booking['title']);
                    });
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
