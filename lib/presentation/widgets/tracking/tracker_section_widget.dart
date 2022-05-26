import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wpam_app/business_logic/cubit/category/category_cubit.dart';
import 'package:wpam_app/presentation/widgets/tracking/tracker_tile_widget.dart';

class TrackerSectionWidget extends StatelessWidget {
  const TrackerSectionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CategoryCubit>(context).fetchCategories();

    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (cubitContext, categoryCubitState) {
        if (categoryCubitState is! CategoryLoaded) {
          return const Center(child: CircularProgressIndicator());
        }

        return Expanded(
            child: ListView(
          children: [
            ...ListTile.divideTiles(
                context: context,
                tiles: categoryCubitState.categories
                    .where((category) => !category.hidden)
                    .map((category) {
                  return TrackerTileWidget(
                    categoryId: category.id,
                    name: category.name,
                    color: category.color,
                  );
                })).toList()
          ],
        ));
      },
    );
  }
}
