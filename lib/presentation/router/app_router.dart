import 'package:flutter/material.dart';
import 'package:wpam_app/presentation/screens/categories_screen.dart';
import 'package:wpam_app/presentation/screens/home_screen.dart';
import 'package:wpam_app/presentation/screens/stats_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case "/categories":
        return MaterialPageRoute(builder: (_) => const CategoriesScreen());
      case "/stats":
        return MaterialPageRoute(builder: (_) => const StatsScreen());
      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}
