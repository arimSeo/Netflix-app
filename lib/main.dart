import 'package:flutter/material.dart';
import 'package:netflix_project/screen/home_screen.dart';
import 'package:netflix_project/screen/more_screen.dart';
import 'package:netflix_project/screen/search_screen.dart';
import 'package:netflix_project/widget/bottom_bar.dart';

void main() => runApp(MyApp());

//상태관리 위젯
class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState(); //MyApp에 대한 상태관리
}

class _MyAppState extends State<MyApp> {
  @override //widget build 함수 만들기
  Widget build(BuildContext context) {
    //기본적인 MaterialApp 작성
    return MaterialApp(
        title: 'Netflix',
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.black,
          accentColor: Colors.white,
        ), //테마데이터-전반적인 색감/테마
        //home : DefaultTabController로 관리
        home: DefaultTabController(
          length: 4, //length: TabBar의 길이/갯수
          child: Scaffold(
            body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              //children: []안에 ->넣고싶은 화면구성-body부분
              children: <Widget>[
                // Container(
                //   child: Center(
                //     child: Text('home'),
                //   ),
                // ),
                //위 코드를 아래 HomeScreen()함수 (home_screen.dart에 지정)로 대체
                HomeScreen(),

                // Container(
                //   child: Center(
                //     child: Text('search'),
                //   ),
                // ),
                //위 코드를 아래 SearchScreen()함수로 대체 -search_screen.dart
                SearchScreen(),

                Container(
                  child: Center(
                    child: Text('save'),
                  ),
                ),

                MoreScreen()
                // Container(
                //   child: Center(
                //     child: Text('more'),
                //   ),
                // ),
              ],
            ),

            // Bottom(): widget/bottom_bar.dart를 import해서 사용
            bottomNavigationBar: Bottom(),
          ),
        ));
  }
}
