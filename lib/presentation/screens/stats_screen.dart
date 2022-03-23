import 'package:flutter/material.dart';

import '../widgets/navigation_drawer_widget.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Statystyki")),
      drawer: const NavigationDrawerWidget(),
    );
  }
}
