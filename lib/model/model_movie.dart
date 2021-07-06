class Movie {
  final String title;
  final String keyword;
  final String poster;
  final bool like;

  //Movie 클래스에 대한 fromMap메소드 정의
  Movie.fromMap(Map<String, dynamic> map)
      : title = map['title'],
        keyword = map['keyword'],
        poster = map['poster'],
        like = map['like'];

  //해당 클래스(인스턴스)를 print할때 용이하게 하기위해 override
  @override //toString()메소드 override
  String toString() => "Movie<$title:$keyword>";
}
