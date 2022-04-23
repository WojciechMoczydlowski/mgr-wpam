import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wpam_app/business_logic/cubit/tracker/tracker_cubit.dart';
import 'package:wpam_app/data/models/tracking_item.dart';
import 'package:wpam_app/presentation/widgets/charts/tracking_pie_chart_widget.dart';
import 'package:wpam_app/utils/get_color_from_hex.dart';

import '../widgets/layout/navigation_drawer_widget.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TrackerCubit>(context).fetchTrackingItems();

    return Scaffold(
      appBar: AppBar(title: const Text("Statystyki")),
      drawer: const NavigationDrawerWidget(),
      body: BlocBuilder<TrackerCubit, TrackerState>(
        builder: (blocContext, state) {
          if (state is! TrackerLoaded) {
            return const Center(child: CircularProgressIndicator());
          }

          final pieChartData = mkChartData(state.trackingItems);

          return TrackingPieChartWidget(
            data: pieChartData,
          );
        },
      ),
    );
  }
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
        getColorFromHex(trackingItem.color)));

    return pieChartData;
  }

  for (int i = 0; i < trackingItems.length - 1; i++) {
    DateTime firstDate = DateTime.parse(trackingItems[i].date);
    DateTime secondDate = DateTime.parse(trackingItems[i + 1].date);

    final difference = secondDate.difference(firstDate).inMinutes;
    final trackingItem = trackingItems[i];

    pieChartData.add(PieChartItem(
        trackingItem.categoryId,
        trackingItem.categoryName,
        difference,
        getColorFromHex(trackingItem.color)));
  }

  return pieChartData;
}
