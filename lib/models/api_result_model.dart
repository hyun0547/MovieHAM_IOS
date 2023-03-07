import 'dart:convert';

class ApiResultModel{
  ApiResultModel(Map<String,dynamic>? response){
    if(response != null){
      if(response["error"] != null){
        status = "error";
        errorMessage = response['error'];
      }else{
        status = "success";
        movieList = List<Movie>.from(response['resultList'].map((item) => Movie.fromMap(item))?.toList());
      }
    }
  }

  late String status;
  late List<Movie> movieList;
  late String errorMessage;
}

class Movie{

  late String movieId;

  late String adult;
  late String backdropPath;
  late String originalLanguage;
  late String originalTitle;
  late String overview;
  late String popularity;
  late String posterPath;
  late String releaseDate;
  late String title;
  late String voteAverage;
  late String voteCount;

  late List<Genre> genreList;
  late List<People> peopleList;

  Movie({
    required this.title,
    required this.movieId
  });

  Movie.fromMap(Map<String, dynamic>? map) {

    movieId = map?['movieId']?.toString()?? '';
    adult = map?['adult']?.toString()?? '';
    backdropPath = map?['backdropPath']?.toString()?? '';
    originalLanguage = map?['originalLanguage']?.toString()?? '';
    originalTitle = map?['originalTitle']?.toString()?? '';
    overview = map?['overview']?.toString()?? '';
    popularity = map?['popularity']?.toString()?? '';
    posterPath = map?['posterPath']?.toString()?? '';
    releaseDate = map?['releaseDate']?.toString()?? '';
    title = map?['title']?.toString()?? '';
    voteAverage = map?['voteAverage']?.toString()?? '';
    voteCount = map?['voteCount']?.toString()?? '';

    if(map?['genreList'] != null){
      genreList = List<Genre>.from(map?['genreList']?.map((item) => Genre.fromMap(item))?.toList());
    }
    if(map?['peopleList'] != null){
      peopleList = List<People>.from(map?['peopleList']?.map((item) => People.fromMap(item))?.toList());
    }
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