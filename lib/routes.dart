import 'package:flutter/material.dart';
import 'package:third_exam/screens/cart_page.dart';
import 'package:third_exam/screens/home_Page.dart';
import 'package:third_exam/screens/product_page.dart';
import 'package:third_exam/utils/route.dart';

class MyRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
    //   case productsScreen:
    //     return MaterialPageRoute(builder: (_) => const Paroducts());
      case cartScreen:
        return MaterialPageRoute(
          builder: (_) => const CartPage(),
        );
      case homeScreen:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}