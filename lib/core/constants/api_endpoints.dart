class OAppEndPoints {
  static const String baseUrl = 'http://192.168.1.43:8000/api';
  // static const String baseUrl = 'http://172.20.10.5:8000/api';
  // static const String baseUrl = 'http://192.168.116.154:8000/api';
  static const String baseUrlfromDB = 'https://api.themoviedb.org';
  static const String baseUrlfromDBImage = 'https://image.tmdb.org/t/p/w500';

  // Authorization
  static const String authorizeUser = '$baseUrl/authorize-user/';

  static const String genreMovies =
      '$baseUrlfromDB/3/genre/movie/list';
  static const String topRatingMovies =
      '$baseUrlfromDB/3/movie/top_rated?language=en-US';
  static const String nowPlayingMovies =
      '$baseUrlfromDB/3/movie/now_playing?language=en-US';

      

}
