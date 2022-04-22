class TrackingItem {
  String id;
  String categoryName;
  String categoryId;
  String date;

  TrackingItem(
      {required this.id,
      required this.categoryId,
      required this.categoryName,
      required this.date});

  Map toJson() => {
        'id': id,
        'categoryId': categoryId,
        'categoryName': categoryName,
        'date': date
      };
}
