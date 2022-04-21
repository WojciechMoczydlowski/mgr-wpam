import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wpam_app/business_logic/cubit/category/category_cubit.dart';
import 'package:wpam_app/presentation/router/routes.dart';
import 'package:wpam_app/presentation/widgets/layout/navigation_drawer_widget.dart';

import '../widgets/category/category_tile_widget.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CategoryCubit>(context).fetchCategories();

    return Scaffold(
      appBar: AppBar(title: const Text("Kategorie")),
      drawer: const NavigationDrawerWidget(),
      body: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (blocContext, state) {
          if (state is! CategoryLoaded) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Column(
              children: state.categories.map((category) {
                return CategoryTileWidget(
                    id: category.id,
                    name: category.name,
                    color: category.color);
              }).toList(),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(addCategoryRoute);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
