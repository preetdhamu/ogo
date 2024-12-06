import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ogo/core/services/local_storage_service.dart';
import 'package:ogo/features/authentication/data/auth_api.dart';
import 'package:ogo/features/authentication/providers/auth_service_provider.dart';
import 'package:ogo/features/homepage/data/auth_api_homepage.dart';
import 'package:ogo/features/homepage/models/like_movie_model.dart';
import 'package:ogo/features/homepage/models/movie_credit_model.dart';
import 'package:ogo/features/homepage/models/movie_detail_model.dart';
import 'package:ogo/features/homepage/models/movie_video_model.dart'
    hide Results;
import 'package:ogo/features/homepage/models/new_movie_video_model.dart';
import 'package:ogo/features/homepage/models/now_playing_movies_model.dart';
import 'package:ogo/features/homepage/models/top_rating_movies_model.dart';
import 'package:ogo/features/tv/data/auth_api_tv.dart';
import 'package:ogo/features/tv/models/now_playing_in_tv.dart' hide Results;
import 'package:ogo/shared/widgets/custom_log.dart';
import 'package:provider/provider.dart';

class HomePageProvider extends ChangeNotifier {
  List likedMovies = [];
  bool load = false;
  User? currentuser;
  Map? currentUserDetails;
  LikeMovieModel? likeMovieModel;
  List<Results> topRatingMovies = [];
  List<Results> foryou = [];
  List<Results> categorizedMovies = [];
  List<Results> nowPlayingMovies = [];
  NowPlayingTv? nowPlayingTv;
  bool selectGenre = true;
  bool hasMoreNowPlaying = true;
  bool hasMoreNowPlayingCategorizedMovies = true;
  bool hasMoreTopMovies = true;
  int currentPage = 1;
  int currentPageTopMovies = 1;
  int currentPageCategorizeMovies = 1;
  String minimumDate = '';
  String maximumDate = '';
  MovieDetailModel? movieDetail;

  MovieCreditModel? moviecreditModel;
  TopRatingMovies? similarMovies;
  MovieVideoModel? movieVideoModel;

  AuthServiceProvider? authServiceProvider;
  MovieContent? maincontent;
  // loading(bool value) {
  //   load = value;
  //   notifyListeners();
  // }

  bool _throttle = false;

  void loading(bool value) {
    if (load != value) {
      load = value;

      if (!_throttle) {
        _throttle = true;
        notifyListeners();
        Future.delayed(Duration(milliseconds: 50), () => _throttle = false);
      }
    }
  }

  Future<void> initState(BuildContext context) async {
    try {
      authServiceProvider =
          Provider.of<AuthServiceProvider>(context, listen: false);
      authServiceProvider?.checkAuthentication(context);
      currentuser = authServiceProvider?.currentuser;
      currentUserDetails = AuthAPI.userdetails;
    } on Exception catch (e) {
      Oshowlog("INitalizing Error ", e.toString());
    }
  }

  bool checkLikeGenrebool = false;
  Future<void> checkLikeGenre() async {
    try {
      checkLikeGenrebool = true;
      notifyListeners();
      Box genreMoviesBox = Hive.box(OHiveName.genremovies);
      List name = genreMoviesBox.get("genreMovies", defaultValue: []);
      Oshowlog1(name.toString());

      if (name.isEmpty) {
        selectGenre = true;
        await getGenre();
      } else {
        selectGenre = false;
      }
    } finally {
      checkLikeGenrebool = false;
      notifyListeners();
    }
  }

  void saveLikeGenre() {
    try {
      Box genreMoviesBox = Hive.box(OHiveName.genremovies);
      List names = (likeMovieModel?.genres as List)
          .where(
            (element) => element.selected == true,
          )
          .map(
            (e) => ['${e.id}', '${e.name}'],
          )
          .toList();

      genreMoviesBox.put("genreMovies", names);
      Oshowlog("Genre List :", "Saved Successfully ");
      selectGenre = false;
      notifyListeners();
    } on Exception catch (e) {
      Oshowlog("Save like Moveis error :", e.toString());
    }
  }

