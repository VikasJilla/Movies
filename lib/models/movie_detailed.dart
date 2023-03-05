import 'package:json_annotation/json_annotation.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/models/rating.dart';

part 'movie_detailed.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal, explicitToJson: true)
class MovieDetailed extends Movie {
  final String? runTime;
  final String actors;
  final String plot;
  final String language;
  final String genre;
  final List<Rating> ratings;

  MovieDetailed(
    super.title,
    super.year,
    super.poster,
    this.runTime,
    this.actors,
    this.plot,
    this.language,
    this.genre,
    this.ratings,
  );

  factory MovieDetailed.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailedFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailedToJson(this);
}
