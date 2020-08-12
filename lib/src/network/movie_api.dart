

import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_test_app/src/model/chart_model.dart';
import 'package:flutter_test_app/src/ui/home/home_container.dart';
import 'package:http/http.dart' as http;
import 'package:inject/inject.dart';

import 'package:flutter_test_app/src/model/movie_model.dart';


    MovieModel parsMovie(List<int> response) {
      final data = json.decode(utf8.decode(response));
      print( data);

      return  MovieModel.fromJson(data);
    }

    @provide
    @singleton
    Future<MovieModel> fetchMovie(http.Client client) async {
      final response = await client.get(
          "https://api-beta.asiatech.ir/api/v1/mobile/club",
          headers: {HttpHeaders.authorizationHeader: "eA2vDCfhxsoahFl5tDoFJZJVeSrI6gh6MHIrV7pCYqpdN7GJ0EIBSSLqmAOXAELoCsk1lyhszEv3LBWo2s7sKbUEFoDHsxbZOHhzS8Sw6422Qi5ZYEvtRntEl83VSO8bamI4b",
                    'Content-Type': 'application/json'});


      if (response.statusCode == 200)
        return compute(parsMovie, response.bodyBytes);
      else
        throw Exception('Failed to load post');
    }
    ////////////////////////////////////////////////////////////////////////////


    ChartModel parsChartData(List<int> response) {
      final data = json.decode(utf8.decode(response));
      print( data);
      return  ChartModel.fromJson(data);
    }

    @provide
    @singleton
    Future<ChartModel> fetchChartData(http.Client client) async{

          final response = await client.get("https://api-test.asiatech.ir/api/vDev/test/graph/data");
          if(response.statusCode == 200)
            return compute(parsChartData, response.bodyBytes);
          else
            throw Exception('Failed to load post');
    }
    ////////////////////////////////////////////////////////////////////////////


    Future<MovieModel> fetchTrailer(int movieId) async {
      http.Client client = http.Client();

      final response = await client.get("https://api-beta.asiatech.ir/api/v1/mobile/club");

      if (response.statusCode == 200) {
        return MovieModel.fromJson(json.decode(utf8.decode(response.bodyBytes)));
      } else {
        throw Exception('Failed to load trailers');
      }
    }
