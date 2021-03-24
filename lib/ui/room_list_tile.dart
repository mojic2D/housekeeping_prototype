import 'package:flutter/material.dart';
import 'package:housekeeping_prototype/models/floors_model.dart';
import 'package:housekeeping_prototype/pojo/room.dart';

import '../api_calls.dart';

class RoomListTile extends StatefulWidget {
  RoomListTile({@required this.roomIndex,@required this.model});

  final FloorsModel model;
  final int roomIndex;

  @override
  _RoomListTileState createState() => _RoomListTileState();
}

class _RoomListTileState extends State<RoomListTile> {
  bool isClean = false;


  _roomCleaned() {
    setState(() {
      widget.model.selectedFloor.roomByNumber(widget.roomIndex.toString()).isClean = true;
    });
  }

  _roomDirty() {
    setState(() {
      widget.model.selectedFloor.roomByNumber(widget.roomIndex.toString()).isClean = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Room room=widget.model.selectedFloor.roomByNumber(widget.roomIndex.toString());
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: widget.roomIndex==0?4.0:1.0, color: Colors.black54),
          left: BorderSide(width: 4.0, color: Colors.grey),
          right: BorderSide(width: 4.0, color: Colors.grey),
          bottom: BorderSide(width: 1.0, color: Colors.black54),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 100,
            height: 100,
            color: room.isClean? Colors.lightGreen : Colors.deepOrangeAccent,
            child: Icon(!room.isClean ? Icons.cleaning_services : Icons.check),
          ),
          Text('Soba ${widget.roomIndex + 1}'),
          ElevatedButton(
            onPressed: _roomCleaned,
            child: Text('Očišćeno'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.red, // background
              onPrimary: Colors.white, // foreground
            ),
            onPressed: _roomDirty,
            child: Text('Prljavo'),
          )
        ],
      ),
    );
  }
}
