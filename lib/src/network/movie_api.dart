

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
        data = _returnResponse(response);
        if (response.statusCode == 200)
          return compute(parsMovie, data);
        else
          return data;
      } on SocketException {
       throw FetchDataException('No Internet connection');
     }

//      if (response.statusCode == 200) {



//      }
//      else {
//        bool connectivity = await ErrorHandling().checkConnectiviity();
//        if(connectivity){
//
//      }
//        else
//          throw Exception(connectivity.toString());


//      }
    }
    ////////////////////////////////////////////////////////////////////////////
      dynamic _returnResponse(http.Response response)  {
        switch (response.statusCode) {
          case 200:
            var responseJson = response.bodyBytes;
            print(responseJson);
            return responseJson;
          case 400:
            throw BadRequestException(response.body.toString());
          case 401:
          case 403:
            throw UnauthorisedException(response.body.toString());
          case 500:
          default:
//              bool connectivity = await ErrorHandling().checkConnectiviity();
//                 if(connectivity)
                    throw FetchDataException('Error occured while Communication with Server with StatusCode : ${response.statusCode}');
//                 else
//                   throw NetworkException('Connection failed : ${response.statusCode}');

        }
      }

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

