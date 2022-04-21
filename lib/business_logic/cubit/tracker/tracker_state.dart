part of 'tracker_cubit.dart';

@immutable
abstract class TrackerState {}

class TrackerInitial extends TrackerState {}

class TrackerLoaded extends TrackerState {
  final List<TrackingItem> trackingItems;

  TrackerLoaded(this.trackingItems);
}
