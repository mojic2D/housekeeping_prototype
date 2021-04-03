import 'dart:async';
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:housekeeping_prototype/models/app_model.dart';
import 'package:housekeeping_prototype/models/floors_model.dart';
import 'package:housekeeping_prototype/pojo/floor.dart';
import 'package:housekeeping_prototype/pojo/room.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class FloorsBloc {
  //final ApiCalls apiCalls=new ApiCalls();

  final StreamController<FloorsModel> _modelController =
      StreamController<FloorsModel>();
  Stream<FloorsModel> get modelStream => _modelController.stream.asBroadcastStream();
  FloorsModel model = FloorsModel();
  //AppModel appModel=AppModel();
  ValueNotifier<bool> showingNotifications = ValueNotifier(false);

  void dispose() {
    _modelController.close();
  }

  Future<void> refreshData() async {
    List<Floor> floorNumList = <Floor>[];

    Response response = await _readRegRoom();
    List<dynamic> roomList = jsonDecode(response.body);
    //List<dynamic> roomList = jsonDecode(json);
    for (var i = 0; i < roomList.length; i++) {
      String floorNumber = roomList[i]['sprat'].toString();
      String roomNumber = roomList[i]['sifra'].toString();
      bool isClean = roomList[i]['status'].toString() == 'D' ? true : false;

      // print('floorNumber:'+floorNumber);
      // print('roomNumber:'+roomNumber);
      print('refreshed');

      bool contains = false;
      Floor tempFloor;
      for (Floor f in floorNumList) {
        if (f.toString() == floorNumber) {
          contains = true;
          tempFloor = f;
        }
      }
      if (!contains) {
        tempFloor = Floor(number: floorNumber,roomList:<Room>[]);
        floorNumList.add(tempFloor);
      }

      floorNumList[floorNumList.indexOf(tempFloor)]
          .roomList
          .add(Room(number: roomNumber, isClean: isClean));
    }
    model.floorList = floorNumList;
    model.selectedFloor=model.floorList[0];
    _modelController.add(model);
  }

  void changeFloor(int floorIndex){
    model.selectedFloor=model.floorList[floorIndex];
    _modelController.add(model);
  }

  Future<Response> _readRegRoom() async {
    //var url = 'http://25.110.41.176/housekeeping/soba.php';//srecko
    var url = 'http://25.107.64.34/housekeeping/soba.php';//kuca
    return await http.get(url);
  }

  String json='[{"floor":"1","room":"101","isClean":"N"},{"floor":"1","room":"102","isClean":"D"},{"floor":"2","room":"201","isClean":"D"},{"floor":"2","room":"202","isClean":"D"},{"floor":"3","room":"301","isClean":"D"},{"floor":"3","room":"302","isClean":"D"},{"floor":"4","room":"401","isClean":"D"},{"floor":"4","room":"402","isClean":"D"}]';

}
//http://25.110.41.176/housekeeping/soba.php
