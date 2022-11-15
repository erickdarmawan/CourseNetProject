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
      body: GestureDetector(
        onScaleStart: (details) {
          _initialScale = _scaleFactor;
          setState(() {});
        },
        onScaleUpdate: (details) {
          _scaleFactor = _previousScale * details.scale;
          setState(() {});
        },
        onScaleEnd: (details) {
          _previousScale = 1.0;
          setState(() {});
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              constraints:
                  BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
              child: Transform(
                alignment: FractionalOffset.center,
                transform: Matrix4.diagonal3(
                    Vector3(_initialScale, _initialScale, _initialScale)),
                child: CachedNetworkImage(
                  imageUrl: selectedCatBoy.toString(),
                ),
              ),
            ),
          ),
          onPanStart: (details) {},
          onPanUpdate: (details) {},
        ),
      ),
    );
  }
}
