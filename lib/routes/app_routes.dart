import 'package:flutter/material.dart';
import 'package:ogo/features/authentication/ui/login_screen_ui.dart';
import 'package:ogo/features/authentication/ui/register_screen_ui.dart';
import 'package:ogo/features/homepage/models/top_rating_movies_model.dart';
import 'package:ogo/features/homepage/ui/all_movies.dart';
import 'package:ogo/features/homepage/ui/home_page.dart';
import 'package:ogo/features/authentication/ui/splash_screen.dart';
import 'package:ogo/features/homepage/ui/movie_details.dart';
import 'package:ogo/shared/widgets/custom_log.dart';
import 'package:ogo/shared/widgets/custom_video_player.dart';
import 'package:ogo/shared/widgets/custom_youtube_video_player.dart';

class OAppRoutes {
  static const splash = '/splash';
  static const homepage = '/homepage';

  static const login = '/login';
  static const register = '/register';
  static const test = '/test';
  static const moviedetail = '/moviedetail';
  static const youtubePlayer = '/youtubePlayer';
  static const customPlayer = '/customPlayer';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case homepage:
        return MaterialPageRoute(builder: (_) => HomePage());
      case youtubePlayer:
        String videoId = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => CustomYoutubeVideoPlayer(
                  videoId: videoId,
                ));
      case customPlayer:
        Map movie = settings.arguments as Map;
        return MaterialPageRoute(
            builder: (_) => CustomVideoPlayer(
                  movie: movie,
                ));

      case moviedetail:
        int movieId = settings.arguments as int;

        return MaterialPageRoute(
            builder: (_) => MovieDetails(
                  movieId: movieId,
                ));

      case test:
        return MaterialPageRoute(builder: (_) => const Placeholder());
      // case homepage:
      //   return MaterialPageRoute(
      //     builder: (context) => HomePage(),
      //   );

      default:
        //TODO: Make 404 Error Screen or Try Again Screen
        return MaterialPageRoute(builder: (_) => SplashScreen());
    }
  }
}
