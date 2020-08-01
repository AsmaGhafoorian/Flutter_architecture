

import 'package:flutter_test_app/src/model/movie_model.dart';
import 'package:flutter_test_app/src/network/movie_api.dart';

class Repository{


  Future<MovieModel> getAllMovie() => fetchMovie();
  Future<MovieModel> fetchTrailers(int movieId) => fetchTrailer(movieId);

}