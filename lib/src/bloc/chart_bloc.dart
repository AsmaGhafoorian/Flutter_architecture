


import 'dart:async';

import 'package:flutter_test_app/src/model/chart_model.dart';
import 'package:flutter_test_app/src/model/movie_model.dart';
import 'package:flutter_test_app/src/network/api_response.dart';
import 'package:flutter_test_app/src/network/repository.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

@provide
@singleton
class ChartBloc{

  final Repository _repository;

  ChartBloc(this._repository);
  StreamController _chartController= BehaviorSubject<ApiResponse<ChartModel>>();
  StreamSink<ApiResponse<ChartModel>> get _chartSink => _chartController.sink;

  Stream<ApiResponse<ChartModel>> get chart => _chartController.stream;

  getChartData() async {
    _chartSink.add(ApiResponse.loading('Fetching'));
    try {
      ChartModel itemModel = await _repository.getChartData();
      _chartSink.add(ApiResponse.completed(itemModel));
    }catch(e){
      _chartSink.add(ApiResponse.error(e.toString()));
    }
  }

  dispose() {
    _chartController.close();
  }
}