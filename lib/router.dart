import 'package:amazon_clone/Features/Home/screens/home_screen.dart';
import 'package:amazon_clone/Features/admin/screens/add_product_screen.dart';
import 'package:amazon_clone/Features/auth/Screens/auth_screen.dart';
import 'package:amazon_clone/common/Widgets/bottom_bar.dart';
import 'package:amazon_clone/models/order.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';

import 'Features/Address/Screens/address_screen.dart';
import 'Features/Home/screens/category_deals_screen.dart';
import 'Features/OrderDetails/screens/order_detail_screen.dart';
import 'Features/ProductDetails/Screens/product_detail_screen.dart';
import 'Features/Search/Screens/search_screen.dart';

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
    case CategoryDealsScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        builder: (_) {
          return CategoryDealsScreen(
            category: category,
          );
        },
        settings: routeSettings,
      );
    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
        builder: (_) {
          return SearchScreen(
            searchQuery: searchQuery,
          );
        },
        settings: routeSettings,
      );
    case ProductDetailScreen.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
        builder: (_) {
          return ProductDetailScreen(
            product: product,
          );
        },
        settings: routeSettings,
      );
    case AddressScreen.routeName:
      var totalAmount = routeSettings.arguments as String;
      return MaterialPageRoute(
        builder: (_) {
          return AddressScreen(
            totalAmount: totalAmount,
          );
        },
        settings: routeSettings,
      );
    case OrderDetailScreen.routeName:
      var order = routeSettings.arguments as Order;
      return MaterialPageRoute(
        builder: (_) {
          return OrderDetailScreen(
            order: order,
          );
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
