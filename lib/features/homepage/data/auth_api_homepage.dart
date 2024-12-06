import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ogo/core/constants/api_endpoints.dart';
import 'package:ogo/core/constants/app_contants.dart';
import 'package:ogo/features/homepage/models/like_movie_model.dart';
import 'package:ogo/features/homepage/models/movie_credit_model.dart';
import 'package:ogo/features/homepage/models/movie_detail_model.dart';
import 'package:ogo/features/homepage/models/movie_video_model.dart';
import 'package:ogo/features/homepage/models/new_movie_video_model.dart';
import 'package:ogo/features/homepage/models/now_playing_movies_model.dart';
import 'package:ogo/features/homepage/models/top_rating_movies_model.dart';
import 'package:ogo/shared/widgets/custom_log.dart';

class AuthAPIHomePage {
  static Future<Map<String, dynamic>> getAllGenre() async {
    final response = await http.get(
      Uri.parse(OAppEndPoints.genreMovies),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${OAppConstants.tvdbKey}',
      },
    );

    if (response.statusCode == 200) {
      // Parse response if needed, for example checking a specific field
      final data = jsonDecode(response.body);

      LikeMovieModel likeMovieModel = LikeMovieModel.fromJson(data);

      // Assuming the backend returns a success field for authorization
      return {
        "success": true,
        "res": likeMovieModel,
      };
    } else {
      // Handle other status codes as an authorization failure
      return {
        "success": false,
        "res": response.body,
      };
    }
  }

  static Future<Map<String, dynamic>> getAllTopRatingMovies(
      int pageNumber) async {
    final response = await http.get(
      Uri.parse('${OAppEndPoints.topRatingMovies}&page=$pageNumber'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${OAppConstants.tvdbKey}',
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      TopRatingMovies topRatingMovies = TopRatingMovies.fromJson(data);

      return {
        "success": true,
        "res": topRatingMovies,
      };
    } else {
      return {
        "success": false,
        "res": response.body,
      };
    }
  }

  static Future<Map<String, dynamic>> getAllNowPlayingMovies(
      int pageNumber) async {
    final response = await http.get(
      Uri.parse('${OAppEndPoints.nowPlayingMovies}&page=$pageNumber'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${OAppConstants.tvdbKey}',
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      NowPlayingMovies nowPlayingMovies = NowPlayingMovies.fromJson(data);

      return {
        "success": true,
        "res": nowPlayingMovies,
      };
    } else {
      return {
        "success": false,
        "res": response.body,
      };
    }
  }

  static Future<Map<String, dynamic>> getCategorizedMovies(
      int genreId, int pageNumber) async {
    final response = await http.get(
      Uri.parse(
          '${OAppEndPoints.categorizedMovies}&page=$pageNumber&with_genres=$genreId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${OAppConstants.tvdbKey}',
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      TopRatingMovies categorizedMovies = TopRatingMovies.fromJson(data);

      return {
        "success": true,
        "res": categorizedMovies,
      };
    } else {
      return {
        "success": false,
        "res": response.body,
      };
    }
  }

  static Future<Map<String, dynamic>> getPlayableContent(int id) async {
    final response = await http.get(
      Uri.parse(
          '${OAppEndPoints.baseUrl}${OAppEndPoints.getPlayableContent}/$id/'),

      // headers: {
      //   'Content-Type': 'application/json',
      //   'Authorization': 'Bearer ${OAppConstants.tvdbKey}',
      // },
    );
    if (response.statusCode == 200) {
       final data = jsonDecode(response.body);
      MovieContent content = MovieContent.fromJson(data['result']);
      
      return {
        "success": true,
        "res": content,
      };
    } else {
      return {
        "success": false,
        "res": response.body,
      };
    }
  }

  static Future<Map<String, dynamic>> getMovieDetail(int movieId) async {
    final response = await http.get(
      Uri.parse('${OAppEndPoints.movieDetail}$movieId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${OAppConstants.tvdbKey}',
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      MovieDetailModel movieDetail = MovieDetailModel.fromJson(data);

      return {
        "success": true,
        "res": movieDetail,
      };
    } else {
      return {
        "success": false,
        "res": response.body,
      };
    }
  }

  static Future<Map<String, dynamic>> getMovieCredit(int movieId) async {
    final response = await http.get(
      Uri.parse(
          '${OAppEndPoints.movieDetail}$movieId${OAppEndPoints.moviecredit}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${OAppConstants.tvdbKey}',
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      MovieCreditModel movieCredit = MovieCreditModel.fromJson(data);

      return {
        "success": true,
        "res": movieCredit,
      };
    } else {
      return {
        "success": false,
        "res": response.body,
      };
    }
  }

  static Future<Map<String, dynamic>> getSimilarMovie(int movieId) async {
    final response = await http.get(
      Uri.parse(
          '${OAppEndPoints.movieDetail}$movieId${OAppEndPoints.moviesimilar}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${OAppConstants.tvdbKey}',
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      TopRatingMovies moviesimilar = TopRatingMovies.fromJson(data);

      return {
        "success": true,
        "res": moviesimilar,
      };
    } else {
      return {
        "success": false,
        "res": response.body,
      };
    }
  }

  static Future<Map<String, dynamic>> getMovieVideo(int movieId) async {
    final response = await http.get(
      Uri.parse(
          '${OAppEndPoints.movieDetail}$movieId${OAppEndPoints.moviesvideo}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${OAppConstants.tvdbKey}',
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      MovieVideoModel movieVideo = MovieVideoModel.fromJson(data);

      return {
        "success": true,
        "res": movieVideo,
      };
    } else {
      return {
        "success": false,
        "res": response.body,
      };
    }
  }
}
