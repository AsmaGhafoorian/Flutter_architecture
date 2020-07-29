
import 'package:json_annotation/json_annotation.dart';
part 'movie_model.g.dart';

@JsonSerializable()
class MovieModel {
  final int page;
  final int total_results;
  final int total_pages;

  final List<ResultModel> results;

  MovieModel({this.page, this.total_results, this.total_pages, this.results});

  factory MovieModel.fromJson(Map<String, dynamic> json) => _$MovieModelFromJson(json);
  Map<String, dynamic> toJson() => _$MovieModelToJson(this);
}

@JsonSerializable()
class ResultModel {
  final int vote_count;
  final int id;
  final bool video;
  final double vote_average;
  final String title;
  final double popularity;
  final String poster_path;
  final String original_language;
  final String original_title;
  final List<int> genre_ids;
  final String backdrop_path;
  final bool adult;
  final String overview;
  final String release_date;

  ResultModel({this.vote_count, this.id, this.video, this.vote_average, this.title, this.popularity, this.poster_path, this.original_language, this.original_title, this.genre_ids ,this.backdrop_path, this.adult, this.overview, this.release_date});

  factory ResultModel.fromJson(Map<String, dynamic> json) => _$ResultModelFromJson(json);
  Map<String, dynamic> toJson() => _$ResultModelToJson(this);
}