import 'dart:convert';

import 'package:http/http.dart' as http;

class MovieProvider{
  static Uri uri = Uri.parse("http://localhost:8080/movieHam/api/movie/search/docid?keywords=F57692");

  static Future<List<Movie>> getMovie() async {
    List<Movie> movies = [];

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      // Map to Object 에 문제가 있음
      movies = jsonDecode(response.body)['resultList'].map<Movie>( (article) {
        return Movie.fromMap(article);
      }).toList();
      print(response.body);
    }

    return movies;
  }


}

class Movie{
  late String docid;            // 영화코드

  late String movieId;          // ID
  late String movieSeq;         // SEQ
  late String title;            // 제목
  late String titleEng;         // 영문제명
  late String prodYear;         // 제작년도
  late String nation;           // 국가
  late String company;          // 제작사
  late String plotKor;          // 줄거리
  late String plotEng;          // 줄거리(영문)
  late String runtime;          // 러닝타임
  late String rating;           // 관람등급
  late String genre;            // 장르
  late String type;             // 유형구분
  late String useClassification;      // 용도구분
  late String ratedYn;          // 심의여부
  late String repRatDate;       // 심의날짜
  late String repRlsDate;       // 개봉일
  late String keywords;         // 키워드
  late String posters;          // 포스터URL
  late String stlls;            // 스틸샷URL
  late String openThtr;         // 개봉극장
  late String awards1;          // 수상내역1
  late String awards2;          // 수상내역2
  late String regDate;          // 등록일
  late String modDate;          // 수정일

  late List<Actor> actorList;
  late List<Director> directorList;

  Movie({
    required this.title,
    required this.docid
  });

  Movie.fromMap(Map<String, dynamic>? map) {
    docid = map?['docid'] ?? '';
    movieId = map?['movieId'] ?? '';
    movieSeq = map?['movieSeq'] ?? '';
    title = map?['title'] ?? '';
    titleEng = map?['titleEng'] ?? '';
    prodYear = map?['prodYear'] ?? '';
    nation = map?['nation'] ?? '';
    company = map?['company'] ?? '';
    plotKor = map?['plotKor'] ?? '';
    plotEng = map?['plotEng'] ?? '';
    runtime = map?['runtime'] ?? '';
    rating = map?['rating'] ?? '';
    genre = map?['genre'] ?? '';
    type = map?['type'] ?? '';
    useClassification = map?['useClassification'] ?? '';
    ratedYn = map?['ratedYn'] ?? '';
    repRatDate = map?['repRatDate'] ?? '';
    repRlsDate = map?['repRlsDate'] ?? '';
    keywords = map?['keywords'] ?? '';
    posters = map?['posters'] ?? '';
    stlls = map?['stlls'] ?? '';
    openThtr = map?['openThtr'] ?? '';
    awards1 = map?['awards1'] ?? '';
    awards2 = map?['awards2'] ?? '';
    regDate = map?['regDate'] ?? '';
    modDate = map?['modDate'] ?? '';

    (map?['actorList'] as List)?.map((item) => Actor.fromMap(item))?.toList();

  }
}

class Director {
  late String directorId;                 // 감독코드

  late String directorNm;                 // 감독명
  late String directorEnNm;

  Director.fromMap(Map<String, dynamic>? map) {
    directorId = map?['directorId'] ?? '';
    directorNm = map?['directorNm'] ?? '';
    directorEnNm = map?['directorEnNm'] ?? '';
  }
}

class Actor {
  late String actorId;                // 배우코드

  late String actorNm;                // 배우명
  late String actorEnNm;              // 배우영문명

  Actor.fromMap(Map<String, dynamic>? map) {
    actorId = map?['actorId'] ?? '';
    actorNm = map?['actorNm'] ?? '';
    actorEnNm = map?['actorEnNm'] ?? '';
  }
}