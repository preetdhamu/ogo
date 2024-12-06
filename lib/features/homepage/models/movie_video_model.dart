
class MovieVideoModel {
  int? id;
  List<Results>? results;

  MovieVideoModel({this.id, this.results});

  MovieVideoModel.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["results"] is List) {
      results = json["results"] == null ? null : (json["results"] as List).map((e) => Results.fromJson(e)).toList();
    }
  }

  static List<MovieVideoModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(MovieVideoModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    if(results != null) {
      _data["results"] = results?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Results {
  String? iso6391;
  String? iso31661;
  String? name;
  String? key;
  String? site;
  int? size;
  String? type;
  bool? official;
  String? publishedAt;
  String? id;

  Results({this.iso6391, this.iso31661, this.name, this.key, this.site, this.size, this.type, this.official, this.publishedAt, this.id});

  Results.fromJson(Map<String, dynamic> json) {
    if(json["iso_639_1"] is String) {
      iso6391 = json["iso_639_1"];
    }
    if(json["iso_3166_1"] is String) {
      iso31661 = json["iso_3166_1"];
    }
    if(json["name"] is String) {
      name = json["name"];
    }
    if(json["key"] is String) {
      key = json["key"];
    }
    if(json["site"] is String) {
      site = json["site"];
    }
    if(json["size"] is int) {
      size = json["size"];
    }
    if(json["type"] is String) {
      type = json["type"];
    }
    if(json["official"] is bool) {
      official = json["official"];
    }
    if(json["published_at"] is String) {
      publishedAt = json["published_at"];
    }
    if(json["id"] is String) {
      id = json["id"];
    }
  }

  static List<Results> fromList(List<Map<String, dynamic>> list) {
    return list.map(Results.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["iso_639_1"] = iso6391;
    _data["iso_3166_1"] = iso31661;
    _data["name"] = name;
    _data["key"] = key;
    _data["site"] = site;
    _data["size"] = size;
    _data["type"] = type;
    _data["official"] = official;
    _data["published_at"] = publishedAt;
    _data["id"] = id;
    return _data;
  }
}

