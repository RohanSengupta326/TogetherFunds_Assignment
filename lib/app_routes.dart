import 'card_list_view/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  Route<dynamic>? onGeneratedRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => HomeScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => HomeScreen(),
        );
    }
  }
}
