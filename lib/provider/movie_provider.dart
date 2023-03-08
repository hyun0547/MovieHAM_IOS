import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movieham_app/constants/constants_code.dart';

import '../models/api_result_model.dart';

class MovieProvider{

  static Future<List<Movie>?> getNotClassifiedMovies(int userId, String group, String groupKeyword, String countPerPage, String pageIndex) async {
    ApiResultModel apiResult;
    final response = await http.post(
      Uri.parse("http://127.0.0.1:8080/movie/notClassifiedList/${ConstantsCode.KrToCode(group)}/popularity"),
      body: <String, String> {
        'userId': '$userId',
        'countPerPage':countPerPage,
        'pageIndex':pageIndex,
        'groupKeyword': '${ConstantsCode.KrToCode(groupKeyword)}'
      },
    );

    if (response.statusCode == 200) {
      apiResult = ApiResultModel(jsonDecode(response.body));
      if(apiResult.status == "success") {
        return apiResult.movieList;
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