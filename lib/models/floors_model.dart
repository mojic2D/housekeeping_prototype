
import 'package:housekeeping_prototype/pojo/floor.dart';

class FloorsModel{
  FloorsModel({this.selectedFloor,this.floorList,}){
      if(selectedFloor==null&&floorList!=null){
        selectedFloor=floorList[0].number;
      }
  }

  String selectedFloor;
  List<Floor> floorList;
}