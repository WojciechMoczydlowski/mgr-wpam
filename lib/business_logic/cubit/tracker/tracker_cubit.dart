import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wpam_app/data/models/tracking_item.dart';
import 'package:wpam_app/data/repositories/tracker_repository.dart';

part 'tracker_state.dart';

class TrackerCubit extends Cubit<TrackerState> {
  final TrackerRepository trackerRepository;

  TrackerCubit(this.trackerRepository) : super(TrackerInitial());

  void fetchTrackingItems() {
    trackerRepository
        .fetchTrackingItems()
        .then((items) => {emit(TrackerLoaded(items))});
  }

  addTrackingItem(TrackingItem trackingItem) {
    final currentState = state;
    if (currentState is TrackerLoaded) {
      final trackingItems = currentState.trackingItems;

      trackingItems.add(trackingItem);
      emit(TrackerLoaded(trackingItems));
    }
  }
}
