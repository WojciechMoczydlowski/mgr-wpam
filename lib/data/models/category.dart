class Category {
  String id;
  String name;
  String color;

  Category(
      {required this.id, required, required this.name, required this.color});

  Map toJson() => {'id': id, 'name': name, 'color': color};
}
