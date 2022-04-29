import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wpam_app/business_logic/cubit/category/category_cubit.dart';
import 'package:wpam_app/presentation/widgets/layout/bottom_navigation_widget.dart';
import 'package:wpam_app/presentation/widgets/tracking/tracker_tile_widget.dart';

import '../widgets/layout/navigation_drawer_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CategoryCubit>(context).fetchCategories();

    return Scaffold(
      appBar: AppBar(title: const Text("Strona glówna")),
      bottomNavigationBar: const BottomNavigationWidget(),
      drawer: const NavigationDrawerWidget(),
      body: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (blocContext, state) {
          if (state is! CategoryLoaded) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Column(
              children: state.categories
                  .where((category) => !category.hidden)
                  .map((category) {
                return TrackerTileWidget(
                    categoryId: category.id,
                    name: category.name,
                    color: category.color);
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
