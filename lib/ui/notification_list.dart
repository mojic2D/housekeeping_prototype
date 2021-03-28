import 'package:flutter/material.dart';

class NotificationList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifikacije'),
      ),
      body: ListView.builder(itemCount:3,itemBuilder: (context, index){
        return Container(
          height:60,
          decoration: BoxDecoration(
            border: Border(
              //top: widget.roomIndex==0 ? BorderSide(width: 1.0, color: Colors.grey):BorderSide(width:0.0),
              left: BorderSide(width: 1.0, color: Colors.grey),
              right: BorderSide(width: 1.0, color: Colors.grey),
              bottom: BorderSide(width: 1.0, color: Colors.grey),
            ),
          ),
          child: Text("NOTIFIKACIJA $index",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),)
        );
      }),
    );
  }
}
