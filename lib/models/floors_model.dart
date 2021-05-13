
import 'package:housekeeping_prototype/pojo/floor.dart';
import 'package:housekeeping_prototype/pojo/room.dart';

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
          if(f.number==selectedFloor.number){
            return floorList.indexOf(f);
          }
    }
  }

  bool hasRoomsForCleaning(String floorNumber){
    Floor floor;
    for(Floor f in floorList){
      if(f.number==floorNumber){
        floor=f;
      }
    }

    for(Room r in floor.roomList){
      if(!r.isClean){
        return true;
      }
    }
    return false;
  }

}