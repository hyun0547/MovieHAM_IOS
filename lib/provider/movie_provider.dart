import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movieham_app/constants/constants_code.dart';

import '../models/api_result_model.dart';

class MovieProvider {
  static const String _baseUrl = 'https://movieapi.ssony.me';

  static Future<List<Movie>?> getNotClassifiedMovies(int userId, String group, String groupKeyword, String countPerPage, String pageIndex) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/movie/notClassifiedList/${ConstantsCode.KrToCode(group)}/popularity'),
        body: <String, dynamic>{
          'userId': '$userId',
          'countPerPage': countPerPage,
          'pageIndex': pageIndex,
          'groupKeyword': ConstantsCode.KrToCode(groupKeyword),
        },
      );

      if (response.statusCode == 200) {
        final apiResult = ApiResultModel(jsonDecode(response.body));
        return apiResult.status == 'success' ? apiResult.movieList : null;
      }

      return null;
    } catch (e) {
      print('Error in getNotClassifiedMovies: $e');
      return null;
    }
  }

  static Future<List<Movie>?> getMovies(String group, String groupKeyword, String countPerPage, String pageIndex) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/movie/list/${ConstantsCode.KrToCode(group)}/popularity'),
        body: <String, dynamic>{
          'countPerPage': countPerPage,
          'pageIndex': pageIndex,
          'groupKeyword': ConstantsCode.KrToCode(groupKeyword),
        },
      );

      if (response.statusCode == 200) {
        final apiResult = ApiResultModel(jsonDecode(response.body));
        return apiResult.status == 'success' ? apiResult.movieList : null;
      }

      return null;
    } catch (e) {
      print('Error in getMovies: $e');
      return null;
    }
  }

  static Future<Movie?> getMovie(int groupKeyword) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/movie/$groupKeyword'));

      if (response.statusCode == 200) {
        final apiResult = ApiResultModel(jsonDecode(response.body));
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
}