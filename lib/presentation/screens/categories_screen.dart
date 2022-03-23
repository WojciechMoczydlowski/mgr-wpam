import 'package:flutter/material.dart';
import 'package:wpam_app/presentation/widgets/navigation_drawer_widget.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kategorie")),
      drawer: const NavigationDrawerWidget(),
    );
  }
}
