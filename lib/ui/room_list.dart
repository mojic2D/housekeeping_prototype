import 'package:flutter/material.dart';
import 'package:housekeeping_prototype/api_calls.dart';
import 'package:housekeeping_prototype/blocs/floors_bloc.dart';
import 'package:housekeeping_prototype/models/floors_model.dart';
import 'package:housekeeping_prototype/pojo/floor.dart';
import 'package:housekeeping_prototype/pojo/room.dart';
import 'package:housekeeping_prototype/ui/floor_list_tile.dart';
import 'package:housekeeping_prototype/ui/room_list_tile.dart';

class RoomList extends StatelessWidget {
  ApiCalls calls = new ApiCalls();

  final FloorsBloc floorsBloc = new FloorsBloc();

  @override
  Widget build(BuildContext context) {
    floorsBloc.refreshData();
    return Scaffold(
      appBar: AppBar(
        title: Text('HouseKeeping'),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () => floorsBloc.refreshData(),
            child: Text("REFRESH"),
          )
        ],
      ),
      body: StreamBuilder<FloorsModel>(
          stream: floorsBloc.modelStream,
          initialData: FloorsModel(selectedFloor:Floor(number:"1",roomList:<Room>[]),floorList:<Floor>[]),
          builder: (context, snapshot) {
            final FloorsModel model = snapshot.data;
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    height: 40,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: model.floorList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            //decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0), border: Border.all(color: Colors.grey,width: 3.5,style: BorderStyle.solid, ),),
                            width: 100,
                            //color: Colors.blueGrey,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(
                                      color: Colors.blue, width: 2.2),
                                )),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        int.parse(model.selectedFloor.number)-1==index?Colors.blue:Colors.white),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        int.parse(model.selectedFloor.number)-1==index?Colors.white:Colors.blue),
                              ),
                              child: Text(model.floorList[index].toString()),
                              onPressed: () => floorsBloc.changeFloor(index),
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
                      itemCount: model.selectedFloor.roomList.length,
                      itemBuilder: (context, index) {
                        return RoomListTile(
                          model:model,
                          roomIndex: int.parse(model.selectedFloor.roomList[index].number),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
