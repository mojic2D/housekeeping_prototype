
import 'package:housekeeping_prototype/pojo/floor.dart';

class FloorsModel{
  FloorsModel({this.selectedFloor,this.floorList,}){
      if(selectedFloor==null&&floorList!=null){
        selectedFloor=floorList[0];
      }
  }

  Floor selectedFloor;
  List<Floor> floorList;

  int indexOfSelectedFloor(){
    for(Floor f in floorList){
          if(f.number==selectedFloor){
            return floorList.indexOf(f);
          }
    }
  }

}