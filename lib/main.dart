import 'package:flutter/material.dart';
import 'package:housekeeping_prototype/ui/new_login_page.dart';
import 'package:housekeeping_prototype/ui/room_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      //home: RoomList(),
      home:NewLoginPage(),
    );
  }
}

