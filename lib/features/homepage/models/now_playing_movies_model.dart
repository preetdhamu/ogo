
import 'package:ogo/features/homepage/models/top_rating_movies_model.dart';

class NowPlayingMovies {
  Dates? dates;
  int? page;
  List<Results>? results;
  int? totalPages;
  int? totalResults;

  NowPlayingMovies({this.dates, this.page, this.results, this.totalPages, this.totalResults});

  NowPlayingMovies.fromJson(Map<String, dynamic> json) {
    if(json["dates"] is Map) {
      dates = json["dates"] == null ? null : Dates.fromJson(json["dates"]);
    }
    if(json["page"] is int) {
      page = json["page"];
    }
    if(json["results"] is List) {
      results = json["results"] == null ? null : (json["results"] as List).map((e) => Results.fromJson(e)).toList();
    }
    if(json["total_pages"] is int) {
      totalPages = json["total_pages"];
    }
    if(json["total_results"] is int) {
      totalResults = json["total_results"];
    }
  }

  static List<NowPlayingMovies> fromList(List<Map<String, dynamic>> list) {
    return list.map(NowPlayingMovies.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(dates != null) {
      _data["dates"] = dates?.toJson();
    }
    _data["page"] = page;
    if(results != null) {
      _data["results"] = results?.map((e) => e.toJson()).toList();
    }
    _data["total_pages"] = totalPages;
    _data["total_results"] = totalResults;
    return _data;
  }
}


class Dates {
  String? maximum;
  String? minimum;

  Dates({this.maximum, this.minimum});

  Dates.fromJson(Map<String, dynamic> json) {
    if(json["maximum"] is String) {
      maximum = json["maximum"];
    }
    if(json["minimum"] is String) {
      minimum = json["minimum"];
    }
  }

  static List<Dates> fromList(List<Map<String, dynamic>> list) {
    return list.map(Dates.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["maximum"] = maximum;
    _data["minimum"] = minimum;
    return _data;
  }
}