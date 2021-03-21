import 'package:flutter/material.dart';
import 'package:housekeeping_prototype/pojo/room.dart';

class Floor{
  Floor({
    @required this.number,
  })  : assert(number != null);

  String number;
  List<Room> roomList;
}