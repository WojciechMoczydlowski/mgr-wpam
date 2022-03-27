class Category {
  String id;
  String name;
  String color;

  Category.fromJson(Map json)
      : id = json["id"],
        name = json["name"],
        color = json["color"];
}
