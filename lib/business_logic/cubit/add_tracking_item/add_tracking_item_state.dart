part of 'add_tracking_item_cubit.dart';

@immutable
abstract class AddTrackingItemState {}

class AddTrackingItemInitial extends AddTrackingItemState {}

class AddTrackingItemError extends AddTrackingItemState {
  final String error;

  AddTrackingItemError(this.error);
}

class AddTrackingItemLoading extends AddTrackingItemState {}

class TrackingItemAdded extends AddTrackingItemState {}
