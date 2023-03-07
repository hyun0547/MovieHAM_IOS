import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/api_result_model.dart';

class MovieProvider{

  static Future<Movie?> getNotClassifiedMovie(int userId) async {
    ApiResultModel apiResult;
    final response = await http.post(
      Uri.parse("https://movieapi.ssony.me/movie/notClassifiedList/all/popularity"),
      body: <String, String> {
        'userId': '$userId',
        'countPerPage':'1',
        'pageIndex':'0'
      },
    );

    if (response.statusCode == 200) {
      apiResult = ApiResultModel(jsonDecode(response.body));
      if(apiResult.status == "success") {
        return apiResult.movieList[0];
      }else{
        return null;
      }
    }

    return null;
  }

  static Future<bool> insertWish(
      {required String userId, required String movieId, required String seenYn, required String wishStatus}) async {
    final response = await http.post(
      Uri.parse("http://movieapi.ssony.me/wish/insert"),
      body: <String, String> {
        'userId': '$userId',
        'movieId': '$movieId',
        'seenYn': '$seenYn',
        'wishStatus': '$wishStatus'
      },
    );
    if(response.statusCode == 200){
      return true;
    }else{
      return false;
    }
  }

}