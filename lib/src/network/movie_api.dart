

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
          headers: {HttpHeaders.authorizationHeader: "wZwqdyPwwqC9Lxa2SoXT9sfj0GtyaZjnWvARdcXOe0Rjx3PflPkkvC0Wg1cfzJRV1Y8PeiUJTWC2DC4JkC73ftvCjb4ZBAQNgFfcNuzwLfCVuI3DzAbYA0bVk7GrvUElzkl7UVgvhJE84T9g8bTlekUxLmzc6DFNXxBWBnKn94FBg64M"});

      print(response.body.toString());

      if (response.statusCode == 200)
        return compute(parsMovie, response.body);
      else
        throw Exception('Failed to load post');
    }
