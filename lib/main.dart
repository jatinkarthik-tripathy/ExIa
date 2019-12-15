import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 2, vsync: this);
  }

  final appBar = AppBar(
    title: Text('ExIa - Experience India'),
    backgroundColor: Color(0xff000a12),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ExIa',
      home: Scaffold(
        appBar: appBar,
        backgroundColor: Color(0xff263238),
        body: new Container(
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
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xff00796b),
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
