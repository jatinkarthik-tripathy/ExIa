import 'package:flutter/material.dart';

class NewPlace extends StatefulWidget {
  final Function addTx;

  NewPlace(this.addTx);

  @override
  _NewPlaceState createState() => _NewPlaceState();
}

class _NewPlaceState extends State<NewPlace> {
  final nameController = TextEditingController();
  final descController = TextEditingController();
  void _submitPlace() {
    widget.addTx("5", "dejagd", "9.6");
    Navigator.of(context).pop();
  }

  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: Color(0xff263238),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                style: TextStyle(color: Colors.white),
                cursorColor: Color(0xff48a999),
                decoration: InputDecoration(labelText: 'Place Name'),
                controller: nameController,
                onSubmitted: (_) => _submitPlace(),
              ),
              TextField(
                style: TextStyle(color: Colors.white),
                cursorColor: Color(0xff48a999),
                decoration: InputDecoration(labelText: 'Rating'),
                keyboardType: TextInputType.number,
                controller: nameController,
                onSubmitted: (_) => _submitPlace(),
              ),
              TextField(
                style: TextStyle(color: Colors.white),
                minLines: 5,
                maxLines: 10,
                decoration: InputDecoration(labelText: 'Description'),
                controller: descController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitPlace(),
              ),
              RaisedButton(
                child: Text('Add Entry'),
                onPressed: _submitPlace,
                color: Colors.amber,
              )
            ],
          ),
        ));
  }
}
