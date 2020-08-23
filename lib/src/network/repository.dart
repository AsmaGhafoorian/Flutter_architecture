

import 'package:flutter_test_app/src/model/chart_model.dart';
import 'package:flutter_test_app/src/model/movie_model.dart';
import 'package:flutter_test_app/src/network/movie_api.dart';

import 'package:inject/inject.dart';
import 'package:http/http.dart' as http;


class Repository{


  final http.Client client;

  @provide
  Repository(this.client);

  Future<dynamic> getAllMovie() => fetchMovie(client);
  Future<MovieModel> fetchTrailers(int movieId) => fetchTrailer(movieId);
  Future<dynamic> getChartData() => fetchChartData(client);
}