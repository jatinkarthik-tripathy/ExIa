import 'dart:io';

import 'package:exia/new_place.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './models/places.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
  final List<Places> _places = [];
  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 2, vsync: this);
  }

  final appBar = AppBar(
    title: Text('ExIa - Experience India'),
    backgroundColor: Color(0xff000a12),
  );

  void _addNewPlace(
      File txImg, String txName, double txRating, String txDesc, String txExp) {
    final newPlace = Places(
        img: txImg, name: txName, rating: txRating, desc: txDesc, exp: txExp);
    setState(() {
      _places.add(newPlace);
      print(_places);
    });
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
                            child: Text(
                              'No Transactions Done Yet!',
                              style: TextStyle(
                                fontSize: 20,
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
                                                    CrossAxisAlignment.start,
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
