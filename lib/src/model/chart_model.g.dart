// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChartModel _$ChartModelFromJson(Map<String, dynamic> json) {
  return ChartModel(
    scale: json['scale'] == null
        ? null
        : ScaleXModel.fromJson(json['scale'] as Map<String, dynamic>),
    series: (json['series'] as List)
        ?.map((e) =>
            e == null ? null : SeriesModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ChartModelToJson(ChartModel instance) =>
    <String, dynamic>{
      'scale': instance.scale,
      'series': instance.series,
    };

ScaleXModel _$ScaleXModelFromJson(Map<String, dynamic> json) {
  return ScaleXModel(
    values: (json['values'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$ScaleXModelToJson(ScaleXModel instance) =>
    <String, dynamic>{
      'values': instance.values,
    };

SeriesModel _$SeriesModelFromJson(Map<String, dynamic> json) {
  return SeriesModel(
    values: (json['values'] as List)?.map((e) => e as int)?.toList(),
    text: json['text'] as String,
  );
}

Map<String, dynamic> _$SeriesModelToJson(SeriesModel instance) =>
    <String, dynamic>{
      'values': instance.values,
      'text': instance.text,
    };
