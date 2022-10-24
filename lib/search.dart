import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget implements PreferredSizeWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(50);
}

class _SearchWidgetState extends State<SearchWidget> {
  var iconSearch = Icons.search;
  Widget titleWidget = const Text(
    "List Movie",
  );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: titleWidget,
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: GestureDetector(
              onTap: () {
                if (iconSearch == Icons.search) {
                  iconSearch = Icons.cancel;
                  titleWidget = ListTile(
                    leading: const Icon(Icons.search),
                    title: TextFormField(
                      onFieldSubmitted: (value) {
                        Navigator.pushNamed(context, "page_result",
                            arguments: value);
                      },
                      decoration: InputDecoration(
                        hintText: "Search movie...",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  );
                } else {
                  iconSearch = Icons.search;
                  titleWidget = const Text("List Movie");
                }
                setState(() {});
              },
              child: Icon(iconSearch)),
        ),
      ],
    );
  }
}
