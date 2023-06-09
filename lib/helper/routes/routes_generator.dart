import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_signup_task/authentication_module/login_screen.dart';
import 'package:login_signup_task/authentication_module/signup_screen.dart';
import 'package:login_signup_task/bottom_navigation_bar_module/bottom_navigation_bar_screen.dart';
import 'package:login_signup_task/helper/routes/routes.dart';
import 'package:login_signup_task/home_module/home_screen.dart';


class RoutesGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings) {
    Widget widgetScreen;

    final args = settings.arguments;

    switch (settings.name) {
      case Routes.signup:
        widgetScreen = SignupScreen();
        break;
      case Routes.home:
        widgetScreen = HomeScreen();
        break;
      case Routes.login:
        widgetScreen = LoginScreen();
        break;
      case Routes.bottomNavigationBar:
        widgetScreen = BottomNavigationBarScreen();
        break;
      default:
        widgetScreen = _errorRoute();
    }
    return GetPageRoute(
        routeName: settings.name, page: () => widgetScreen, settings: settings);
  }

  static Widget _errorRoute() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: const Center(
        child: Text('No Such screen found in route generator'),
      ),
    );
  }
}