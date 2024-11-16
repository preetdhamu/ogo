import 'package:ogo/core/constants/assets.dart';
import 'package:ogo/shared/widgets/custom_log.dart';

class LikeMovieModel {
  List<Genres>? genres;

  LikeMovieModel({this.genres});
  List genre_images = const [
    OImage.action,
    OImage.adventure,
    OImage.animation,
    OImage.comedy,
    OImage.crime,
    OImage.documentary,
    OImage.drama,
    OImage.western,
    OImage.fantasy,
    OImage.history,
    OImage.horror,
    OImage.music,
    OImage.mystery,
    OImage.romantic,
    OImage.science,
    OImage.tvmovie,
    OImage.thriller,
    OImage.war,
    OImage.western
  ];

  LikeMovieModel.fromJson(Map<String, dynamic> json) {
    int index = 0;
    if (json["genres"] is List) {
      genres = json["genres"] == null
          ? null
          : (json["genres"] as List).map((e) {
              e['image'] = genre_images[index];
              e['selected'] = false;
              index = index + 1;
              return Genres.fromJson(e);
            }).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (genres != null) {
      data["genres"] = genres?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class Genres {
  int? id;
  String? name;
  String? image;
  bool? selected;

  Genres({this.id, this.name, this.image, this.selected});

  Genres.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["image"] is String) {
      image = json["image"];
    }
    if (json["selected"] is bool) {
      selected = json["selected"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["image"] = image;
    _data["selected"] = selected;
    return _data;
  }
}
