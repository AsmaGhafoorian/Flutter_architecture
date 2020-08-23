

import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/src/model/chart_model.dart';
import 'package:flutter_test_app/src/ui/home/home_container.dart';
import 'package:flutter_test_app/src/utils/app_exception.dart';
import 'package:flutter_test_app/src/utils/error_handling.dart';
import 'package:http/http.dart' as http;
import 'package:inject/inject.dart';

import 'package:flutter_test_app/src/model/movie_model.dart';


    dynamic parsMovie(dynamic response) {
      final data = json.decode(utf8.decode(response));
      print( data);

      return  MovieModel.fromJson(data);
    }

    @provide
    @singleton
    Future<dynamic> fetchMovie(http.Client client) async {
      var  data;
      try {
        final response = await client.get(
            "https://api-beta.asiatech.ir/api/v1/mobile/club",
            headers: {
              HttpHeaders
                  .authorizationHeader: "xmSPosG3hOmJS7hwKtOVBUZYJ7GQyZRdsxwprTPodnS9my5bckO8BXxj0pq4yviM8MNwxGZLtHS91l6SW2iAcY1CSnNMNscRzGwk4Zff8FXC05SfGOPKIilesnsj9RsRrwLs1RWPhDBAnlAbCesKCpqYi",
              'Content-Type': 'application/json'
            });

        data = ErrorHandling().returnResponse(response);
        if (response.statusCode == 200)
          return compute(parsMovie, data);
        else
          return data;
      } on SocketException {
          return ErrorHandling().checkConnectiviity();

     }
    }
    ////////////////////////////////////////////////////////////////////////////
    dynamic parsChartData(dynamic response) {
      final data = json.decode(utf8.decode(response));
      print( data);
      return  ChartModel.fromJson(data);
    }

    @provide
    @singleton
    Future<dynamic> fetchChartData(http.Client client) async{

//          final response = await client.get("https://api-test.asiatech.ir/api/vDev/test/graph/data");
//          if(response.statusCode == 200)
//            return compute(parsChartData, response.bodyBytes);
//          else
//            throw Exception('Failed to load post');

          var  data;
          try {
            final response = await client.get("https://api-test.asiatech.ir/api/vDev/test/graph/data");

            data = ErrorHandling().returnResponse(response);
            if (response.statusCode == 200)
              return compute(parsChartData, data);
            else
              return data;
          } on SocketException {
            return ErrorHandling().checkConnectiviity();

          }
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

