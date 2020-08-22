

import 'package:flutter_test_app/src/bloc/chart_bloc.dart';
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
  @singleton
  MoviesBloc movieBloc(Repository repository) => MoviesBloc(repository);

  @provide
  @singleton
  ChartBloc chartBloc(Repository repository) => ChartBloc(repository);

  @provide
  @singleton
  Chart chart(MoviesBloc movieBloc, ChartBloc chartBloc) => Chart(chartBloc);
}
