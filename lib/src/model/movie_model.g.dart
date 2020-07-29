// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieModel _$MovieModelFromJson(Map<String, dynamic> json) {
  return MovieModel(
    page: json['page'] as int,
    total_results: json['total_results'] as int,
    total_pages: json['total_pages'] as int,
    results: (json['results'] as List)
        ?.map((e) =>
            e == null ? null : ResultModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$MovieModelToJson(MovieModel instance) =>
    <String, dynamic>{
      'page': instance.page,
      'total_results': instance.total_results,
      'total_pages': instance.total_pages,
      'results': instance.results,
    };

ResultModel _$ResultModelFromJson(Map<String, dynamic> json) {
  return ResultModel(
    vote_count: json['vote_count'] as int,
    id: json['id'] as int,
    video: json['video'] as bool,
    vote_average: (json['vote_average'] as num)?.toDouble(),
    title: json['title'] as String,
    popularity: (json['popularity'] as num)?.toDouble(),
    poster_path: json['poster_path'] as String,
    original_language: json['original_language'] as String,
    original_title: json['original_title'] as String,
    genre_ids: (json['genre_ids'] as List)?.map((e) => e as int)?.toList(),
    backdrop_path: json['backdrop_path'] as String,
    adult: json['adult'] as bool,
    overview: json['overview'] as String,
    release_date: json['release_date'] as String,
  );
}

Map<String, dynamic> _$ResultModelToJson(ResultModel instance) =>
    <String, dynamic>{
      'vote_count': instance.vote_count,
      'id': instance.id,
      'video': instance.video,
      'vote_average': instance.vote_average,
      'title': instance.title,
      'popularity': instance.popularity,
      'poster_path': instance.poster_path,
      'original_language': instance.original_language,
      'original_title': instance.original_title,
      'genre_ids': instance.genre_ids,
      'backdrop_path': instance.backdrop_path,
      'adult': instance.adult,
      'overview': instance.overview,
      'release_date': instance.release_date,
    };
