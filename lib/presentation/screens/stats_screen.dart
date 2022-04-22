import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wpam_app/business_logic/cubit/tracker/tracker_cubit.dart';
import 'package:wpam_app/presentation/widgets/charts/tracking_pie_chart_widget.dart';

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

          return const TrackingPieChartWidget();
        },
      ),
    );
  }
}
