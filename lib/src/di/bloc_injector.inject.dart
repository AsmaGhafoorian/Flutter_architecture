import 'bloc_injector.dart' as _i1;
import 'bloc_module.dart' as _i2;
import 'package:http/src/client.dart' as _i3;
import '../network/repository.dart' as _i4;
import 'dart:async' as _i5;
import '../../main.dart' as _i6;
import '../ui/home.dart' as _i7;
import '../bloc/MovieBloc.dart' as _i8;

class BlocInjector$Injector implements _i1.BlocInjector {
  BlocInjector$Injector._(this._blocModule);

  final _i2.BlocModule _blocModule;

  _i3.Client _singletonClient;

  _i4.Repository _singletonRepository;

  static _i5.Future<_i1.BlocInjector> create(_i2.BlocModule blocModule) async {
    final injector = BlocInjector$Injector._(blocModule);

    return injector;
  }

  _i6.App _createApp() => _i6.App(_createHome);
  _i7.Home _createHome() => _i7.Home(_createMoviesBloc());
  _i8.MoviesBloc _createMoviesBloc() =>
      _blocModule.movieBloc(_createRepository());
  _i4.Repository _createRepository() =>
      _singletonRepository ??= _blocModule.repository(_createClient());
  _i3.Client _createClient() => _singletonClient ??= _blocModule.client();
  @override
  _i6.App get app => _createApp();
}
