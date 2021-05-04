import 'dart:async';

import 'package:flutter/material.dart';

import 'package:housekeeping_prototype/blocs/floors_bloc.dart';
import 'package:housekeeping_prototype/models/floors_model.dart';
import 'package:housekeeping_prototype/pojo/floor.dart';
import 'package:housekeeping_prototype/pojo/room.dart';
import 'package:housekeeping_prototype/services/authentication_service.dart';
import 'package:housekeeping_prototype/ui/floor_list_tile.dart';
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

  @override
  void initState() {
    firstTime = true;
    //widget.floorsBloc.model.selectedFloor=
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
    return Scaffold(
        appBar: AppBar(
          title: Text('HouseKeeping'),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute<void>(
                  builder: (context) => NotificationList(),
                ));
              },
              child: Icon(widget.floorsBloc.showingNotifications.value
                  ? Icons.menu
                  : Icons.notifications),
            ),
            ElevatedButton(
              onPressed: () => widget.floorsBloc.refreshData(),
              child: Icon(Icons.refresh_sharp),
            ),
            ElevatedButton(onPressed: () {
              context.read<AuthenticationService>().signOut();
            }, child: Icon(Icons.logout))
          ],
        ),
        body: StreamBuilder<FloorsModel>(
          stream: widget.floorsBloc.modelStream,
          // initialData: FloorsModel(
          //     selectedFloor: Floor(number: "1", roomList: <Room>[]),
          //     floorList: <Floor>[]),
          builder: (context, snapshot) {
            FloorsModel model =
                snapshot.data == null ? widget.floorsBloc.model : snapshot.data;

            if (snapshot.data == null) {
              return _buildCircularProgress();
            }

            //print('Starting streambuilder count!');
            // for(Room r in model.floorList[0].roomList){
            //   print('Room number: ${r.number} ; isClean: ${r.isClean}');
            // }

            Room room =
            model.selectedFloor.roomByNumber(105.toString());
            //rint('soba 5 je=${room.isClean}');
            return Provider<FloorsBloc>(

              create: (_)=>widget.floorsBloc,
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
                                onPressed: () =>
                                    widget.floorsBloc.changeFloor(index),
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
                        child: Consumer<FloorsBloc>(
                          builder: (context, floorsBloc, child){
                            return ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: model.selectedFloor.roomList.length,
                            itemBuilder: (context, index) {
                              //FloorsModel model1=Provider.of<FloorsBloc>(context).model;
                              Room room =
                              model.selectedFloor.roomByNumber(int.parse(
                                  model.selectedFloor.roomList[index].number).toString());
                              //print('Starting listview of RoomListTile!${room.number} ; ${room.isClean}');

                              return RoomListTile(
                                //model: model,
                                roomIndex: int.parse(
                                    model.selectedFloor.roomList[index].number),
                                //roomIndex: index,
                              );
                            },
                          );}
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ));
    ;
  }



  Center _buildCircularProgress() {
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
}