  bool getgenrebool = false;
  Future<void> getGenre() async {
    // if (load) return; // Avoid reloading if already loading
    // loading(true);
    getgenrebool = true;
    notifyListeners();

    try {
      Map allgenre = await AuthAPIHomePage.getAllGenre();
      if (allgenre['success'] == true) {
        likeMovieModel = allgenre['res'];
        Oshowlog(allgenre['res'].toString(), "Genre Model");
      } else {
        Oshowlog1(allgenre['res'].toString());
      }
    } catch (e) {
      Oshowlog("Genre Error:", e.toString());
    } finally {
      getgenrebool = false;
      notifyListeners();
      // loading(false); // Stop loading
    }
  }

  bool showNextButton() {
    return (likeMovieModel?.genres ?? [] as List).any(
      (element) {
        return element.selected == true;
      },
    );
  }

  bool topratingMoviesload = false;
  resetTopRatingMovies() {
    currentPageTopMovies = 1;
    topRatingMovies.clear();
    hasMoreTopMovies = false;
  }

  // Top Rating Movies
  Future<void> getTopRatingMovies({int pageNumber = 1}) async {
    topratingMoviesload = true;
    notifyListeners();
    try {
      Box genreMoviesBox = Hive.box(OHiveName.genremovies);
      List name = genreMoviesBox.get("genreMovies", defaultValue: []);
      name = name.map((e) => int.parse(e[0])).toList();

      Map allgenre = await AuthAPIHomePage.getAllTopRatingMovies(pageNumber);
      if (allgenre['success'] == true) {
        TopRatingMovies data = allgenre['res'];

        if (data.results?.isNotEmpty ?? false) {
          if (data.page == 1) {
            resetTopRatingMovies();
            topRatingMovies = data.results!;
            Oshowlog("${data.results}", "${name}");
            foryou = data.results!
                .where((movie) =>
                    movie.genreIds!.any((element) => name.contains(element)))
                .toList();
          } else {
            topRatingMovies.addAll(data.results!);

            foryou.addAll(data.results!
                .where((movie) =>
                    movie.genreIds!.any((element) => name.contains(element)))
                .toList());
          }
          Oshowlog("asdsdgghgfcbcdfg ", nowPlayingMovies.length.toString());
          hasMoreTopMovies = data.totalPages! < data.totalResults!;
        } else {
          hasMoreTopMovies = false;
        }
        Oshowlog(allgenre['res'].toString(), "Top Rating Movies Model");
      } else {
        Oshowlog1(allgenre['res'].toString());
      }
    } catch (e) {
      Oshowlog("Top Rating Movie Error:", e.toString());
    } finally {
      // loading(false); // Stop loading
      topratingMoviesload = false;
      notifyListeners();
    }
  }

  resetNowPlayingMovies() {
    currentPage = 1;
    nowPlayingMovies.clear();
    minimumDate = '';
    maximumDate = '';
    hasMoreNowPlaying = false;
    // notifyListeners();
  }

  bool nowplayingmovieload = false;

