class TrackingItem {
  String id;
  String categoryId;
  String date;

  TrackingItem(
      {required this.id, required this.categoryId, required this.date});

  Map toJson() => {'id': id, 'categoryId': categoryId, 'date': date};
}
