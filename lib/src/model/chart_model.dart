

import 'package:json_annotation/json_annotation.dart';
part 'chart_model.g.dart';

@JsonSerializable()
class ChartModel extends Object{

  final ScaleXModel scale ;
  final List<SeriesModel> series;
  ChartModel({this.scale, this.series});

  factory ChartModel.fromJson(Map<String, dynamic> json) => _$ChartModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChartModelToJson(this);
}

@JsonSerializable()

class ScaleXModel{
  final List<String> values;

  ScaleXModel({this.values});

  factory ScaleXModel.fromJson(Map<String, dynamic> json) => _$ScaleXModelFromJson(json);
  Map<String, dynamic> toJson() => _$ScaleXModelToJson(this);
}

@JsonSerializable()
class SeriesModel{
  final List<int> values;
  final String text;

  SeriesModel({this.values, this.text});

  factory SeriesModel.fromJson(Map<String, dynamic> json) => _$SeriesModelFromJson(json);
  Map<String, dynamic> toJson() => _$SeriesModelToJson(this);
}