  // Top Rating Movies
  Future<void> getNowPlayingMovies({int pageNumber = 1}) async {
    // if (load) return; // Avoid reloading if already loading
    // loading(true);
    nowplayingmovieload = true;
    notifyListeners(); // Start loading

    try {
      Map allgenre = await AuthAPIHomePage.getAllNowPlayingMovies(pageNumber);
      if (allgenre['success'] == true) {
        NowPlayingMovies data = allgenre['res'];

        if (data.results?.isNotEmpty ?? false) {
          if (data.page == 1) {
            resetNowPlayingMovies();
            nowPlayingMovies = data.results!;
          } else {
            nowPlayingMovies.addAll(data.results!);
          }
          Oshowlog("asdsdgghgfcbcdfg ", nowPlayingMovies.length.toString());
          minimumDate = data.dates?.minimum ?? '';
          maximumDate = data.dates?.maximum ?? '';
          hasMoreNowPlaying = data.page! < data.totalPages!;
        } else {
          hasMoreNowPlaying = false;
        }

        Oshowlog(allgenre['res'].toString(), "Now Playing Movies Model");
      } else {
        Oshowlog1(allgenre['res'].toString());
      }
    } catch (e) {
      Oshowlog("Now Playing Movie Error:", e.toString());
    } finally {
      // loading(false); // Stop loading
      nowplayingmovieload = false;
      notifyListeners();
      Oshowlog1("Appi completed processing ");
      notifyListeners();
    }
  }

  int selectedNavigationScreen = 0;

  void selectScreen(int value) {
    if (value >= 0 && value < 5) {
      selectedNavigationScreen = value;
      notifyListeners();
    }
  }

  int incrementPageCount() {
    currentPage = currentPage + 1;
    notifyListeners();
    return currentPage;
  }

  int incrementPageCountTopMovies() {
    currentPageTopMovies = currentPageTopMovies + 1;
    notifyListeners();
    return currentPageTopMovies;
  }

  bool nowplayingtvload = false;

  // Top Rating Movies
  Future<void> getNowPlayingTv({int pageNumber = 1}) async {
    // if (load) return; // Avoid reloading if already loading
    // loading(true);
    nowplayingtvload = true;
    notifyListeners(); // Start loading

    try {
      Map allgenre = await AuthAPITv.getAllNowPlayingTv(pageNumber);
      if (allgenre['success'] == true) {
        nowPlayingTv = allgenre['res'];

        Oshowlog(allgenre['res'].toString(), "Now Playing Tv Model");
      } else {
        Oshowlog1(allgenre['res'].toString());
      }
    } catch (e) {
      Oshowlog("Now Playing Movie Error:", e.toString());
    } finally {
      // loading(false); // Stop loading
      nowplayingtvload = false;
      notifyListeners();
    }
  }

  bool moviedetailload = false;
  Future<void> getMovieDetails(int movieId) async {
    // if (load) return; // Avoid reloading if already loading
    // loading(true);
    moviedetailload = true;
    notifyListeners(); // Start loading

    try {
      Map moviedata = await AuthAPIHomePage.getMovieDetail(movieId);
      if (moviedata['success'] == true) {
        movieDetail = moviedata['res'];
        Oshowlog(moviedata['res'].toString(), "MovieDetail Model");
      } else {
        Oshowlog1(moviedata['res'].toString());
      }
    } catch (e) {
      Oshowlog(" Movie Detail Error:", e.toString());
    } finally {
      // loading(false); // Stop loading
      moviedetailload = false;
      notifyListeners();
      Oshowlog1("Appi completed processing ");
      notifyListeners();
    }
  }

  String lengthofMovie(int runtime) {
    String length = "${runtime ~/ 60} hours  ${runtime % 60} minutes";
    return length;
  }

  bool moviecreditload = false;
  Future<void> getCredits(int movieId) async {
    // if (load) return; // Avoid reloading if already loading
    // loading(true);
    moviecreditload = true;
    notifyListeners(); // Start loading

    try {
      Map moviedata = await AuthAPIHomePage.getMovieCredit(movieId);
      if (moviedata['success'] == true) {
        moviecreditModel = moviedata['res'];
        Oshowlog(moviedata['res'].toString(), "MovieCredit Model");
      } else {
        Oshowlog1(moviedata['res'].toString());
      }
    } catch (e) {
      Oshowlog(" Movie Credit Error:", e.toString());
    } finally {
      // loading(false); // Stop loading
      moviecreditload = false;
      notifyListeners();
      Oshowlog1("Appi completed processing ");
      notifyListeners();
    }
  }

