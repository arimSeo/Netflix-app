import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:netflix_project/model/model_movie.dart';
import 'package:netflix_project/widget/box_slider.dart';
import 'package:netflix_project/widget/carousel_slider.dart';
import 'package:netflix_project/widget/circle_slider.dart';

//영화의 data를 백엔드에서 가져와야하기 때문에 Stateful ->상태관리
class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

//기존의 main.dart의 home 화면부분 컨테이너를 아래의 코드들로 대체(덮어끼우는 느낌)-> override - screen/home_screen.dart
class _HomeScreenState extends State<HomeScreen> {
//실제Movie모델을 선언하여 list로 더미 데이터를 만듬(추후 파이어베이스와 연동할때 실제로 가져오는 데이터를 그대로 처리하기 위해)
  // List<Movie> movies = [
  //   Movie.fromMap({
  //     'title': '사랑의 불시착',
  //     'keyword': '사랑/로맨스',
  //     'poster': 'test_movie_1.png',
  //     'like': false
  //   }),
  //   Movie.fromMap({
  //     'title': '멋쟁이 사자',
  //     'keyword': '사랑/코미디',
  //     'poster': '59.jpg',
  //     'like': false
  //   }),
  //   Movie.fromMap({
  //     'title': '슬기로운 의사생활',
  //     'keyword': '로맨스',
  //     'poster': 'sss.jpg',
  //     'like': false
  //   }),
  //   Movie.fromMap(
  //       {'title': '배고파', 'keyword': '호러', 'poster': 'uuu.jpg', 'like': false})
  // ];

//파이어베이스 연동 후
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late Stream<QuerySnapshot> streamData;

  @override //override로 initState 가져오기
  void initState() {
    super.initState();
    //Firebase 추가
    streamData = firestore.collection('Netflix movie').snapshots();
    //collection()안에는 컬렉션(테이블)이름
  }

  Widget _fetchData(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:
          FirebaseFirestore.instance.collection('Netflix movie').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return LinearProgressIndicator(); //데이터를 아직 가져오지 못했으면 ProgressIndicator로 로딩화면
        return _buildBody(context, snapshot.data!.documents);
      },
    );
  }

  Widget _buildBody(BuildContext context, List<DocumentSnapshot> snapshot) {
    List movies = snapshot.map((d) => Movie.fromSnapShot(d)).toList();
    //아래 Widget build(){ }에서 자리이동
    return ListView(
      children: <Widget>[
        //스택 형태로
        Stack(
          children: <Widget>[
            CarouselImage(movies: movies as List<Movie>), //캐러셀 이미지 -아래
            TopBar(), //아래 TopBar클래스 가져옴 -화면 구성!  - 맨 위
          ],
        ),
        CircleSlider(
          movies: movies,
        ), //circle_slider.dart에서 가져옴
        BoxSlider(movies: movies) //box_slider.dart에서 가져옴
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _fetchData(context);
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
