

import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_test_app/src/model/movie_model.dart';


  class MovieApiProvider {

    MovieModel parsMovie(String response) {
      final data = json.decode(response).cast<Map<String, dynamic>>();
      return data.map<MovieModel>((json) => MovieModel.fromJson(json));
    }

    Future<MovieModel> fetchMovie() async {
      http.Client client;
      final response = await client.get(

          "https://api.themoviedb.org/3/movie/550?api_key=b3f2a364585013211a4462d5c408b143",
          headers: {HttpHeaders.authorizationHeader: "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiM2YyYTM2NDU4NTAxMzIxMWE0NDYyZDVjNDA4YjE0MyIsInN1YiI6IjVmMjE1MGNmNWIxMjQwMDAzNDIxZWM4NiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.T7fX5C7P_vFPG7B4zKdh5bjWVsYttd0r9W8T3BHpqDw"});

      print(response.body.toString());

      if (response.statusCode == 200)
        return compute(parsMovie, response.body);
      else
        throw Exception('Failed to load post');
    }
  }