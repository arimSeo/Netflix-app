import 'dart:html';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:netflix_project/model/model_movie.dart';

class CarouselImage extends StatefulWidget {
  List<Movie> movies;
  //CarouselImage의 생성자로 movies가져옴
  CarouselImage({required this.movies}); //CarouselImage({this.movies});
  //_CarouselImage에 대한 상태관리
  _CarouselImageState createState() => _CarouselImageState();
}

//_CarouselImageState 선언
class _CarouselImageState extends State<CarouselImage> {
  late List<Movie> movies;
  late List<Widget> images;
  late List<String> keywords;
  late List<bool> likes; //찜하기 버튼

  int _currentPage = 0; // CarouselImage에서 어느 위치에 있는지 index저장
  late String _currentKeyword; //그 페이지에 기록되어 있는 현재 keyword

  @override
  void initState() {
    super.initState();
    movies = widget.movies; //state로 관리하는 변수들의 초기값 선언
    //movies로 부터 원하는 값들만 모아 리스트 형태로 만듦
    images = movies.map((m) => Image.asset('./images/' + m.poster)).toList();
    keywords = movies.map((m) => m.keyword).toList();
    likes = movies.map((m) => m.like).toList();
    _currentKeyword = keywords[0]; //초기값 선언
  }

//실제 위젯디자인
  @override
  Widget build(BuildContext context) {
    return Container(
        // 컬럼형태로
        child: Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(20),
        ),
        //페이지 전환
        CarouselSlider(
          items: images,
          options: CarouselOptions(
            onPageChanged: (index, reason) {
              setState(() {
                _currentPage = index;
                _currentKeyword = keywords[_currentPage];
              });
            },
          ),
        ), //carouselSlider선언
        //콘텐츠 설명(장르 키워드)
        Container(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 3),
          child: Text(
            _currentKeyword,
            style: TextStyle(fontSize: 11),
          ),
        ),
        //메뉴바
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    likes[_currentPage]
                        ? IconButton(
                            icon: Icon(Icons.check), //찜하기 클릭시 체크아이콘으로(true면)
                            onPressed: () {},
                          )
                        : IconButton(
                            icon:
                                Icon(Icons.add), //(default:false)찜하기 버튼-add아이콘
                            onPressed: () {},
                          ),
                    Text(
                      '내가 찜한 콘텐츠',
                      style: TextStyle(fontSize: 11),
                    ),
                  ],
                ),
              ),
              //재생 버튼
              Container(
                padding: EdgeInsets.only(right: 10),
                child: TextButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white)),
                  onPressed: () {},
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.play_arrow,
                        color: Colors.black,
                      ),
                      Padding(
                        padding: EdgeInsets.all(3),
                      ),
                      Text(
                        '재생',
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 10),
                child: Column(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.info),
                      onPressed: () {},
                    ),
                    Text(
                      '정보',
                      style: TextStyle(fontSize: 11),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        //indicator
        Container(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: makeIndicator(likes, _currentPage),
        )),
      ],
    ));
  }
}

//indicator
List<Widget> makeIndicator(List list, int _currentPage) {
  List<Widget> results = [];
  for (var i = 0; i < list.length; i++) {
    results.add(Container(
      width: 8,
      height: 8,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _currentPage == i //삼항연산자
              ? Color.fromRGBO(255, 255, 255, 0.9)
              : Color.fromRGBO(255, 255, 255, 0.4)),
    ));
  }
  return results;
}
