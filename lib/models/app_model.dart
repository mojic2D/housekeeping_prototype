import 'package:housekeeping_prototype/pojo/user.dart';

class AppModel{

  AppModel({this.currentUser,this.showingNotifications,}){
    if(showingNotifications==null){
      showingNotifications=false;
    }
  }

  User currentUser;
  bool showingNotifications;

}