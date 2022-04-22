import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wpam_app/business_logic/cubit/tracker/tracker_cubit.dart';
import 'package:wpam_app/data/repositories/tracker_repository.dart';

part 'add_tracking_item_state.dart';

class AddTrackingItemCubit extends Cubit<AddTrackingItemState> {
  final TrackerRepository trackerRepository;
  final TrackerCubit trackerCubit;

  AddTrackingItemCubit(this.trackerRepository, this.trackerCubit)
      : super(AddTrackingItemInitial());

  addTrackingItem(String categoryId, String categoryName) {
    emit(AddTrackingItemLoading());

    trackerRepository
        .addTrackingItem(categoryId, categoryName)
        .then((trackingItem) {
      trackerCubit.addTrackingItem(trackingItem);
      emit(TrackingItemAdded());
    });
  }
}
