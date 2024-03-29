class ConstantsCode {
  static final Map<String, String> KrToCodeMap =
  {
    "인지도": "popularity",
    "언어": "originalLanguage",
    "장르": "genre",
    "한국어": "ko",
    "영어": "en",
    "일본어": "ja",
    "전체": "all",
    "개봉연도": "releaseYear",
    "배우": "actor",
    "감독": "director",
    "제목": "title"
  };

  static String? KrToCode(String target){
    return KrToCodeMap[target] == null ? target : KrToCodeMap[target];
  }
}