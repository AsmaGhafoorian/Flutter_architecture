

import 'package:flutter_test_app/src/ui/home/chart.dart';
import 'package:http/http.dart';
import 'package:inject/inject.dart';

import '../bloc/MovieBloc.dart';
import '../network/repository.dart';

@module
class BlocModule{

  @provide
  @singleton
  Client client() => Client();

  @provide
  @singleton
  Repository repository( Client client) => Repository(client);

  @provide
  MoviesBloc movieBloc(Repository repository) => MoviesBloc(repository);

  @provide
  @singleton
  Chart chart(MoviesBloc movieBloc) => Chart(movieBloc);
}
