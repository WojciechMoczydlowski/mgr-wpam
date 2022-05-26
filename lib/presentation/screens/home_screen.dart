import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wpam_app/business_logic/cubit/category/category_cubit.dart';
import 'package:wpam_app/business_logic/cubit/tracker/tracker_cubit.dart';
import 'package:wpam_app/presentation/widgets/layout/bottom_navigation_widget.dart';
import 'package:wpam_app/presentation/widgets/tracking/tracker_tile_widget.dart';

import '../widgets/tracking/tracker_section_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TrackerCubit>(context).fetchTrackingItems();
    BlocProvider.of<CategoryCubit>(context).fetchCategories();

    return Scaffold(
        appBar: AppBar(
            title: const Text("Mierz"),
            centerTitle: true,
            automaticallyImplyLeading: false),
        bottomNavigationBar: const BottomNavigationWidget(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  "Aktualnie mierzony",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                )),
            BlocBuilder<TrackerCubit, TrackerState>(
              builder: (trackerContext, trackerState) {
                if (trackerState is! TrackerLoaded) {
                  return const Center(child: CircularProgressIndicator());
                }

                final firstItem = trackerState.trackingItems.last;

                return TrackerTileWidget(
                  categoryId: firstItem.categoryId,
                  name: firstItem.categoryName,
                  color: firstItem.color,
                );
              },
            ),
            const Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  "Kategorie do wybrania",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                )),
            const TrackerSectionWidget()
          ],
        ));
  }
}
