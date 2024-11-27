class OAppEndPoints {
  static const String baseUrl = 'http://192.168.1.37:8000/api';
  // static const String baseUrl = 'http://172.20.10.5:8000/api';
  // static const String baseUrl = 'http://192.168.116.154:8000/api';
  static const String baseUrlfromDB = 'https://api.themoviedb.org';
  static const String baseUrlfromDBImage = 'https://image.tmdb.org/t/p/w500';

  static const String language = "language=en-US";
  static const String region = "region=IN";

  // Authorization
  static const String authorizeUser = '$baseUrl/authorize-user/';

  static const String genreMovies = '$baseUrlfromDB/3/genre/movie/list';
  static const String topRatingMovies =
      '$baseUrlfromDB/3/movie/top_rated?$language&$region';
  static const String nowPlayingMovies =
      '$baseUrlfromDB/3/movie/now_playing?$language&$region';
  static const String categorizedMovies =
      '$baseUrlfromDB/3/discover/movie?$language&$region';

  static const String nowPlayingTv = '$baseUrlfromDB/3/tv/airing_today';
  static const String movieDetail = '$baseUrlfromDB/3/movie/';
  static const String moviecredit = '/credits';
  static const String moviesimilar = '/similar';
  static const String moviesvideo = '/videos';
}
