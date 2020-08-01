

import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_test_app/src/model/movie_model.dart';


    MovieModel parsMovie(String response) {
      final data = json.decode(response);
      return  MovieModel.fromJson(data);
    }

    Future<MovieModel> fetchMovie() async {
      http.Client client = http.Client();
      final response = await client.get(
          "https://api-beta.asiatech.ir/api/v1/mobile/club",
          headers: {HttpHeaders.authorizationHeader: "51JJo8rDOYfFi0OsbcDykD1b9BOEYi2KVeNSh4RiWWvqLxtL0D64seAxEY4HSyypWo5pMOeLquumw87eebWczBmE3S7yG8tTMB1e8o0vLjwA5RNzeQxxzNpOqMl2jKvIvzUjjDD7wJDQrNl8OCi5DGrFvEUgFVH7170URU2i0FYcbQB8ZOI3WBfnmJ2vIZBCXmIr"});

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