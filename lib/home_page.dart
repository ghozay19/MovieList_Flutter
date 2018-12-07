import 'package:flutter/material.dart';
import 'package:movie_apps/fragments/now_fragment.dart';
import 'package:movie_apps/fragments/up_fragment.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _pageState = 0;
  var _appBarTitle = 'Now Playing';

  void updatePage(int page , String title){
    setState(() {
      _pageState = page;
      _appBarTitle = title;
    });
  }

  Widget body(){
    switch(_pageState){
      case 0: return UpComingFragment();
      case 1: return NowPlayingFragment();
      default: return UpComingFragment();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
      ),
      body: body(),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            Container(
              color: Theme.of(context).primaryColor,
              child: DrawerHeader(
                child: Center(
                    child: Text(
                        'Movies App',
                      style: TextStyle(fontSize: 24.0, color: Colors.white),
                    )
                ),
              ),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pop();
                updatePage(0 , 'Now Playing');
              },
              leading: Icon(Icons.play_arrow),
              title: Text('Now Playing'),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pop();
                updatePage(1 , 'Up Coming');
              },
              leading: Icon(Icons.access_alarms),
              title: Text('Up Coming'),
            )
          ],
        )
      ),
    );
  }
}