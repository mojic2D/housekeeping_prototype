import 'package:flutter/material.dart';

class Room {
  Room({
    @required this.number,
    @required this.isClean,
  })  : assert(number != null),
        assert(isClean != null);

  String number;
  bool isClean;
}