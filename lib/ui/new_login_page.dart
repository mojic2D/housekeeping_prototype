import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:housekeeping_prototype/ui/room_list.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class NewLoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewLoginPageState();
}

class _NewLoginPageState extends State<NewLoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  _submit() async {
    Response response =
        await http.get("http://25.110.41.176/housekeeping/korisnik.php");
    List<dynamic> userList = jsonDecode(response.body);
    for (int i = 0; i < userList.length; i++) {
      if (usernameController.text == userList[i]['user_name'].toString() &&
          passwordController.text == userList[i]['user_pass'].toString()) {
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
        resizeToAvoidBottomInset:false,
        appBar: AppBar(
        title: Text('HouseKeeping'),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        color:Colors.white,
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height:50),
            Container(
              width: 350,
              height: 400,
              decoration: BoxDecoration(
                color: Color.fromRGBO(240, 240, 240, 1.0),
                border: Border(
                  top: BorderSide(width: 2.0, color: Color.fromRGBO(217, 217, 217, 1.0),),
                  left: BorderSide(width: 2.0, color: Color.fromRGBO(217, 217, 217, 1.0)),
                  right: BorderSide(width: 2.0, color: Color.fromRGBO(217, 217, 217, 1.0)),
                  bottom: BorderSide(width: 2.0, color: Color.fromRGBO(217, 217, 217, 1.0)),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    child: LayoutBuilder(builder: (context, constraint) {
                      return new Icon(Icons.house_siding_rounded,
                          size: constraint.biggest.height);
                    }),
                  ),
                  Container(
                    width: 310,
                    child: TextField(
                      controller: usernameController,
                      obscureText: false,
                      style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "Username",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: 310,
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "Password",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    child: Text('Log in!'),
                    onPressed: _submit,
                  ),
                ],
              ),
            ),
            //SizedBox(height:120)
          ],
        ),
      ),
    );
  }
}
