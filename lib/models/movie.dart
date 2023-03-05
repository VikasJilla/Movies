import 'package:json_annotation/json_annotation.dart';
part 'movie.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class Movie {
  final String title;
  final String year;
  final String poster;

  Movie(this.title, this.year, this.poster);

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
}
