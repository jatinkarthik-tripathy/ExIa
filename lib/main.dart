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
  final List<Places> _places = [
    Places(img: "1", name: "test  ", rating: 6.9),
    Places(img: "2", name: "testing  ", rating: 6.9),
    Places(img: "3", name: "testing  ", rating: 6.9),
    Places(img: "4", name: "testing  ", rating: 6.9)
  ];
  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 2, vsync: this);
  }

  final appBar = AppBar(
    title: Text('ExIa - Experience India'),
    backgroundColor: Color(0xff000a12),
  );

  void _addNewPlace(String txImg, String txName, double txRating) {
    final newPlace = Places(
      img: txImg,
      name: txName,
      rating: txRating,
    );
    setState(() {
      _places.add(Places(img: "7", name: "last  ", rating: 6.9));
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
                    ListView.builder(
                      itemBuilder: (ctx, idx) {
                        return Card(
                          margin: EdgeInsets.all(10),
                          color: Colors.white,
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                                // color: Colors.amber,
                                child: Image.asset(
                                    'assets/images/bamboo_hat.PNG',
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
                              )
                            ],
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
                                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                                        style: TextStyle(),
                                      ),
                                    ))
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
