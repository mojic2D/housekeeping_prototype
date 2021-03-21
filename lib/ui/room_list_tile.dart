import 'package:flutter/material.dart';

import '../api_calls.dart';

class RoomListTile extends StatefulWidget {
  RoomListTile({@required this.roomIndex});

  final int roomIndex;

  @override
  _RoomListTileState createState() => _RoomListTileState();
}

class _RoomListTileState extends State<RoomListTile> {
  bool isClean = false;

  _roomCleaned() {
    setState(() {
      isClean = true;
    });
  }

  _roomDirty() {
    setState(() {
      isClean = false;
    });
  }

  @override
  Widget build(BuildContext context) {
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
            color: isClean ? Colors.lightGreen : Colors.deepOrangeAccent,
            child: Icon(!isClean ? Icons.cleaning_services : Icons.check),
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
