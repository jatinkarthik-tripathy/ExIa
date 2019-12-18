import 'package:exia/screens/authenticate/authenticate.dart';
import 'package:exia/screens/home/home.dart';
import 'package:exia/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    // return either the Home or Authenticate widget


    // return either the Home or Authenticate widget
    if (user == null){
      return Authenticate();
    } else {
      return Home();
    }

  }
}