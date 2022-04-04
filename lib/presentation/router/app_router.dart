import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wpam_app/business_logic/cubit/category_cubit.dart';
import 'package:wpam_app/data/data_providers/category_api.dart';
import 'package:wpam_app/data/repositories/category_repository.dart';
import 'package:wpam_app/presentation/router/routes.dart';
import 'package:wpam_app/presentation/screens/categories_screen.dart';
import 'package:wpam_app/presentation/screens/home_screen.dart';
import 'package:wpam_app/presentation/screens/stats_screen.dart';

class AppRouter {
  CategoryRepository categoryRepository = CategoryRepository(CategoryAPI());

  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case categoriesRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (BuildContext context) =>
                      CategoryCubit(categoryRepository),
                  child: const CategoriesScreen(),
                ));
      case statsRoute:
        return MaterialPageRoute(builder: (_) => const StatsScreen());
      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}
