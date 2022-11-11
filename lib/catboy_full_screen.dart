import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
class CatboyFullScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String? selectedCatBoy =
        ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: GestureDetector(
          child: Container(
            height: MediaQuery.of(context).size.height,
            constraints:
                BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
            child: CachedNetworkImage(
              imageUrl: selectedCatBoy.toString(),
            ),
          ),
          onPanStart: (details) {},
          onPanUpdate: (details) {},
        ),
      ),
    );
  }
}
