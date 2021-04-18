import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:housekeeping_prototype/services/authentication_service.dart';
import 'package:housekeeping_prototype/ui/room_list.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

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

  String getMessageFromErrorCode(String errorCode) {
    switch (errorCode) {
      case "ERROR_EMAIL_ALREADY_IN_USE":
      case "account-exists-with-different-credential":
      case "email-already-in-use":
        //return "Email already used. Go to login page.";
        return 'Email je iskorisen. Idi na login stranicu.';
        break;
      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
        //return "Wrong email/password combination.";
        return 'Pogresna kombinacija email/password';
        break;
      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
        //return "No user found with this email.";
        return 'Ne postoji korisnik pod unesenim emailom.';
        break;
      case "ERROR_USER_DISABLED":
      case "user-disabled":
        //return "User disabled.";
        return 'Korisnik je ugasen.';
        break;
      case "ERROR_TOO_MANY_REQUESTS":
      case "operation-not-allowed":
        //return "Too many requests to log into this account.";
        return 'Previse pokusaja za login.';
        break;
      case "ERROR_OPERATION_NOT_ALLOWED":
      case "operation-not-allowed":
        //return "Server error, please try again later.";
        return 'Greska na serveru, pokusajte opet kasnije.';
        break;
      case "ERROR_INVALID_EMAIL":
      case "invalid-email":
        //return "Email address is invalid.";
        return 'Pogresna email adresa.';
        break;
      default:
        //return "Login failed. Please try again.";
        return 'Neuspjeli login. Pokusajte ponovo.';
        break;
    }
  }

  void _showToastError(String errorCode) {
    String errorMessage = getMessageFromErrorCode(errorCode);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        getMessageFromErrorCode(errorCode),
        textAlign: TextAlign.center,
      ),
      duration: const Duration(seconds: 5),
    ));
  }

  void _showToast(int statusCode) {
    if (statusCode == 404) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text(
          'Greska!',
          textAlign: TextAlign.center,
        ),
        duration: const Duration(seconds: 5),
      ));
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text(
        'Neispravni podaci!',
        textAlign: TextAlign.center,
      ),
      duration: const Duration(seconds: 5),
    ));
  }

  _submit() async {
    Response response =
        // await http.get("http://25.107.64.34/housekeeping/korisnik.php");//kuca
        await http.get(Uri.parse(
            "http://25.110.41.176/housekeeping/korisnik.php")); //srecko

    if (response.statusCode == 404) {
      _showToast(404);
      return;
    }
    List<dynamic> userList = jsonDecode(response.body);

    bool userExists = false;

    for (int i = 0; i < userList.length; i++) {
      if (usernameController.text == userList[i]['user_name'].toString() &&
          passwordController.text == userList[i]['user_pass'].toString()) {
        userExists = true;
        break;
      }
    }

    if (userExists) {
      Navigator.of(context).push(MaterialPageRoute<void>(
        builder: (context) => RoomList(),
      ));
    } else {
      _showToast(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('HouseKeeping'),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        color: Colors.white,
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            Container(
              width: 350,
              height: 400,
              decoration: BoxDecoration(
                color: Color.fromRGBO(240, 240, 240, 1.0),
                border: Border(
                  top: BorderSide(
                    width: 2.0,
                    color: Color.fromRGBO(217, 217, 217, 1.0),
                  ),
                  left: BorderSide(
                      width: 2.0, color: Color.fromRGBO(217, 217, 217, 1.0)),
                  right: BorderSide(
                      width: 2.0, color: Color.fromRGBO(217, 217, 217, 1.0)),
                  bottom: BorderSide(
                      width: 2.0, color: Color.fromRGBO(217, 217, 217, 1.0)),
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
                      style:
                          TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
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
                      style:
                          TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
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
                    //onPressed: _submit,
                    onPressed: () async {
                      String result =
                          await context.read<AuthenticationService>().signIn(
                                email: usernameController.text.trim(),
                                password: passwordController.text.trim(),
                              );
                      if (result != 'Success') {
                        _showToastError(result);
                      }
                    },
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
