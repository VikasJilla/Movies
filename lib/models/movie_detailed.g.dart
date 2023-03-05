// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_detailed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieDetailed _$MovieDetailedFromJson(Map<String, dynamic> json) =>
    MovieDetailed(
      json['Title'] as String,
      json['Year'] as String,
      json['Poster'] as String,
      json['RunTime'] as String?,
      json['Actors'] as String,
      json['Plot'] as String,
      json['Language'] as String,
      json['Genre'] as String,
      (json['Ratings'] as List<dynamic>)
          .map((e) => Rating.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MovieDetailedToJson(MovieDetailed instance) =>
    <String, dynamic>{
      'Title': instance.title,
      'Year': instance.year,
      'Poster': instance.poster,
      'RunTime': instance.runTime,
      'Actors': instance.actors,
      'Plot': instance.plot,
      'Language': instance.language,
      'Genre': instance.genre,
      'Ratings': instance.ratings.map((e) => e.toJson()).toList(),
    };
