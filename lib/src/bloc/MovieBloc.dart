

import 'dart:async';

import 'package:flutter_test_app/src/model/movie_model.dart';
import 'package:flutter_test_app/src/network/api_response.dart';
import 'package:flutter_test_app/src/network/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:inject/inject.dart';

@provide
class MoviesBloc {
  final Repository _repository ;
  StreamSink<ApiResponse<MovieModel>> get _moviesFetcher => _movieListController.sink;
  StreamController _movieListController= StreamController<ApiResponse<MovieModel>>();

  Stream<ApiResponse<MovieModel>> get allMovies => _movieListController.stream;
  MoviesBloc(this._repository);

  fetchAllMovies() async {
    try {
      MovieModel itemModel = await _repository.getAllMovie();
      _moviesFetcher.add(ApiResponse.completed(itemModel));
    }catch(e){
      _moviesFetcher.add(ApiResponse.error(e.toString()));
    }
  }

  dispose() {
    _movieListController.close();
  }
}

 // single instance(singleton) of bloc that every class can access it

//https://medium.com/flutterpub/architect-your-flutter-project-using-bloc-pattern-part-2-d8dd1eca9ba5
// az in baraye scoped instance estefade kon bejaye singleton dar proje haye bozorg