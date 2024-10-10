import 'package:cinema_club/features/authentication/presentation/screens/forget_password_screen.dart';
import 'package:cinema_club/features/authentication/presentation/screens/login_screen.dart';
import 'package:cinema_club/features/authentication/presentation/screens/sign_up_screen.dart';
import 'package:cinema_club/features/setting/presentation/screens/setting_screen.dart';
import 'package:cinema_club/navigation_bottom.dart';

import 'constants/string/route_name.dart';
import 'features/getmovies/presentation/screens/movie_detales_screen.dart';
import 'features/getmovies/presentation/screens/movies_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case (signUpScreen):
        return MaterialPageRoute(builder: (_) => const SignUpScreen());

      case moviesNav:
        return MaterialPageRoute(builder: (_) => const MoviesNav());

      case moviesScreen:
        return MaterialPageRoute(builder: (_) => const MoviesScreen());

      case moiveDetalesScreen:
        return MaterialPageRoute(builder: (_) => const MovieDetalesScreen());

      case settingScreen:
        return MaterialPageRoute(builder: (_) => const SettingScreen());

      case forgetPasswordScreen:
        return MaterialPageRoute(builder: (_) => const ForgetPasswordScreen());
    }
    return null;
  }
}
