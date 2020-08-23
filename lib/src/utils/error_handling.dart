
import 'dart:io';
import 'package:http/http.dart' as http;
import 'app_exception.dart';

class ErrorHandling{

  Future<bool> checkConnectiviity() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
         throw FetchDataException('Error occured while Communication with Server');
      }
    } on SocketException catch (_) {
      throw FetchDataException('No Internet connection');
    }
  }

  dynamic returnResponse(http.Response response) {
    print(response.body.toString());
      switch (response.statusCode) {
        case 200:
          var responseJson = response.bodyBytes;
          return responseJson;
        case 400:
          throw BadRequestException(response.body.toString());
        case 401:
        case 403:
          throw UnauthorisedException(response.body.toString());
        case 500:
      }
  }


}