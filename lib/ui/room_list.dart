import 'package:flutter/material.dart';
import 'package:housekeeping_prototype/api_calls.dart';
import 'package:housekeeping_prototype/blocs/floors_bloc.dart';
import 'package:housekeeping_prototype/ui/floor_list_tile.dart';
import 'package:housekeeping_prototype/ui/room_list_tile.dart';

class RoomList extends StatelessWidget {
  ApiCalls calls = new ApiCalls();

  final FloorsBloc floorsBloc=new FloorsBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HouseKeeping'),
        actions: <Widget>[
          ElevatedButton(
            onPressed: ()=>floorsBloc.refreshData(),
            child: Text("REFRESH"),
          )
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical:8.0),
            child: Container(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 7,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      //decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0), border: Border.all(color: Colors.grey,width: 3.5,style: BorderStyle.solid, ),),
                      width: 100,
                      //color: Colors.blueGrey,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: Colors.blue,width: 2.2),
                                )
                            ),
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                        ),
                        child: Text("001"),
                        onPressed: (){},
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            child: Expanded(
              flex: 1,
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  return RoomListTile(
                    roomIndex: index,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
