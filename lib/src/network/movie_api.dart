

import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:inject/inject.dart';

import 'package:flutter_test_app/src/model/movie_model.dart';


    MovieModel parsMovie(String response) {
      final data = json.decode(response);
      return  MovieModel.fromJson(data);
    }

    @provide
    Future<MovieModel> fetchMovie(http.Client client) async {
      final response = await client.get(
          "https://api-beta.asiatech.ir/api/v1/mobile/club",
          headers: {HttpHeaders.authorizationHeader: "enJ8J3MHpsJx0bMX9MMjCdMSKcFQK0TJubo6YNQaPxrWuKhiv8nqXGEdFOlC97RskU80hpBeimSkZspTkdMn3QOUC0QtMpV1GnByBMEiYzpZP1SntS7BuZruk8ctp6usVhcVyBO4LluG2S2h2oET0cw7rZ2gLsarm8C8l2BCApBq5rNRPBNoKzGLERFnpNPnLxOdMx7YaoFV"});

      print(response.body.toString());

      if (response.statusCode == 200)
        return compute(parsMovie, response.body);
      else
        throw Exception('Failed to load post');
    }


Future<MovieModel> fetchTrailer(int movieId) async {
  http.Client client = http.Client();

  final response = await client.get("https://api-beta.asiatech.ir/api/v1/mobile/club");

  if (response.statusCode == 200) {
    return MovieModel.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load trailers');
  }
}