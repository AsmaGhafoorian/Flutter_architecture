

import 'package:flutter_test_app/src/model/movie_model.dart';
import 'package:flutter_test_app/src/network/repository.dart';
import 'package:rxdart/rxdart.dart';

class MoviesBloc {
  final _repository = Repository();
  final _moviesFetcher = PublishSubject<MovieModel>();

  Stream<MovieModel> get allMovies => _moviesFetcher.stream;

  fetchAllMovies() async {
    MovieModel itemModel = await _repository.getAllMovie();
    _moviesFetcher.sink.add(itemModel);
  }

  dispose() {
    _moviesFetcher.close();
  }
}

final bloc = MoviesBloc(); // single instance(singleton) of bloc that every class can access it

//https://medium.com/flutterpub/architect-your-flutter-project-using-bloc-pattern-part-2-d8dd1eca9ba5
// az in baraye scoped instance estefade kon bejaye singleton dar proje haye bozorg