  bool similarmovieload = false;
  Future<void> getSimilarMovies(int movieId) async {
    // if (load) return; // Avoid reloading if already loading
    // loading(true);
    similarmovieload = true;
    notifyListeners(); // Start loading

    try {
      Map moviedata = await AuthAPIHomePage.getSimilarMovie(movieId);
      if (moviedata['success'] == true) {
        similarMovies = moviedata['res'];
        Oshowlog(moviedata['res'].toString(), "Movie Similar Model");
      } else {
        Oshowlog1(moviedata['res'].toString());
      }
    } catch (e) {
      Oshowlog(" Similar Movie Error:", e.toString());
    } finally {
      // loading(false); // Stop loading
      similarmovieload = false;
      notifyListeners();
      Oshowlog1("Appi completed processing ");
      notifyListeners();
    }
  }

  bool movievideoload = false;
  Future<void> getMovieVideo(int movieId) async {
    // if (load) return; // Avoid reloading if already loading
    // loading(true);
    movievideoload = true;
    notifyListeners(); // Start loading

    try {
      Map moviedata = await AuthAPIHomePage.getMovieVideo(movieId);
      if (moviedata['success'] == true) {
        movieVideoModel = moviedata['res'];
        Oshowlog(moviedata['res'].toString(), "Movie Video Model");
      } else {
        Oshowlog1(moviedata['res'].toString());
      }
    } catch (e) {
      Oshowlog("Movie Video Error:", e.toString());
    } finally {
      // loading(false); // Stop loading
      movievideoload = false;
      notifyListeners();
      Oshowlog1("Appi completed processing ");
      notifyListeners();
    }
  }

  bool categorizeMovieload = false;
  resetCategorizedMovies() {
    currentPageCategorizeMovies = 1;
    categorizedMovies.clear();
    hasMoreNowPlayingCategorizedMovies = false;
  }

  // Categorized Movies
  Future<void> getCategorizedMovies(int genreId, {int pageNumber = 1}) async {
    // if (load) return; // Avoid reloading if already loading
    // loading(true);
    categorizeMovieload = true;
    notifyListeners(); // Start loading

    try {
      Map allgenre =
          await AuthAPIHomePage.getCategorizedMovies(genreId, pageNumber);
      if (allgenre['success'] == true) {
        TopRatingMovies data = allgenre['res'];

        if (data.results?.isNotEmpty ?? false) {
          if (data.page == 1) {
            resetCategorizedMovies();
            categorizedMovies = data.results!;
          } else {
            categorizedMovies.addAll(data.results!);
          }

          hasMoreNowPlayingCategorizedMovies = data.page! < data.totalPages!;
        } else {
          hasMoreNowPlayingCategorizedMovies = false;
        }

        Oshowlog(allgenre['res'].toString(), "Categorized Movies Model");
      } else {
        Oshowlog1(allgenre['res'].toString());
      }
    } catch (e) {
      Oshowlog("Categorized Movie Error:", e.toString());
    } finally {
      categorizeMovieload = false;
      notifyListeners();
      Oshowlog1("Appi completed processing ");
      notifyListeners();
    }
  }

  bool hasPlayableContent = false;
  Future<void> getPlayableContent(int id) async {
    hasPlayableContent = true;
    notifyListeners(); // Start loading

    try {
      Map allgenre = await AuthAPIHomePage.getPlayableContent(id);
      if (allgenre['success'] == true) {
        maincontent = allgenre['res'];
        Oshowlog(allgenre['res'].toString(), "Movie Playing Video Loading ");
      } else {
        Oshowlog1(allgenre['res'].toString());
        maincontent = null;

        /// what to do here
        throw Exception("Video not found $id ");
      }
    } catch (e) {
      Oshowlog("Movie Playing Video Error:", e.toString());
    } finally {
      hasPlayableContent = false;
      notifyListeners();
      Oshowlog1("Appi completed processing ");
      notifyListeners();
    }
  }
}
