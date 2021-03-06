import 'package:flutter/material.dart';
import 'package:netflix_project/model/model_movie.dart';
import 'package:netflix_project/screen/detail_screen.dart';

class BoxSlider extends StatelessWidget {
  //홈화면(screen)에서 movies를 받아오기 위해 생성자로 가져오기
  final List<Movie> movies;
  BoxSlider({required this.movies});
  //
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('지금 뜨는 콘텐츠'),
          Container(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: makeBoxImages(context, movies),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> makeBoxImages(BuildContext context, List<Movie> movies) {
    List<Widget> results = [];
    for (var i = 0; i < movies.length; i++) {
      //InkWell : results에 들어가는 위젯-> 추후에 클릭 가능하게 만듦
      results.add(InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute<Null>(
              fullscreenDialog: true,
              builder: (BuildContext context) {
                return DetailScreen(
                  //movie데이터가 파라미터로 전달-> detail_screen.dart화면 등장
                  movie: movies[i],
                );
              }));
        },
        child: Container(
          padding: EdgeInsets.only(right: 10, top: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Image.network(movies[i].poster),
          ),
        ),
      ));
    }
    return results;
  }
}
