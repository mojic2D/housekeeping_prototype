import 'dart:async';

import 'package:flutter/material.dart';

import 'package:housekeeping_prototype/blocs/floors_bloc.dart';
import 'package:housekeeping_prototype/models/floors_model.dart';
import 'package:housekeeping_prototype/pojo/floor.dart';
import 'package:housekeeping_prototype/pojo/room.dart';
import 'package:housekeeping_prototype/services/authentication_service.dart';
import 'package:housekeeping_prototype/ui/notification_list.dart';
import 'package:housekeeping_prototype/ui/room_list_tile.dart';
import 'package:provider/provider.dart';

class RoomList extends StatefulWidget {
  //ApiCalls calls = new ApiCalls();

  FloorsBloc floorsBloc = new FloorsBloc();

  @override
  _StateRoomList createState() => _StateRoomList();
}

class _StateRoomList extends State<RoomList> {
  bool firstTime;
  Timer timer;
  //FloorsBloc floorsBloc=new FloorsBloc();

  @override
  void initState() {
    firstTime = true;
    // floorsBloc=new FloorsBloc();
    widget.floorsBloc.refreshData();
    timer = Timer.periodic(
        Duration(seconds: 15), (Timer t) => widget.floorsBloc.refreshData());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    widget.floorsBloc.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    FloorsBloc floorsBloc=widget.floorsBloc;
    return Scaffold(
        appBar: AppBar(
          title: Text('HouseKeeping'),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () => floorsBloc.refreshData(),
              child: Icon(Icons.refresh_sharp),
            ),
            ElevatedButton(onPressed: () {
              context.read<AuthenticationService>().signOut();
            }, child: Icon(Icons.logout))
          ],
        ),
        body: StreamBuilder<FloorsModel>(
          stream: floorsBloc.modelStream,
          // initialData: FloorsModel(
          //     selectedFloor: Floor(number: "1", roomList: <Room>[]),
          //     floorList: <Floor>[]),
          builder: (context, snapshot) {
            //print('snapshot.data==null?=${snapshot.data == null}');
            final FloorsModel model =
                snapshot.data == null ? floorsBloc.model : snapshot.data;

            if (snapshot.data == null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: CircularProgressIndicator(),
                      width: 60,
                      height: 60,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Awaiting result...'),
                    )
                  ],
                ),
              );
            }

           // print('Soba 1 isClean = ${model.floorList[0].roomList[0].isClean}');

            return Provider<FloorsModel>(
              create: (context)=>model,
              child: Container(
                child: Column(
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
                            bool hasFloorsForCleaning = model.hasRoomsForCleaning(
                                model.floorList[index].toString());
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
                                            int.parse(model.selectedFloor.number) -
                                                        1 ==
                                                    index
                                                ? Colors.blue
                                                : Colors.white),
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            int.parse(model.selectedFloor.number) -
                                                        1 ==
                                                    index
                                                ? Colors.white
                                                : Colors.blue),
                                  ),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: hasFloorsForCleaning ? 16 : 0,
                                        ),
                                        Text(model.floorList[index].toString()),
                                        Icon(
                                          Icons.arrow_drop_down_circle,
                                          color: Colors.red,
                                          size: hasFloorsForCleaning ? 16 : 0,
                                        ),
                                      ]),
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).removeCurrentSnackBar();
                                      floorsBloc.changeFloor(index);},
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
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(width: 2.0, color: Colors.black54),
                              // left: BorderSide(width: 4.0, color: Colors.grey),
                              // right: BorderSide(width: 4.0, color: Colors.grey),
                              // bottom: BorderSide(width: 1.0, color: Colors.black54),
                            ),
                          ),
                          child: ListView.builder(
                            itemCount: model.selectedFloor.roomList.length,
                            itemBuilder: (context, index) {
                              //print('Soba 1 isClean = ${model.floorList[0].roomList[0].isClean}');
                              return RoomListTile(
                                floorsBloc: floorsBloc,
                                roomIndex: int.parse(
                                    model.selectedFloor.roomList[index].number),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
    ;
  }
}
