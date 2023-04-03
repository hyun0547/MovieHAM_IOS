import 'dart:convert';

class MovieResult{

  late String status;
  late List<Movie> movieList;
  late String errorMessage;

  MovieResult(Map<String,dynamic>? response){
    if(response != null){
      if(response["error"] != null){
        status = "error";
        errorMessage = response['error'];
      }else{
        status = "success";
        movieList = List<Movie>.from(response['result'].map((item) => Movie.fromMap(item))?.toList());
      }
    }
  }
}

class Movie{

  late int movieId;

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

    movieId = map?['movieId']?? 0;
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
      peopleList = peopleList.where((item)
        => item.knownForDepartment == 'Directing' || item.knownForDepartment == 'Acting'
      ).toList();
      peopleList.sort((a, b)=>b.popularity.compareTo(a.popularity));
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


class WishResult{
  late String status;
  late List<Wish> wishList;
  late String errorMessage;

  WishResult(Map<String,dynamic>? response){
    if(response != null){
      if(response["error"] != null){
        status = "error";
        errorMessage = response['error'];
      }else{
        status = "success";
        wishList = List<Wish>.from(response['result'].map((item) => Wish.fromMap(item))?.toList());
      }
    }
  }
}

class Wish {

  late int userId;
  late int movieId;
  late String rating;
  late String regDate;
  late String modDate;
  late String review;
  late String seenYn;
  late String wishStatus;

  Wish.fromMap(Map<String, dynamic>? map){
    userId = map?['userId']??'';
    movieId = map?['movieId']??'';
    rating = map?['rating']??'';
    regDate = map?['regDate']??'';
    modDate = map?['modDate']??'';
    review = map?['review']??'';
    seenYn = map?['seenYn']??'';
    wishStatus = map?['wishStatus']??'';
  }

}