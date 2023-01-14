import 'package:amazon_clone/Features/Home/screens/home_screen.dart';
import 'package:amazon_clone/Features/admin/screens/add_product_screen.dart';
import 'package:amazon_clone/Features/auth/Screens/auth_screen.dart';
import 'package:amazon_clone/common/Widgets/bottom_bar.dart';
import 'package:flutter/material.dart';

import 'Features/Home/screens/home_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        builder: (_) {
          return const AuthScreen();
        },
        settings: routeSettings,
      );
    case HomeScreen.routeName:
      return MaterialPageRoute(
        builder: (_) {
          return const HomeScreen();
        },
        settings: routeSettings,
      );
    case BottomBar.routeName:
      return MaterialPageRoute(
        builder: (_) {
          return const BottomBar();
        },
        settings: routeSettings,
      );
    case AddProductScreen.routeName:
      return MaterialPageRoute(
        builder: (_) {
          return const AddProductScreen();
        },
        settings: routeSettings,
      );
    default:
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(
            child: Text("Screen does not exist"),
          ),
        ),
      );
  }
}
