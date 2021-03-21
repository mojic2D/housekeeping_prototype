import 'dart:async';
import 'dart:convert';
import 'package:housekeeping_prototype/models/floors_model.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class FloorsBloc{

  //final ApiCalls apiCalls=new ApiCalls();

  final StreamController<FloorsModel> _modelController=StreamController<FloorsModel>();
  Stream<FloorsModel> get modelStream=>_modelController.stream;
  FloorsModel _model=FloorsModel();

  void dispose(){
    _modelController.close();
  }

  Future<void> refreshData() async{


    List<String> floorNumList=<String>[];


    Response response=await _readRegRoom();
    List<dynamic> roomList=jsonDecode(response.body);
    for(var i=0;i<roomList.length;i++){
      //print(roomList[i]);
      if(!floorNumList.contains(roomList[i]['sprat'].toString())){
        floorNumList.add(roomList[i]['sprat'].toString());
      }
    }
    print(floorNumList);
    //TODO!
    //_model.floorList=floorNumList;
    //_model.selectedFloor=
  }

  Future<Response> _readRegRoom()async{
    var url =
        'http://25.110.41.176/housekeeping/soba.php';
    return await http.get(url);
  }


}
//http://25.110.41.176/housekeeping/soba.php