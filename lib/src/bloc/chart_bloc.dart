


import 'package:flutter_test_app/src/model/chart_model.dart';
import 'package:flutter_test_app/src/network/repository.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

@provide
@singleton
class ChartBloc{

  final Repository _repository;

  ChartBloc(this._repository);

  final _chartFetcher = PublishSubject<ChartModel>();

  Stream<ChartModel> get chart => _chartFetcher.stream;

  getChartData() async {
    ChartModel itemModel = await _repository.getChartData();
    _chartFetcher.sink.add(itemModel);
  }

  dispose() {
    _chartFetcher.close();
  }
}