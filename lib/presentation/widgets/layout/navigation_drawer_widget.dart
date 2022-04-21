import 'package:flutter/material.dart';
import 'package:wpam_app/presentation/router/routes.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.blue,
        child: ListView(
          children: <Widget>[
            buildMenuItem(
                context: context,
                text: "Strona główna",
                icon: Icons.home,
                path: homeRoute),
            buildMenuItem(
                context: context,
                text: "Kategorie",
                icon: Icons.category,
                path: categoriesRoute),
            buildMenuItem(
                context: context,
                text: "Statystyki",
                icon: Icons.stacked_bar_chart_sharp,
                path: statsRoute)
          ],
        ),
      ),
    );
  }
}

Widget buildMenuItem(
    {required BuildContext context,
    required String text,
    required IconData icon,
    required String path}) {
  const color = Colors.white;

  return ListTile(
      onTap: () {
        Navigator.of(context).pushNamed(path);
      },
      leading: Icon(icon, color: color),
      title: Text(text, style: const TextStyle(color: color)));
}
