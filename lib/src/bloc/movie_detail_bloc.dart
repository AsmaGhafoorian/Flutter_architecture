import 'package:flutter_test_app/src/model/movie_model.dart';
import 'package:flutter_test_app/src/network/repository.dart';
import 'package:http/http.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

class MovieDetailBloc {
//  http.Client client = Client();
//  final _repository = Repository(client);
//  final _movieId = PublishSubject<int>();
//  final _trailers = BehaviorSubject<Future<MovieModel>>();
//
//  Function(int) get fetchTrailersById => _movieId.sink.add;
//  Stream<Future<MovieModel>> get movieTrailers => _trailers.stream;
//
//  MovieDetailBloc() {
//    _movieId.stream.transform(_itemTransformer()).pipe(_trailers);
//  }
//
//  dispose() async {
//    _movieId.close();
//    await _trailers.drain();
//    _trailers.close();
//  }
//
//  _itemTransformer() {
//    return ScanStreamTransformer(
//          (Future<MovieModel> trailer, int id, int index) {
//        print(index);
//        trailer = _repository.fetchTrailers(id);
//        return trailer;
//      },
//    );
//  }
}
