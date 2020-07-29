

import 'package:flutter_test_app/src/model/movie_model.dart';
import 'package:flutter_test_app/src/network/movie_api.dart';

class Repository{

  final movieRepository = MovieApiProvider();

  Future<MovieModel> getAllMovie() => movieRepository.fetchMovie();
}