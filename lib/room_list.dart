import 'package:flutter/material.dart';
import 'package:housekeeping_prototype/api_calls.dart';
import 'package:housekeeping_prototype/room_list_tile.dart';

class RoomList extends StatelessWidget {

  ApiCalls calls=new ApiCalls();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HouseKeeping'),
        actions: <Widget>[
          ElevatedButton(
            child: Text("REFRESH"),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return RoomListTile(
            roomIndex: index,
          );
        },
      ),
    );
  }
}
