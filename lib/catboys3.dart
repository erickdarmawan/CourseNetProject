import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
//import 'package:galleryimage/galleryimage.dart';

class CatboysWidget extends StatefulWidget {
  const CatboysWidget({Key? key}) : super(key: key);

  @override
  State<CatboysWidget> createState() => _CatboysWidgetState();
}

class _CatboysWidgetState extends State<CatboysWidget> {
  final List<dynamic> ImageUrl = [
    'https://cdn.catboys.com/images/image_208.jpg',
    "https://cdn.catboys.com/images/image_31.jpg",
    "https://cdn.catboys.com/images/image_2.jpg",
    "https://cdn.catboys.com/images/image_20.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cat Boys'),
        centerTitle: true,
      ),
      body: Column(children: [
        Expanded(
          child:

              PhotoViewGallery.builder(
                  itemCount: ImageUrl.length,
                  builder: (context, index) {
                    return PhotoViewGalleryPageOptions(
                        imageProvider: NetworkImage(ImageUrl[index]),
                        minScale: PhotoViewComputedScale.contained,
                        maxScale: PhotoViewComputedScale.covered * 2);
                  },
                  scrollPhysics: const BouncingScrollPhysics(),
                  backgroundDecoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                  ),
                  loadingBuilder: (context, event) => const Center(
                        child: SizedBox(
                          width: 30.0,
                          height: 30.0,
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.orange,
                          ),
                        ),
                      )),
                      ),
                    ]),
                  );
                }
              }
