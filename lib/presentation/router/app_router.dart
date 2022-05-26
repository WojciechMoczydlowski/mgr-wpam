import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wpam_app/business_logic/cubit/add_category/add_category_cubit.dart';
import 'package:wpam_app/business_logic/cubit/add_tracking_item/add_tracking_item_cubit.dart';
import 'package:wpam_app/business_logic/cubit/category/category_cubit.dart';
import 'package:wpam_app/business_logic/cubit/tracker/tracker_cubit.dart';
import 'package:wpam_app/data/data_providers/category_api.dart';
import 'package:wpam_app/data/data_providers/tracker_api.dart';
import 'package:wpam_app/data/repositories/category_repository.dart';
import 'package:wpam_app/data/repositories/tracker_repository.dart';
import 'package:wpam_app/presentation/router/routes.dart';
import 'package:wpam_app/presentation/screens/categories_screen.dart';
import 'package:wpam_app/presentation/screens/home_screen.dart';
import 'package:wpam_app/presentation/screens/stats_screen.dart';

import '../screens/add_category_screen.dart';

class AppRouter {
  //repos
  late CategoryRepository _categoryRepository;
  late TrackerRepository _trackerRepository;

  // cubits
  late CategoryCubit _categoryCubit;
  late TrackerCubit _trackerCubit;

  AppRouter() {
    _categoryRepository = CategoryRepository(CategoryAPI());
    _trackerRepository = TrackerRepository(TrackerAPI());

    _categoryCubit = CategoryCubit(_categoryRepository);
    _trackerCubit = TrackerCubit(_trackerRepository);
  }

  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case categoriesRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: _categoryCubit,
                  child: const CategoriesScreen(),
                ));
      case addCategoryRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (BuildContext context) =>
                      AddCategoryCubit(_categoryRepository, _categoryCubit),
                  child: const AddCategoryScreen(),
                ));
      case statsRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: _trackerCubit,
                  child: const StatsScreen(),
                ));
      default:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _categoryCubit,
            child: BlocProvider.value(
              value: _trackerCubit,
              child: BlocProvider(
                create: (BuildContext context) =>
                    AddTrackingItemCubit(_trackerRepository, _trackerCubit),
                child: const HomeScreen(),
              ),
            ),
          ),
        );
    }
  }
}
