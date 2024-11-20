import 'package:flutter/material.dart';

import 'package:ogo/features/homepage/ui/all_movies.dart';

import 'package:ogo/features/homepage/widgets/main_content.dart';

class OAppRoutesHome {
  static const mainContent = '/mainContent';
  static const allMovies = '/allMovies';

  static Route<dynamic> generateRoute(settings) {
    Widget page;
    switch (settings.name) {
      case mainContent:
        page = const MainContent();
        break;
      case allMovies:
        page = const AllMovies();
        break;
      default:
        page = const MainContent();
        break;
    }

    return MaterialPageRoute(
      builder: (context) => page,
    );
  }
}
