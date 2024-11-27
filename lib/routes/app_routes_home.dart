import 'package:flutter/material.dart';
import 'package:ogo/features/homepage/models/like_movie_model.dart';

import 'package:ogo/features/homepage/ui/all_movies.dart';
import 'package:ogo/features/homepage/ui/categorize_movies.dart';
import 'package:ogo/features/homepage/ui/for_you_movies.dart';
import 'package:ogo/features/homepage/ui/movie_details.dart';

import 'package:ogo/features/homepage/widgets/main_content.dart';

import '../features/homepage/models/top_rating_movies_model.dart';

class OAppRoutesHome {
  static const mainContent = '/mainContent';
  static const allMovies = '/allMovies';
  static const foryouMovies = '/foryouMovies';
  static const categorizemovie = '/categorizemovie';

  static Route<dynamic> generateRoute(settings) {
    Widget page;
    switch (settings.name) {
      case mainContent:
        page = const MainContent();
        break;
      case allMovies:
        page = const AllMovies();
        break;
      case foryouMovies:
        page = const ForYouMovies();
        break;

      case categorizemovie:
        Genres res = settings.arguments as Genres;

        page = CategorizeMovies(
          genre: res,
        );
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
