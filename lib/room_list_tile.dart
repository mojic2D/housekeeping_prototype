import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 1.0, color: Colors.black54),
          left: BorderSide(width: 4.0, color: Colors.grey),
          right: BorderSide(width: 4.0, color: Colors.grey),
          bottom: BorderSide(width: 1.0, color: Colors.black54),
        )
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
          Text('Soba ${widget.roomIndex}'),
          ElevatedButton(
            onPressed: _roomCleaned,
            child: Text('Očišćeno'),
          )
        ],
      ),
    );
  }
}
