import 'package:crowd_sourced_shopping_app/exports.dart';
import 'package:flutter/cupertino.dart';

AppBar buildAppBar(BuildContext context) {
  final icon = CupertinoIcons.moon_stars;

  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: [
      IconButton(
        icon: Icon(icon),
        color: Colors.black,
        onPressed: () {
          ThemeProvider.controllerOf(context).nextTheme();
        },
      ),
    ],
  );
}
