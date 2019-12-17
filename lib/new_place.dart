import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class NewPlace extends StatefulWidget {
  final Function addTx;

  NewPlace(this.addTx);

  @override
  _NewPlaceState createState() => _NewPlaceState();
}

class _NewPlaceState extends State<NewPlace> {
  final nameController = TextEditingController();
  final descController = TextEditingController();
  final expController = TextEditingController();

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
        color: Colors.white,
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
              TextField(
                style: TextStyle(color: Colors.white),
                minLines: 5,
                maxLines: 10,
                decoration: InputDecoration(labelText: 'Experience'),
                controller: expController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitPlace(),
              ),
              // ImageCapture(),
              RaisedButton(
                child: Text(
                  'Add Entry',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: _submitPlace,
                color: Color(0xff00796b),
              )
            ],
          ),
        ));
  }
}

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
