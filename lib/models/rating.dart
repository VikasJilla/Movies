import 'package:json_annotation/json_annotation.dart';

part 'rating.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class Rating {
  final String source;
  final String value;

  Rating(this.source, this.value);

  factory Rating.fromJson(Map<String, dynamic> json) => _$RatingFromJson(json);

  Map<String, dynamic> toJson() => _$RatingToJson(this);
}
