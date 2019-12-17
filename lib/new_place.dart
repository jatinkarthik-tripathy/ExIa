import 'dart:async';
import 'dart:core';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageCapture extends StatefulWidget {
  createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
  File _imageFile;
  Future<void> _pickImage(ImageSource src) async {
    File selected = await ImagePicker.pickImage(source: src);
    setState(() {
      _imageFile = selected;
    });
  }

  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
      sourcePath: _imageFile.path,
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: 'Cropper',
        toolbarColor: Colors.white,
        toolbarWidgetColor: Color(0xff00796b),
      ),
    );
    setState(() {
      _imageFile = cropped ?? _imageFile;
    });
  }

  void _clear() {
    setState(() {
      _imageFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.photo_camera),
              onPressed: () => _pickImage(ImageSource.camera),
            ),
            IconButton(
              icon: Icon(Icons.photo_album),
              onPressed: () => _pickImage(ImageSource.gallery),
            ),
            IconButton(
              icon: Icon(Icons.done),
              onPressed: () => Navigator.pop(context, _imageFile),
            ),
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          if (_imageFile != null) ...[
            Image.file(_imageFile),
            Row(
              children: <Widget>[
                FlatButton(
                  child: Icon(Icons.crop),
                  onPressed: () => _cropImage,
                ),
                FlatButton(
                  child: Icon(Icons.clear),
                  onPressed: _clear,
                ),
              ],
            ),
          ]
        ],
      ),
    );
  }
}

class NewPlace extends StatefulWidget {
  final Function addTx;

  NewPlace(this.addTx);

  @override
  _NewPlaceState createState() => _NewPlaceState();
}

class _NewPlaceState extends State<NewPlace> {
  final nameController = TextEditingController();
  final ratingController = TextEditingController();
  final descController = TextEditingController();
  final expController = TextEditingController();
  File _img = null;
  void submitPlace() {
    widget.addTx(_img, nameController.text, double.parse(ratingController.text),
        descController.text, expController.text);
    Navigator.of(context).pop();
  }

  void goToSecondScreen() async {
    _img = await Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (BuildContext context) => new ImageCapture(),
      ),
    );
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
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                style: TextStyle(color: Colors.black),
                cursorColor: Color(0xff48a999),
                decoration: InputDecoration(labelText: 'Place Name'),
                controller: nameController,
                onSubmitted: (_) => submitPlace(),
              ),
              TextField(
                style: TextStyle(color: Colors.black),
                cursorColor: Color(0xff48a999),
                decoration: InputDecoration(labelText: 'Rating'),
                keyboardType: TextInputType.number,
                controller: ratingController,
                onSubmitted: (_) => submitPlace(),
              ),
              TextField(
                style: TextStyle(color: Colors.black),
                minLines: 5,
                maxLines: 10,
                decoration: InputDecoration(labelText: 'Description'),
                controller: descController,
                onSubmitted: (_) => submitPlace(),
              ),
              TextField(
                style: TextStyle(color: Colors.black),
                minLines: 5,
                maxLines: 10,
                decoration: InputDecoration(labelText: 'Experience'),
                controller: expController,
                onSubmitted: (_) => submitPlace(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly  ,
                children: <Widget>[
                  RaisedButton(
                    child: Text(
                      'Add Photo',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () => goToSecondScreen(),
                    color: Color(0xff00796b),
                  ),
                  RaisedButton(
                    child: Text(
                      'Add Entry',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: submitPlace,
                    color: Color(0xff00796b),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
