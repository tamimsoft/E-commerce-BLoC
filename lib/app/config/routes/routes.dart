import 'package:fakestore/app/features/product/data/model/product_model.dart';

import 'package:flutter/material.dart';

import 'routes_name.dart';
import 'views.dart';

class Routes {
  Routes._();

  static Route<dynamic> generateRoutes(RouteSettings settings) {
    late Widget widget;

    switch (settings.name) {
      case RoutesName.initial:
        widget = const SplashScreen();
        break;
      case RoutesName.login:
        widget = const LoginScreen();
        break;
      case RoutesName.signup:
        widget = const SignupScreen();
        break;
      case RoutesName.otpVerify:
        widget = OTPScreen();
        break;
      case RoutesName.home:
        widget = MainBottomNavBarScreen();
        break;
      case RoutesName.productList:
        final Map<String, dynamic> arguments = settings.arguments! as Map<String, dynamic>;
        widget = ProductListScreen(
          title: arguments['title'],
          categoryId: arguments['categoryId'],
          productList: arguments['productList'],
        );
        break;
      case RoutesName.productDetails:
        final ProductModel product = settings.arguments! as ProductModel;
        widget = ProductDetailsScreen(product: product);
        break;
      case RoutesName.productReview:
        widget = const ProductReviewScreen();
        break;

      default:
        widget = const Scaffold(
          body: Center(child: Text('No route generated')),
        );
    }
    return MaterialPageRoute(builder: (context) => widget);
  }
}
