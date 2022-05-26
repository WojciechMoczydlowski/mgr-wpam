class Category {
  String id;
  String name;
  String color;
  bool hidden;

  Category(
      {required this.id,
      required this.name,
      required this.color,
      required this.hidden});

  Map toJson() => {'id': id, 'name': name, 'color': color, 'hidden': hidden};
}
