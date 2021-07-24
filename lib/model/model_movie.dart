import 'package:cloud_firestore/cloud_firestore.dart';

class Movie {
  final String title;
  final String keyword;
  final String poster;
  final bool like;
  //Firebase firestore에 있는 데이터 컬럼을 참조할 수 있는 링크
  //reference를 이용해 해당 데이터에 대한 CRUD기능을 간단히 처리 가능
  final DocumentReference reference;

  //Movie 클래스에 대한 fromMap메소드 정의
  Movie.fromMap(Map<String, dynamic> map, {required this.reference})
      : title = map['title'],
        keyword = map['keyword'],
        poster = map['poster'],
        like = map['like'];

//firebase연동시 추가
  Movie.fromSnapShot(DocumentSnapshot snapshot) //메소드
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  //해당 클래스(인스턴스)를 print할때 용이하게 하기위해 override
  @override //toString()메소드 override
  String toString() => "Movie<$title:$keyword>";
}
