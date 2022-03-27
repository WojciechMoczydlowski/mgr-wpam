import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wpam_app/business_logic/cubit/category_cubit.dart';
import 'package:wpam_app/presentation/widgets/navigation_drawer_widget.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CategoryCubit>(context).fetchCategories();

    return Scaffold(
        appBar: AppBar(title: const Text("Kategorie")),
        drawer: const NavigationDrawerWidget(),
        body: BlocBuilder<CategoryCubit, CategoryState>(
          builder: (context, state) {
            if (state is! CategoryLoaded) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              child: Column(),
            );
          },
        ));
  }
}
