import 'package:flutter/material.dart';

class Search extends StatefulWidget implements PreferredSizeWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();

  @override
  Size get preferredSize => const Size.fromHeight(50);
}

class _SearchState extends State<Search> {
  var iconSearch = Icons.search;
  Widget titleWidget = Text(
    "List Movie",
    );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: titleWidget,
      centerTitle: true,
      actions: [
        GestureDetector(
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
      ],
    );
  }
}
