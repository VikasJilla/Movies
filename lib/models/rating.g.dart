// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rating _$RatingFromJson(Map<String, dynamic> json) => Rating(
      json['Source'] as String,
      json['Value'] as String,
    );

Map<String, dynamic> _$RatingToJson(Rating instance) => <String, dynamic>{
      'Source': instance.source,
      'Value': instance.value,
    };
