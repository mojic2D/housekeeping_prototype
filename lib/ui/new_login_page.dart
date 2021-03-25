import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:housekeeping_prototype/ui/room_list.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class NewLoginPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState()=>_NewLoginPageState();

}

class _NewLoginPageState extends State<NewLoginPage>{

  final usernameController=TextEditingController();
  final passwordController=TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  _submit() async{

    Response response=await http.get("http://25.110.41.176/housekeeping/korisnik.php");
    List<dynamic> userList=jsonDecode(response.body);
    for(int i=0;i<userList.length;i++){
      if(usernameController.text==userList[i]['user_name'].toString()
          &&passwordController.text==userList[i]['user_pass'].toString()){
        Navigator.of(context).push(MaterialPageRoute<void>(
          builder: (context) => RoomList(),
        ));
        break;
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HouseKeeping'),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(height:150,width:150,child: LayoutBuilder(builder: (context, constraint) {
              return new Icon(Icons.house_siding_rounded, size: constraint.biggest.height);
            }),),
            TextField(
              controller: usernameController,
              obscureText: false,
              style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  hintText: "Username",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0))),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  hintText: "Password",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0))),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              child: Text('Log in!'),
              onPressed: _submit ,
            ),
          ],
        ),
      ),
    );
  }
}
