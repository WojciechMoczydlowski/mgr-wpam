import 'package:uuid/uuid.dart';
import 'package:wpam_app/data/data_providers/tracker_api.dart';
import 'package:wpam_app/data/models/tracking_item.dart';

class TrackerRepository {
  final TrackerAPI api;

  TrackerRepository(this.api);

  Future<List<TrackingItem>> fetchTrackingItems() async {
    try {
      final rawTrackingItems = await api.featchRawTrackingItems();

      List<TrackingItem> trackingItems =
          List<TrackingItem>.from(rawTrackingItems['data'].map((value) {
        return TrackingItem(
            id: value['id'],
            categoryId: value['categoryId'],
            categoryName: value['categoryName'],
            date: DateTime.parse(value['date'].toDate().toString()),
            color: value['color']);
      }));

      return trackingItems;
    } catch (e) {
      return [];
    }
  }

  Future<TrackingItem> addTrackingItem(
      String categoryId, String categoryName, String color) async {
    try {
      const uuid = Uuid();
      final currentDate = DateTime.now();

      List<TrackingItem> trackingItems = await fetchTrackingItems();
      TrackingItem newTrackingItem = TrackingItem(
        id: uuid.v1(),
        categoryId: categoryId,
        categoryName: categoryName,
        color: color,
        date: currentDate,
      );

      trackingItems.add(newTrackingItem);

      Map<String, Object?> trackingItemsMap = Map<String, Object?>.from(
          {"data": trackingItems.map((c) => c.toJson()).toList()});

      await api.saveTrackingItems(trackingItemsMap);
      return newTrackingItem;
    } catch (e) {
      rethrow;
    }
  }
}
