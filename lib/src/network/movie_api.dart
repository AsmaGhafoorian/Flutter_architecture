

import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:inject/inject.dart';

import 'package:flutter_test_app/src/model/movie_model.dart';


    MovieModel parsMovie(List<int> response) {
      final data = json.decode(utf8.decode(response));
      print( data);

      return  MovieModel.fromJson(data);
    }

    @provide
    Future<MovieModel> fetchMovie(http.Client client) async {
      final response = await client.get(
          "https://api-beta.asiatech.ir/api/v1/mobile/club",
          headers: {HttpHeaders.authorizationHeader: "RJuYQuY83Io15eLxkPnTOK0Ae3gm5Fk6ro8Dksl5ABP7w0jFEPrJvPfLEhblDfEFUmtf035uA6prDJxcKDJGKUQMgog2OlwrHGbqiVvj6Og1YVokR3IKmA09WA7bElnuQFVJdFSCi7t2kRD6IGGMDzHWImkfPGTa08gDvPYS3opFRpKgvtbagkhpfkDlLl1GfepSgI1EOdc2Xh8ImBEjNl4rtXw4iaaSYKio6oDu",
                    'Content-Type': 'application/json'});


      if (response.statusCode == 200)
        return compute(parsMovie, response.bodyBytes);
      else
        throw Exception('Failed to load post');
    }


Future<MovieModel> fetchTrailer(int movieId) async {
  http.Client client = http.Client();

  final response = await client.get("https://api-beta.asiatech.ir/api/v1/mobile/club");

  if (response.statusCode == 200) {
    return MovieModel.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  } else {
    throw Exception('Failed to load trailers');
  }
}