import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:movieham_app/constants/constants_code.dart';

import '../models/api_result_model.dart';

class MovieProvider {
  // static const String _baseUrl = 'https://movieapi.ssony.me';
  static const String _baseUrl = 'http://127.0.0.1:8080';

  static Future<List<Movie>?> getMovies(
      {int? userId,
      String? classifiedYn,
      required String group,
      required String groupKeyword,
      required String countPerPage,
      required String pageIndex
      }) async {
    try {
      final response = await http.post(
        headers:{"Content-Type": "application/json"},
        Uri.parse('$_baseUrl/movie/list/${ConstantsCode.KrToCode(group)}/popularity'),
        body: json.encode(
            {
              'countPerPage': countPerPage,
              'pageIndex': pageIndex,
              'groupKeyword': ConstantsCode.KrToCode(groupKeyword),
              'userId' : userId,
              'classifiedYn' : classifiedYn,
            }
        ),
      );

      if (response.statusCode == 200) {
        final apiResult = MovieResult(jsonDecode(response.body));
        return apiResult.status == 'success' ? apiResult.movieList : null;
      }

      return null;
    } catch (e) {
      print('Error in getMovies: $e');
      return null;
    }
  }

  static Future<Movie?> getMovie(int movieId) async {
    try {
      final response = await http.post(Uri.parse('$_baseUrl/movie/$movieId'));

      if (response.statusCode == 200) {
        final apiResult = MovieResult(jsonDecode(response.body));
        return apiResult.status == 'success' ? apiResult.movieList[0] : null;
      }

      return null;
    } catch (e) {
      print('Error in getMovie: $e');
      return null;
    }
  }

  static Future<bool> insertWish({required String userId, required String movieId, required String seenYn, required String wishStatus}) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/wish/insert'),
        body: <String, String>{
          'userId': '$userId',
          'movieId': '$movieId',
          'seenYn': '$seenYn',
          'wishStatus': '$wishStatus',
        },
      );
      return response.statusCode == 200;
    } catch (e) {
      print('Error in insertWish: $e');
      return false;
    }
  }

  static Future<Wish?> getWish({required int userId, required int movieId}) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/wish/view/$userId/$movieId'),
      );
      if(response.statusCode == 200){
        if(jsonDecode(response.body)['result'] != null){
          final apiResult = WishResult(jsonDecode(response.body));
          return apiResult.status == 'success'?apiResult.wish:null;
        }
        return null;
      }
    } catch (e) {
      print('Error in getWish: $e');
      return null;
    }
    return null;
  }

  static Future<bool> insertUser(User user) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/user/insert'),
      headers:{"Content-Type": "application/json"},
      body: json.encode({
        'id': user.id,
      })
    );
    if(response.statusCode == 200){
      return true;
    }
    return false;
  }
}