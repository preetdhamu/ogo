import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ogo/core/services/local_storage_service.dart';
import 'package:ogo/features/authentication/data/auth_api.dart';
import 'package:ogo/features/authentication/providers/auth_service_provider.dart';
import 'package:ogo/features/homepage/data/auth_api_homepage.dart';
import 'package:ogo/features/homepage/models/like_movie_model.dart';
import 'package:ogo/features/homepage/models/now_playing_movies_model.dart';
import 'package:ogo/features/homepage/models/top_rating_movies_model.dart';
import 'package:ogo/shared/widgets/custom_log.dart';
import 'package:provider/provider.dart';

class HomePageProvider extends ChangeNotifier {
  List likedMovies = [];
  bool load = false;
  User? currentuser;
  Map? currentUserDetails;
  LikeMovieModel? likeMovieModel;
  TopRatingMovies? topRatingMovies;
  NowPlayingMovies? nowPlayingMovies;
  bool selectGenre = true ;

  AuthServiceProvider? authServiceProvider;
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
      // if (authServiceProvider?.showHomePageContent == true) {
      // checkLikeGenre();
      // }

      // notifyListeners();
    } on Exception catch (e) {
      Oshowlog("INitalizing Error ", e.toString());
    }
  }

  Future<void> checkLikeGenre() async {
    Box genreMoviesBox = Hive.box(OHiveName.genremovies);
    List name = genreMoviesBox.get("genreMovies", defaultValue: []);
    Oshowlog1(name.toString());

    if (name.isEmpty) {
      selectGenre = true;
      await getGenre();
    } else {
      selectGenre = false;
    }
    notifyListeners();
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

  Future<void> getGenre() async {
    if (load) return; // Avoid reloading if already loading
    loading(true); // Start loading

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
      loading(false); // Stop loading
    }
  }

  bool showNextButton() {
    return (likeMovieModel?.genres ?? [] as List).any(
      (element) {
        return element.selected == true;
      },
    );
  }

  // Top Rating Movies
  Future<void> getTopRatingMovies(int pageNumber) async {
    // if (load) return; // Avoid reloading if already loading
    loading(true); // Start loading

    try {
      Map allgenre = await AuthAPIHomePage.getAllTopRatingMovies(pageNumber);
      if (allgenre['success'] == true) {
        topRatingMovies = allgenre['res'];
        Oshowlog(allgenre['res'].toString(), "Top Rating Movies Model");
      } else {
        Oshowlog1(allgenre['res'].toString());
      }
    } catch (e) {
      Oshowlog("Top Rating Movie Error:", e.toString());
    } finally {
      loading(false); // Stop loading
    }
  }

  // Top Rating Movies
  Future<void> getNowPlayingMovies(int pageNumber) async {
    if (load) return; // Avoid reloading if already loading
    loading(true); // Start loading

    try {
      Map allgenre = await AuthAPIHomePage.getAllNowPlayingMovies(pageNumber);
      if (allgenre['success'] == true) {
        nowPlayingMovies = allgenre['res'];
        Oshowlog(allgenre['res'].toString(), "Now Playing Movies Model");
      } else {
        Oshowlog1(allgenre['res'].toString());
      }
    } catch (e) {
      Oshowlog("Now Playing Movie Error:", e.toString());
    } finally {
      loading(false); // Stop loading
    }
  }
}
