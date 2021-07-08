import 'package:flutter/material.dart';
import 'package:netflix_project/model/model_movie.dart';
import 'package:netflix_project/widget/carousel_slider.dart';

//영화의 data를 백엔드에서 가져와야하기 때문에 Stateful ->상태관리
class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

//기존의 main.dart의 home 화면부분 컨테이너를 아래의 코드들로 대체(덮어끼우는 느낌)-> override - screen/home_screen.dart
class _HomeScreenState extends State<HomeScreen> {
  //실제Movie모델을 선언하여 list로 더미 데이터를 만듬(추후 파이어베이스와 연동할때 실제로 가져오는 데이터를 그대로 처리하기 위해)
  List<Movie> movies = [
    Movie.fromMap({
      'title': '사랑의 불시착',
      'keyword': '사랑/로맨스',
      'poster': 'test_movie_1.png',
      'like': false
    }),
    Movie.fromMap({
      'title': '멋쟁이 사자',
      'keyword': '사랑/코미디',
      'poster': 'test_movie_1.png',
      'like': false
    }),
    Movie.fromMap({
      'title': '슬기로운 의사생활',
      'keyword': '로맨스',
      'poster': 'test_movie_1.png',
      'like': false
    }),
    Movie.fromMap({
      'title': '배고파',
      'keyword': '호러',
      'poster': 'test_movie_1.png',
      'like': false
    }),
  ];

  @override //override로 initState 가져오기
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        //스택 형태로
        Stack(
          children: <Widget>[
            CarouselImage(movies: movies), //캐러셀 이미지 -맨 위
            TopBar(), //아래 TopBar클래스 가져옴 -화면 구성!  - 아래
          ],
        )
      ],
    );
  }
}

//상단바는 home화면 내에만 있기때문에 따로 Widget폴더로 빼지않고 여기에 바로함
class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 7, 20, 7),
      child: Row(
        // mainAxisAlignment =원하는 형태로 간격조절 하고싶을때
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: <Widget>[
          Image.asset(
            'images/n_logo.jpg',
            fit: BoxFit.contain,
            height: 25,
          ),
          Container(
            padding: EdgeInsets.only(right: 1),
            child: Text(
              'TV 프로그램',
              style: TextStyle(fontSize: 14),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 1),
            child: Text(
              '영화',
              style: TextStyle(fontSize: 14),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 1),
            child: Text(
              '내가 찜한 콘텐츠',
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
