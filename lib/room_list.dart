import 'package:flutter/material.dart';
import 'package:housekeeping_prototype/room_list_tile.dart';

class RoomList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HouseKeeping'),
      ),
      body:
         ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) {
            return RoomListTile(roomIndex: index,);
          },
        ),

    );
  }
}
