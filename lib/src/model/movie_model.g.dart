// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieModel _$MovieModelFromJson(Map<String, dynamic> json) {
  return MovieModel(
    items: (json['items'] as List)
        ?.map((e) =>
            e == null ? null : ResultModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$MovieModelToJson(MovieModel instance) =>
    <String, dynamic>{
      'items': instance.items,
    };

ResultModel _$ResultModelFromJson(Map<String, dynamic> json) {
  return ResultModel(
    json['id'] as int,
    json['supplierName'] as String,
    json['profileName'] as String,
    json['desc'] as String,
    json['discountStr'] as String,
    json['point'] as int,
    json['endDateStr'] as String,
    json['isDigital'] as bool,
    json['iconUri'] as String,
  );
}

Map<String, dynamic> _$ResultModelToJson(ResultModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'supplierName': instance.supplierName,
      'profileName': instance.profileName,
      'desc': instance.desc,
      'discountStr': instance.discountStr,
      'point': instance.point,
      'endDateStr': instance.endDateStr,
      'isDigital': instance.isDigital,
      'iconUri': instance.iconUri,
    };
