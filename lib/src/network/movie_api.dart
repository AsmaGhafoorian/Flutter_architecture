

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
          headers: {HttpHeaders.authorizationHeader: "cd8St4CBUQfxxzeaRbfhzirtHv7keEQkc3C8J1AytGgZtA1xJXXigqlzjBcFoh4clNdPEZBsN3aXE5OoQ9Y1eEonPiQCObM8XSvwr42euxljsp4TX0RRgkDX8rRxXymCA8FOdIjRV24E79I0oxXjFVPPNUHzqqQTIFIizk5",
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