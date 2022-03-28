import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  final String id;
  final String name;
  final String color;

  const CategoryWidget(
      {Key? key, required this.id, required this.name, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(int.parse(color.replaceAll('#', '0xff'))),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [Text(name)],
      ),
    );
  }
}
