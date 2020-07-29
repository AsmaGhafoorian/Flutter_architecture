

import 'package:flutter_test_app/src/model/movie_model.dart';
import 'package:flutter_test_app/src/network/repository.dart';
import 'package:rxdart/rxdart.dart';

class MovieBloc{

  final  repository = Repository();

  // ignore: close_sinks
  final moviesFetcher = PublishSubject<MovieModel>();  //RxDart. PublishSubject : responsibility is to add the data which it got from the server in the form of ItemModel object and pass it to the UI screen as a stream

  Stream<MovieModel> get allMovie => moviesFetcher.stream;

  fetchAllMovie() async {
    MovieModel data = await repository.getAllMovie();
    moviesFetcher.sink.add(data);
  }
  dispose() {
    moviesFetcher.close();
  }
}
final bloc = MovieBloc();

