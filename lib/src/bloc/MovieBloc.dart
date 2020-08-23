

import 'dart:async';

import 'package:flutter_test_app/src/model/movie_model.dart';
import 'package:flutter_test_app/src/network/api_response.dart';
import 'package:flutter_test_app/src/network/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:inject/inject.dart';



// agar dar safhehaye mokhtalef bekhahim allMovei ro listen konim ba BehaviorSubject emkan pazir hast vali ba StreamController na.
//Apiresponse baraye in tarif shode ke betoonim Error coode haye mokhtalef ro begirim va message monaseb ro neshoon bedim.
@provide
class MoviesBloc {
  final Repository _repository ;
  StreamController _movieListController= BehaviorSubject<ApiResponse<MovieModel>>(); // BehaviorSubject is, by default, a broadcast (aka hot) controller, in order to fulfill the Rx Subject contract. This means the Subject's stream can be listened to multiple time
  StreamSink<ApiResponse<MovieModel>> get _moviesSink => _movieListController.sink;

  Stream<ApiResponse<MovieModel>> get allMovies => _movieListController.stream;
  MoviesBloc(this._repository);

  fetchAllMovies() async {
    _moviesSink.add(ApiResponse.loading('Fetching'));
    try {
      MovieModel itemModel = await _repository.getAllMovie();
      _moviesSink.add(ApiResponse.completed(itemModel));
    }catch(e){
      _moviesSink.add(ApiResponse.error(e.toString()));
    }
  }

  dispose() {
    _movieListController.close();
  }
}

 // single instance(singleton) of bloc that every class can access it

//https://medium.com/flutterpub/architect-your-flutter-project-using-bloc-pattern-part-2-d8dd1eca9ba5
// az in baraye scoped instance estefade kon bejaye singleton dar proje haye bozorg