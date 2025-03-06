import 'package:flutter/material.dart';
import 'package:workshop_mobile/login/login_page.dart';
import 'package:workshop_mobile/register/register_page.dart';
import 'package:workshop_mobile/home/home_page.dart';
import 'package:workshop_mobile/resetpassword/reset_password_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String resetPassword = '/reset-password';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case register:
        return MaterialPageRoute(builder: (_) => RegisterPage());
      case home:
        return MaterialPageRoute(builder: (_) => HomePage());
      case resetPassword:
        return MaterialPageRoute(builder: (_) => ResetPasswordBottomSheet());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: Text('Route Not Found')),
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
