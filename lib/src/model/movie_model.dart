
import 'package:json_annotation/json_annotation.dart';
part 'movie_model.g.dart';

@JsonSerializable()
class MovieModel extends Object{

  final List<ResultModel> items;

  MovieModel({this.items});

  factory MovieModel.fromJson(Map<String, dynamic> json) => _$MovieModelFromJson(json);
  Map<String, dynamic> toJson() => _$MovieModelToJson(this);
}

@JsonSerializable()
class ResultModel extends Object{
  final int id;
  final String supplierName;
  final String profileName;
  final String desc;
  final String discountStr;
  final int point;
  final String endDateStr;
  final bool isDigital;
  final String iconUri;

  ResultModel(this.id, this.supplierName, this.profileName, this.desc, this.discountStr, this.point, this.endDateStr, this.isDigital, this.iconUri);
  factory ResultModel.fromJson(Map<String, dynamic> json) => _$ResultModelFromJson(json);
  Map<String, dynamic> toJson() => _$ResultModelToJson(this);
}