import 'dart:convert';

import 'package:http/http.dart' as http;

class MovieProvider{

  static Future<Movie> getMovie(movieSeq) async {
    var movie = null;
    return movie;
  }

  static Future<List<Movie>> getCategorisedMovie(
      {category, keywords, pageIndex, countPerPage}) async {
    var movies = null;
    final response = await http.get(Uri.parse("http://localhost:8080/movieHam/api/movie/search/$category?keywords=$keywords&required=posterPath&pageIndex=$pageIndex&countPerPage=$countPerPage"));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if(data["error"] != null){
        return movies;
      }
      if(data['resultList'].length > 0) {
        movies = data['resultList'].map<Movie>( (movie) {
          return Movie.fromMap(movie);
        }).toList();
      }
    }
    return movies;
  }


}

class Movie{

  late int movieId;

  late bool adult;
  late String backdropPath;
  late String originalLanguage;
  late String originalTitle;
  late String overview;
  late double popularity;
  late String posterPath;
  late String releaseDate;
  late String title;
  late double voteAverage;
  late int voteCount;

  late List<Genre> genreList;
  late List<People> peopleList;

  Movie({
    required this.title,
    required this.movieId
  });

  Movie.fromMap(Map<String, dynamic>? map) {

    movieId = map?['movieId']?? '';
    adult = map?['adult']?? '';
    backdropPath = map?['backdropPath']?? '';
    originalLanguage = map?['originalLanguage']?? '';
    originalTitle = map?['originalTitle']?? '';
    overview = map?['overview']?? '';
    popularity = map?['popularity']?? '';
    posterPath = map?['posterPath']?? '';
    releaseDate = map?['releaseDate']?? '';
    title = map?['title']?? '';
    voteAverage = map?['voteAverage']?? '';
    voteCount = map?['voteCount']?? '';

    (map?['genreList'] as List)?.map((item) => Genre.fromMap(item))?.toList();
    (map?['peopleList'] as List)?.map((item) => People.fromMap(item))?.toList();

  }
}

class Genre {
  late int genreId;
  late String name;

  Genre.fromMap(Map<String,dynamic>? map){
    genreId = map?['genreId']?? '';
    name = map?['name']?? '';
  }
}

class People {

  late int peopleId;

  late bool adult;
  late int gender;
  late String knownForDepartment;
  late String name;
  late String originalName;
  late double popularity;
  late String profilePath;
  late String job;

  People.fromMap(Map<String, dynamic>? map) {
    peopleId = map?['peopleId']?? '';
    adult = map?['adult']?? '';
    gender = map?['gender']?? '';
    knownForDepartment = map?['knownForDepartment']?? '';
    name = map?['name']?? '';
    originalName = map?['originalName']?? '';
    popularity = map?['popularity']?? '';
    profilePath = map?['profilePath']?? '';
    job = map?['job']?? '';
  }
}