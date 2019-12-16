import 'package:flutter/material.dart';

class NewPlace extends StatefulWidget {
  final Function addTx;

  NewPlace(this.addTx);

  @override
  _NewPlaceState createState() => _NewPlaceState();
}

class _NewPlaceState extends State<NewPlace> {
  void _submitPlace() {
    widget.addTx("5", "dejagd", "9.6");
    Navigator.of(context).pop();
  }

  Widget build(BuildContext context) {
    return Container(
        color: Color(0xff263238),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              
            ],
          ),
        ));
  }
}
