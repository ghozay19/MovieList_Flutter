import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NowPlayingFragment extends StatefulWidget {
  _NowPlayingFragmentState createState() => _NowPlayingFragmentState();
}

class _NowPlayingFragmentState extends State<NowPlayingFragment> {
 
  var movies;
  Color mainColor = const Color(0xff3C3261);

  //fetchData
  void getData() async{
    var data = await getJson();

    setState(() {
          movies = data['results'];
        });
  }

  @override
  Widget build(BuildContext context) {
    getData();

    return new Scaffold(
      backgroundColor: Colors.white,

      body: new Padding(
        padding: const EdgeInsets.all(16.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Expanded(
              child: new ListView.builder(
                itemCount: movies == null ? 0 : movies.length,
                itemBuilder: (context, i){
                  return new FlatButton(

                    child: new MovieCell(movies,i),
                    padding: const EdgeInsets.all(0.0),
                    color: Colors.white,
                  );
                }
              ),
            )
          ],
        ),
      ),
    )
    ;
  }
}

class MovieCell extends StatelessWidget {

  final movies;
  final i;

  Color mainColor = const Color(0xff3C3261);
  var image_url = 'https://image.tmdb.org/t/p/w500/';
  MovieCell(this.movies,this.i);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        new Row(
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.all(0.0),
              child: new Container(
                margin: const EdgeInsets.all(16.0),
                child: new Container(
                  width: 70.0,
                  height: 70.0,
                ),
              decoration: new BoxDecoration(
                borderRadius: new BorderRadius.circular(10.0),
                color: Colors.grey,
                image: new DecorationImage(
                  image: new NetworkImage(
                      image_url + movies[i]['poster_path']),
                  fit: BoxFit.cover),
                boxShadow: [
                  new BoxShadow(
                    color: mainColor,
                    blurRadius: 5.0,
                    offset: new Offset(2.0, 5.0))
                  ],
                ),
              ),
            ),
            new Expanded(

                child: new Container(
                  margin: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                  child: new Column(children: <Widget>[
                    new Text(
                      movies[i]['title'],
                      style: new TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Arvo',
                        fontWeight: FontWeight.bold,
                        color: mainColor),
                    ),
                    new Padding(padding: const EdgeInsets.all(2.0),),
                    new Text(movies[i]['overview'],
                    maxLines: 3,
                    style: new TextStyle(
                      color: const Color(0xff8785A4),
                      fontFamily: 'Arvo'
                    ),)
                  ],
                    crossAxisAlignment: CrossAxisAlignment.start,),
                )
            ),
          ],
        ),
        new Container(
          width: 300.0,
          height: 0.5,
          color: const Color(0xD2D2E1ff),
          margin: const EdgeInsets.all(16.0),
        )
      ],
    );

  }

}

// class MovieTitle extends StatelessWidget {
  
//   final Color mainColor;
//   MovieTitle(this.mainColor);

//   @override
//   Widget build(BuildContext context) {
//     return new Padding(
//       padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
//       child: new Text(
//         'Now Playing',
//         style: new TextStyle(
//           fontSize: 40.0,
//           color: mainColor,
//           fontWeight: FontWeight.bold,
//           fontFamily: 'Arvo'
//         ),
//         textAlign: TextAlign.left,
//       ),
      
//     );
//   }
// }

Future<Map> getJson() async {
  var url =
      'https://api.themoviedb.org/3/movie/now_playing?api_key=ed1f1b69630ec5a7109bca52edb898f9&language=en-EN';
  http.Response response = await http.get(url);
  return json.decode(response.body);
}