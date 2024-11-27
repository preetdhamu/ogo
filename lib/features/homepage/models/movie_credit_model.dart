
class MovieCreditModel {
  int? id;
  List<Cast>? cast;
  List<Crew>? crew;

  MovieCreditModel({this.id, this.cast, this.crew});

  MovieCreditModel.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["cast"] is List) {
      cast = json["cast"] == null ? null : (json["cast"] as List).map((e) => Cast.fromJson(e)).toList();
    }
    if(json["crew"] is List) {
      crew = json["crew"] == null ? null : (json["crew"] as List).map((e) => Crew.fromJson(e)).toList();
    }
  }

  static List<MovieCreditModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(MovieCreditModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    if(cast != null) {
      _data["cast"] = cast?.map((e) => e.toJson()).toList();
    }
    if(crew != null) {
      _data["crew"] = crew?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Crew {
  bool? adult;
  int? gender;
  int? id;
  String? knownForDepartment;
  String? name;
  String? originalName;
  double? popularity;
  String? profilePath;
  String? creditId;
  String? department;
  String? job;

  Crew({this.adult, this.gender, this.id, this.knownForDepartment, this.name, this.originalName, this.popularity, this.profilePath, this.creditId, this.department, this.job});

  Crew.fromJson(Map<String, dynamic> json) {
    if(json["adult"] is bool) {
      adult = json["adult"];
    }
    if(json["gender"] is int) {
      gender = json["gender"];
    }
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["known_for_department"] is String) {
      knownForDepartment = json["known_for_department"];
    }
    if(json["name"] is String) {
      name = json["name"];
    }
    if(json["original_name"] is String) {
      originalName = json["original_name"];
    }
    if(json["popularity"] is double) {
      popularity = json["popularity"];
    }
    if(json["profile_path"] is String) {
      profilePath = json["profile_path"];
    }
    if(json["credit_id"] is String) {
      creditId = json["credit_id"];
    }
    if(json["department"] is String) {
      department = json["department"];
    }
    if(json["job"] is String) {
      job = json["job"];
    }
  }

  static List<Crew> fromList(List<Map<String, dynamic>> list) {
    return list.map(Crew.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["adult"] = adult;
    _data["gender"] = gender;
    _data["id"] = id;
    _data["known_for_department"] = knownForDepartment;
    _data["name"] = name;
    _data["original_name"] = originalName;
    _data["popularity"] = popularity;
    _data["profile_path"] = profilePath;
    _data["credit_id"] = creditId;
    _data["department"] = department;
    _data["job"] = job;
    return _data;
  }
}

class Cast {
  bool? adult;
  int? gender;
  int? id;
  String? knownForDepartment;
  String? name;
  String? originalName;
  double? popularity;
  String? profilePath;
  int? castId;
  String? character;
  String? creditId;
  int? order;

  Cast({this.adult, this.gender, this.id, this.knownForDepartment, this.name, this.originalName, this.popularity, this.profilePath, this.castId, this.character, this.creditId, this.order});

  Cast.fromJson(Map<String, dynamic> json) {
    if(json["adult"] is bool) {
      adult = json["adult"];
    }
    if(json["gender"] is int) {
      gender = json["gender"];
    }
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["known_for_department"] is String) {
      knownForDepartment = json["known_for_department"];
    }
    if(json["name"] is String) {
      name = json["name"];
    }
    if(json["original_name"] is String) {
      originalName = json["original_name"];
    }
    if(json["popularity"] is double) {
      popularity = json["popularity"];
    }
    if(json["profile_path"] is String) {
      profilePath = json["profile_path"];
    }
    if(json["cast_id"] is int) {
      castId = json["cast_id"];
    }
    if(json["character"] is String) {
      character = json["character"];
    }
    if(json["credit_id"] is String) {
      creditId = json["credit_id"];
    }
    if(json["order"] is int) {
      order = json["order"];
    }
  }

  static List<Cast> fromList(List<Map<String, dynamic>> list) {
    return list.map(Cast.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["adult"] = adult;
    _data["gender"] = gender;
    _data["id"] = id;
    _data["known_for_department"] = knownForDepartment;
    _data["name"] = name;
    _data["original_name"] = originalName;
    _data["popularity"] = popularity;
    _data["profile_path"] = profilePath;
    _data["cast_id"] = castId;
    _data["character"] = character;
    _data["credit_id"] = creditId;
    _data["order"] = order;
    return _data;
  }
}