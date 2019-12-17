import 'dart:io';

import 'package:flutter/material.dart';

class Places {
  final File img;
  final String name;
  final double rating;
  final String desc;
  final String exp;

  Places({
    @required this.img,
    @required this.name,
    @required this.rating,
    @required this.desc,
    @required this.exp
  });
}
