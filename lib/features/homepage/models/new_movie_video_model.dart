

class MovieContent {
  int? movieId;
  Qualities? qualities;

  MovieContent({this.movieId, this.qualities});

  MovieContent.fromJson(Map<String, dynamic> json) {
    if(json["movie_id"] is int) {
      movieId = json["movie_id"];
    }
    if(json["qualities"] is Map) {
      qualities = json["qualities"] == null ? null : Qualities.fromJson(json["qualities"]);
    }
  }

  static List<MovieContent> fromList(List<Map<String, dynamic>> list) {
    return list.map(MovieContent.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["movie_id"] = movieId;
    if(qualities != null) {
      _data["qualities"] = qualities?.toJson();
    }
    return _data;
  }
}

class Qualities {
  String? quality_1080P;
  String? quality_720P;
  String? quality_480P;

  Qualities({this.quality_1080P, this.quality_720P, this.quality_480P});

  Qualities.fromJson(Map<String, dynamic> json) {
    if(json["1080p"] is String) {
      quality_1080P = json["1080p"];
    }
    if(json["720p"] is String) {
      quality_720P = json["720p"];
    }
    if(json["480p"] is String) {
      quality_480P = json["480p"];
    }
  }

  static List<Qualities> fromList(List<Map<String, dynamic>> list) {
    return list.map(Qualities.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["1080p"] = quality_1080P;
    _data["720p"] = quality_720P;
    _data["480p"] = quality_480P;
    return _data;
  }
}