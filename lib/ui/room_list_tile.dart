import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:housekeeping_prototype/models/floors_model.dart';
import 'package:housekeeping_prototype/pojo/room.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../api_calls.dart';

class RoomListTile extends StatefulWidget {
  RoomListTile({@required this.roomIndex, @required this.model});

  final FloorsModel model;
  final int roomIndex;

  @override
  _RoomListTileState createState() => _RoomListTileState();
}

class _RoomListTileState extends State<RoomListTile> {
  //bool isClean = false;

  Future<Response> _updateRoomStatus(int roomNumber, String isClean) async {
    var url =
        'http://25.110.41.176/housekeeping/soba_status.php?json={"soba":$roomNumber,"status":"$isClean"}';
    return await http.get(url);
  }

  showAlertDialog(BuildContext context, int roomIndex) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Potrebna potvrda!"),
      content: Text("Sigurno promjeniti stanje sobe $roomIndex?"),
      actions: [
        TextButton(
          child: Text("Prekini"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text("Potvrdi"),
          onPressed: () {
            Navigator.of(context).pop();
            _updateRoomStatusUI('D');
          },
        ),
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _updateRoomStatusUI(String status) async {
    print('_updateRoomStatusUI starts!');
    Response response = await _updateRoomStatus(widget.roomIndex, status);
    print('response.header=${response.headers}');
    print('response.body=${response.body}');
    Map<String, dynamic> httpResponse = jsonDecode(response.body);
    if (httpResponse['status'] == "200") {
      setState(() {
        widget.model.selectedFloor
            .roomByNumber(widget.roomIndex.toString())
            .isClean = status == "D" ? true : false;
      });
      if (status != 'N') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text(
            'Undo action?',
            textAlign: TextAlign.center,
          ),
          duration: const Duration(seconds: 5),
          action: SnackBarAction(
            label: 'UNDO',
            textColor: Colors.orange,
            onPressed: () {
              _updateRoomStatusUI('N');
            },
          ),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Room room =
        widget.model.selectedFloor.roomByNumber(widget.roomIndex.toString());
    return Container(
      height: 85,
      decoration: BoxDecoration(
        border: Border(
          //top: widget.roomIndex==0 ? BorderSide(width: 1.0, color: Colors.grey):BorderSide(width:0.0),
          left: BorderSide(width: 1.0, color: Colors.grey),
          right: BorderSide(width: 1.0, color: Colors.grey),
          bottom: BorderSide(width: 1.0, color: Colors.grey),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                //left: BorderSide(width: 1.0, color: Colors.grey),
                right: BorderSide(width: 1.0, color: Colors.grey),
                //bottom: BorderSide(width: 1.0, color: Colors.grey),
              ),
            ),
            width: 85,
            height: 85,
            child: Center(
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: room.isClean
                      ? Colors.lightGreen
                      : Colors.deepOrangeAccent,
                  border: Border.all(color: Colors.black38, width: 1.8),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Icon(
                  !room.isClean ? Icons.cleaning_services : Icons.check,
                  size: 40.0,
                ),
              ),
            ),
          ),
          Container(
              child: Text(
            'Soba ${widget.roomIndex}',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
            ),
          )),
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Container(
              height: 45,
              child: ElevatedButton(

                onPressed: room.isClean
                    ? null
                    : () => showAlertDialog(context, widget.roomIndex),
                child: Text(
                  'Očišćeno',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                    //color: Colors.white,
                  ),
                ),
                style: ButtonStyle(
                  //enableFeedback: false,
                  //animationDuration: Duration.zero,
                  backgroundColor:
                      MaterialStateProperty.all<Color>(room.isClean ? Colors.grey[300]:Colors.blue),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(room.isClean ? Colors.grey: Colors.white),
                ),
              ),
            ),
          ),
          // ElevatedButton(
          //   style: ElevatedButton.styleFrom(
          //     primary: Colors.red, // background
          //     onPrimary: Colors.white, // foreground
          //   ),
          //   onPressed: ()=>_updateRoomStatusUI('N'),
          //   child: Text('Prljavo'),
          // )
        ],
      ),
    );
  }
}
