import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wpam_app/business_logic/cubit/add_category/add_category_cubit.dart';
import 'package:wpam_app/presentation/widgets/category/add_category_form.dart';
import 'package:wpam_app/presentation/widgets/layout/bottom_navigation_widget.dart';

class AddCategoryScreen extends StatelessWidget {
  const AddCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Dodaj kategorię")),
        bottomNavigationBar: const BottomNavigationWidget(),
        body: BlocListener<AddCategoryCubit, AddCategoryState>(
          listener: (ctx, state) {
            if (state is CategoryAdded) {
              Navigator.pop(context);
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: const AddCategoryForm(),
          ),
        ));
  }
}
