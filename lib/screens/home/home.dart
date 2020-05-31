import 'dart:io';

import 'package:exia/models/places.dart';
import 'package:exia/new_place.dart';
import 'package:exia/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class Home extends StatelessWidget {
  // @override
  // Widget build(BuildContext context) {
  // return Container(
  //   child:  Scaffold(
  //     backgroundColor: Colors.brown [50],
  //     appBar: AppBar(
  //       title: Text('EXIA'),
  //       backgroundColor: Colors.brown[400],
  //       elevation: 0.0,
  //       actions: <Widget>[
  //         FlatButton.icon(
  //           icon: Icon(Icons.person),
  //           label: Text('logout'),
  //             await _auth.signOut();
  //           },
  //         ),
  //       ],
  //           onPressed: () async {
  //     ),
  //   ),
  // );
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Expenses Maintainer',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  List<Places> _places = [];
  int placeId = 0;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 2, vsync: this);
    getEntries();
  }

  Future<void> getEntries() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> ids = [];
    List<String> imgs = [];
    List<String> names = [];
    List<String> ratings = [];
    List<String> descs = [];
    List<String> exps = [];

    ids = prefs.getStringList("id");
    names = prefs.getStringList("name");
    imgs = prefs.getStringList("img");
    ratings = prefs.getStringList("rating");
    descs = prefs.getStringList("desc");
    exps = prefs.getStringList("exp");

    await new Future.delayed(const Duration(seconds: 1));
    setState(() {
      for (int i = 0; i < ids.length; i++) {
        File img_path = ((imgs[i]!="null")?File(imgs[i]):null);
        _places.add(Places(id: int.parse(ids[i]), img: img_path, name: names[i], rating: double.parse(ratings[i]), desc: descs[i], exp: exps[i]));
      }
    });
  }
  Future<void> setEntries() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> ids = [];
    List<String> imgs = [];
    List<String> names = [];
    List<String> ratings = [];
    List<String> descs = [];
    List<String> exps = [];
    for (int i = 0; i < _places.length; i++) {
      ids.add(_places[i].id.toString());
      if(_places[i].img == null) {
        imgs.add("null");
      } else {
        imgs.add(_places[i].img.path.toString());
      }
      names.add(_places[i].name.toString());
      ratings.add(_places[i].rating.toString());
      descs.add(_places[i].desc.toString());
      exps.add(_places[i].exp.toString());
    }
    prefs.setStringList("id", ids);
    prefs.setStringList("img", imgs);
    prefs.setStringList("name", names);
    prefs.setStringList("rating", ratings);
    prefs.setStringList("desc", descs);
    prefs.setStringList("exp", exps);
  }

  static final AuthService _auth = AuthService();
  final appBar = AppBar(
    title: Text('ExIa - Experience India'),
    backgroundColor: Color(0xff000a12),
    actions: <Widget>[
      FlatButton.icon(
        color: Colors.white,
        icon: Icon(Icons.person),
        label: Text(
          'logout',
        ),
        onPressed: () async {
          await _auth.signOut();
        },
      ),
    ],
  );

  void _addNewPlace(
      File txImg, String txName, double txRating, String txDesc, String txExp) {
    final newPlace = Places(
        id: placeId,
        img: txImg,
        name: txName,
        rating: txRating,
        desc: txDesc,
        exp: txExp);
    setState(() {
      _places.add(newPlace);
    });
    placeId += 1;
    setEntries();
  }

  void _startAddNewPlace(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewPlace(_addNewPlace),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _showDescModal(BuildContext ctx, int idx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(10),
            height: 400,
            child: SingleChildScrollView(
              child: Text(
                _places[idx].desc,
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
          ),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ExIa',
      home: Scaffold(
        appBar: appBar,
        backgroundColor: Color(0xff263238),
        body: ListView(
          children: <Widget>[
            Container(
              decoration: new BoxDecoration(color: Color(0xff4f5b62)),
              child: new TabBar(
                indicatorColor: Color(0xff48a999),
                controller: _controller,
                tabs: [
                  new Tab(
                    icon: const Icon(Icons.home),
                    text: 'Home',
                  ),
                  new Tab(
                    icon: const Icon(Icons.terrain),
                    text: 'Experience',
                  ),
                ],
              ),
            ),
            new Container(
                height: 580.0,
                child: TabBarView(
                  controller: _controller,
                  children: <Widget>[
                    _places.isEmpty
                        ? Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.white,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Empty! Looks like youre staying safe in your home :).',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemBuilder: (ctx, idx) {
                              return Card(
                                margin: EdgeInsets.all(10),
                                color: Colors.white,
                                child: InkWell(
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        height: 200,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        // color: Colors.amber,
                                        child: Image.asset(
                                            (_places[idx].img != null)
                                                ? _places[idx].img.path
                                                : "assets/images/landscape.jpg",
                                            fit: BoxFit.cover),
                                      ),
                                      Container(
                                        height: 50,
                                        color: Color(0xff004c40),
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: <Widget>[
                                                  Text(
                                                    _places[idx].name,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  Text(
                                                    _places[idx]
                                                        .rating
                                                        .toString(),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  IconButton(
                                                      icon: Icon(Icons.remove),
                                                      color: Colors.white,
                                                      onPressed: () {
                                                        setState(() {
                                                          _places.removeAt(idx);
                                                        });
                                                      }),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  onTap: () => _showDescModal(context, idx),
                                ),
                              );
                            },
                            itemCount: _places.length,
                          ),
                    Container(
                      color: Color(0xff263238),
                      child: ListView.builder(
                        itemBuilder: (ctx, idx) {
                          return Card(
                            margin: EdgeInsets.all(10),
                            color: Colors.white,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height: 50,
                                  color: Color(0xff004c40),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            Text(
                                              _places[idx].name,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            Text(
                                              _places[idx].rating.toString(),
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 100,
                                  child: SingleChildScrollView(
                                    child: Text(
                                      _places[idx].exp,
                                      style: TextStyle(),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                        itemCount: _places.length,
                      ),
                    )
                  ],
                )),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xff00796b),
          child: Icon(Icons.add),
          onPressed: () => _startAddNewPlace(context),
        ),
      ),
    );
  }
}
