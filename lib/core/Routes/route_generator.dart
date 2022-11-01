import 'package:e_commerce/core/Routes/routes_name.dart';
import 'package:e_commerce/core/utils/string_extension.dart';
import 'package:e_commerce/features/domain/entities/product_entity.dart';
import 'package:e_commerce/features/presentation/screens/cart/cart_screen.dart';
import 'package:e_commerce/features/presentation/screens/cart_history/cart_history_screen.dart';
import 'package:e_commerce/features/presentation/screens/food/popular_food_details_screen.dart';
import 'package:e_commerce/features/presentation/screens/food/recommended_food_details.dart';
import 'package:e_commerce/features/presentation/screens/home/home_screen.dart';
import 'package:e_commerce/features/presentation/screens/main/main_screen.dart';
import 'package:e_commerce/features/presentation/screens/page_not_found.dart/404.dart';
import 'package:e_commerce/features/presentation/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings routesSettings) {
    var routingData = routesSettings.name!.getRoutingdata;

    switch (routingData.route) {
      //exemple with datas in path

      case Routes.SplashRoute:
      return CustomRoute(
        builder: (context) => const SplashScreen(),
        settings: routesSettings,
      );


       case Routes.MainRoute:
        return CustomRoute(
          builder: (context) => const MainScreen(),
          settings: routesSettings,
        );

      case Routes.HomeRoute:
        return CustomRoute(
          builder: (context) => const HomeScreen(),
          settings: routesSettings,
        );

      case Routes.CartRoute:
        return CustomRoute(
          builder: (context) => const CartScreen(),
          settings: routesSettings,
        );

      
       case Routes.CartHistoryRoute:
        return CustomRoute(
          builder: (context) => const CartHistoryScreen(),
          settings: routesSettings,
        );

      case Routes.PopularFoodDetails:
        final popularProduct = routesSettings.arguments as ProductEntity;
        return CustomRoute(
          builder: (context) =>
              PopularFoodDetails(popularProduct: popularProduct),
          settings: routesSettings,
        );

      case Routes.RecommendedFoodDetails:
        final popularProduct = routesSettings.arguments as ProductEntity;
        return CustomRoute(
          builder: (context) =>
              RecommendedFoodDetails(popularProduct: popularProduct),
          settings: routesSettings,
        );

      default:
        return CustomRoute(
          builder: (context) => const PageNotFound(),
          settings: routesSettings,
        );
    }
  }
}

class CustomRoute<T> extends MaterialPageRoute<T> {
  CustomRoute({required WidgetBuilder builder, required RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // Fades between routes. (If you don't want any animation,
    // just return child.)
    return FadeTransition(opacity: animation, child: child);
    //return new FadeTransition(opacity: animation, child: child);
  }
}
