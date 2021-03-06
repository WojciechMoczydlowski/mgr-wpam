import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wpam_app/business_logic/cubit/tracker/tracker_cubit.dart';
import 'package:wpam_app/data/models/tracking_item.dart';
import 'package:wpam_app/presentation/widgets/charts/tracking_pie_chart_widget.dart';
import 'package:wpam_app/presentation/widgets/layout/bottom_navigation_widget.dart';
import 'package:wpam_app/presentation/widgets/tracking/tracking_date_picker_widget.dart';
import 'package:wpam_app/utils/get_color_from_hex.dart';
import 'package:wpam_app/utils/is_same_date.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({Key? key}) : super(key: key);

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  DateTime currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TrackerCubit>(context).fetchTrackingItems();

    return Scaffold(
      appBar: AppBar(
          title: const Text("Sprawdzaj"),
          centerTitle: true,
          automaticallyImplyLeading: false),
      bottomNavigationBar: const BottomNavigationWidget(),
      body: BlocBuilder<TrackerCubit, TrackerState>(
        builder: (blocContext, state) {
          if (state is! TrackerLoaded) {
            return const Center(child: CircularProgressIndicator());
          }

          final pieChartData = mkChartData(
              filterTrackingItemsByDate(state.trackingItems, currentDate));

          return Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: TrackingDatePickerWidget(
                    date: currentDate,
                    onChange: (date) => {setState(() => currentDate = date)}),
              ),
              Expanded(
                flex: 9,
                child: TrackingPieChartWidget(
                  data: pieChartData,
                ),
              ),
              const Expanded(
                flex: 1,
                child: Text(
                  "Czas podany jest w minutach",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

List<TrackingItem> filterTrackingItemsByDate(
    List<TrackingItem> trackingItems, DateTime selectedDate) {
  return trackingItems
      .where((item) => isSameDate(item.date, selectedDate))
      .toList();
}

List<PieChartItem> mkChartData(List<TrackingItem> trackingItems) {
  List<PieChartItem> pieChartData = [];

  if (trackingItems.isEmpty) {
    return pieChartData;
  }

  if (trackingItems.length == 1) {
    final trackingItem = trackingItems[0];

    pieChartData.add(PieChartItem(
        trackingItem.categoryId,
        trackingItem.categoryName,
        24 * 60,
        getColorFromHex(trackingItem.color),
        trackingItem.categoryId));

    return pieChartData;
  }

  for (int i = 0; i < trackingItems.length - 1; i++) {
    DateTime firstItem = trackingItems[i].date;
    DateTime secondItem = trackingItems[i + 1].date;

    final difference = secondItem.difference(firstItem).inMinutes;
    final trackingItem = trackingItems[i];

    pieChartData.add(PieChartItem(
        trackingItem.categoryId,
        trackingItem.categoryName,
        difference,
        getColorFromHex(trackingItem.color),
        trackingItem.categoryId));
  }

  return reduceChartData(pieChartData);
}

List<PieChartItem> reduceChartData(List<PieChartItem> data) {
  List<PieChartItem> newData = [];

  for (var item in data) {
    int prevItemIndex =
        newData.indexWhere((newItem) => newItem.categoryId == item.categoryId);
    if (prevItemIndex < 0) {
      newData.add(item);
    } else {
      newData[prevItemIndex].period += item.period;
    }
  }

  return newData;
}
